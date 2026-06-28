using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using online_mr_certi.Data;
using online_mr_certi.Filters;
using online_mr_certi.Infrastructure;
using online_mr_certi.Models;
using online_mr_certi.Models.ViewModels;

namespace online_mr_certi.Controllers;

[RequireLogin]
[RequireUserRole]

public class ApplicationsController : Controller
{
    private static readonly string[] AllowedExtensions = [".pdf", ".jpg", ".jpeg", ".png", ".webp"];
    private static readonly string[] ReceiptImageExtensions = [".jpg", ".jpeg", ".png"];
    private const long MaxFileBytes = 10 * 1024 * 1024;

    private readonly AppDbContext _db;
    private readonly IWebHostEnvironment _env;
    private readonly ManualPaymentOptions _manualPayment;

    public ApplicationsController(
        AppDbContext db,
        IWebHostEnvironment env,
        IOptions<ManualPaymentOptions> manualPayment)
    {
        _db = db;
        _env = env;
        _manualPayment = manualPayment.Value;
    }

    public async Task<IActionResult> Index()
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var list = await _db.MarriageApplications.AsNoTracking()
            .Include(a => a.Appointments)
            .ThenInclude(ap => ap.TimeSlot)
            .Include(a => a.Payment)
            .ThenInclude(p => p!.Fee)
            .Where(a => a.UserId == userId)
            .OrderByDescending(a => a.SubmissionDate)
            .ThenBy(a => a.Id)
            .ToListAsync();
        return View(list);
    }

    [HttpGet]
    public async Task<IActionResult> Create()
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;

        // Hubi haddii user-ku hore application u leeyahay oo aan Rejected ahayn
        var existing = await _db.MarriageApplications
            .AsNoTracking()
            .Where(a => a.UserId == userId && a.Status != ApplicationStatus.Rejected)
            .OrderByDescending(a => a.Id)
            .FirstOrDefaultAsync();

        if (existing != null)
        {
            TempData["BlockedMessage"] = existing.Status;
            TempData["BlockedAppId"] = existing.Id;
            return RedirectToAction(nameof(Index));
        }

        return View(new MarriageApplicationCreateViewModel
        {
            HusbandDob = DateTime.Today.AddYears(-30),
            WifeDob = DateTime.Today.AddYears(-28),
            MarriageDate = DateTime.Today,
            Witness1 = { DateOfBirth = DateTime.Today.AddYears(-35) },
            Witness2 = { DateOfBirth = DateTime.Today.AddYears(-40) }
        });
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(MarriageApplicationCreateViewModel model)
    {
        if (!ModelState.IsValid)
            return View(model);

        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;

        // Double-check: ka hortagga race condition
        var existing = await _db.MarriageApplications
            .Where(a => a.UserId == userId && a.Status != ApplicationStatus.Rejected)
            .FirstOrDefaultAsync();

        if (existing != null)
        {
            TempData["BlockedMessage"] = existing.Status;
            TempData["BlockedAppId"] = existing.Id;
            return RedirectToAction(nameof(Index));
        }

        var app = new MarriageApplication
        {
            UserId = userId,
            HusbandName = model.HusbandName.Trim(),
            HusbandDob = model.HusbandDob.Date,
            HusbandIdNumber = model.HusbandIdNumber.Trim(),
            HusbandContactNumber = string.IsNullOrWhiteSpace(model.HusbandContactNumber) ? "—" : model.HusbandContactNumber.Trim(),
            HusbandAddress = model.HusbandAddress.Trim(),
            HusbandMotherName = model.HusbandMotherName?.Trim(),
            HusbandOccupation = model.HusbandOccupation?.Trim(),
            HusbandMaritalStatus = model.HusbandMaritalStatus.ToLabel(),
            HusbandReligion = model.HusbandReligion?.Trim(),
            HusbandNationality = model.HusbandNationality?.Trim(),
            HusbandResidenceStatus = model.HusbandResidenceStatus?.ToString(),
            WifeName = model.WifeName.Trim(),
            WifeDob = model.WifeDob.Date,
            WifeIdNumber = model.WifeIdNumber.Trim(),
            WifeContactNumber = string.IsNullOrWhiteSpace(model.WifeContactNumber) ? "—" : model.WifeContactNumber.Trim(),
            WifeAddress = model.WifeAddress.Trim(),
            WifeMotherName = model.WifeMotherName?.Trim(),
            WifeOccupation = model.WifeOccupation?.Trim(),
            WifeMaritalStatus = model.WifeMaritalStatus.ToLabel(),
            WifeReligion = model.WifeReligion?.Trim(),
            WifeNationality = model.WifeNationality?.Trim(),
            WifeResidenceStatus = model.WifeResidenceStatus?.ToString(),
            MarriageDate = model.MarriageDate.Date,
            MarriageLocation = model.MarriageLocation.Trim(),
            District = model.District?.Trim(),
            SheikhName = model.SheikhName?.Trim(),
            MarriageType = model.MeherType.ToLabel(),
            Meher = model.Meher?.Trim(),
            Status = ApplicationStatus.PendingPayment,
            SubmissionDate = DateTime.UtcNow
        };

        _db.MarriageApplications.Add(app);
        await _db.SaveChangesAsync();

        _db.MarriageWitnesses.AddRange(
            new MarriageWitness
            {
                ApplicationId = app.Id,
                SortOrder = 1,
                FullName = model.Witness1.FullName.Trim(),
                MotherName = model.Witness1.MotherName?.Trim(),
                DateOfBirth = model.Witness1.DateOfBirth.Date,
                IdNumber = model.Witness1.IdNumber.Trim(),
                ContactNumber = string.IsNullOrWhiteSpace(model.Witness1.ContactNumber) ? "—" : model.Witness1.ContactNumber.Trim(),
                Address = model.Witness1.Address.Trim()
            },
            new MarriageWitness
            {
                ApplicationId = app.Id,
                SortOrder = 2,
                FullName = model.Witness2.FullName.Trim(),
                MotherName = model.Witness2.MotherName?.Trim(),
                DateOfBirth = model.Witness2.DateOfBirth.Date,
                IdNumber = model.Witness2.IdNumber.Trim(),
                ContactNumber = string.IsNullOrWhiteSpace(model.Witness2.ContactNumber) ? "—" : model.Witness2.ContactNumber.Trim(),
                Address = model.Witness2.Address.Trim()
            });
        await _db.SaveChangesAsync();

        var fee = await _db.Fees.AsNoTracking()
            .Where(f => f.IsActive)
            .OrderBy(f => f.Id)
            .FirstOrDefaultAsync();
        if (fee is null)
        {
            ModelState.AddModelError(string.Empty,
                "Application fees are not configured. Please contact the administrator.");
            _db.MarriageApplications.Remove(app);
            await _db.SaveChangesAsync();
            return View(model);
        }

        _db.Payments.Add(new Payment
        {
            ApplicationId = app.Id,
            UserId = userId,
            FeeId = fee.Id,
            Amount = fee.Amount,
            PaymentStatus = PaymentStatuses.Pending,
            PaymentDate = null,
            ReceiptImage = null,
            CreatedAt = DateTime.UtcNow
        });
        await _db.SaveChangesAsync();

        var uploadsRoot = Path.Combine(_env.WebRootPath, "uploads", "documents");
        Directory.CreateDirectory(uploadsRoot);

        var labeledUploads = new (IFormFile File, string Category, string ModelKey)[]
        {
            (model.HusbandIdentityDocument!,  DocumentCategories.HusbandIdentityDocument,  nameof(model.HusbandIdentityDocument)),
            (model.WifeIdentityDocument!,      DocumentCategories.WifeIdentityDocument,      nameof(model.WifeIdentityDocument)),
            (model.Witness1IdentityDocument!,  DocumentCategories.Witness1IdentityDocument,  nameof(model.Witness1IdentityDocument)),
            (model.Witness2IdentityDocument!,  DocumentCategories.Witness2IdentityDocument,  nameof(model.Witness2IdentityDocument))
        };

        foreach (var (file, category, key) in labeledUploads)
        {
            if (!await TrySaveApplicationDocumentAsync(app.Id, file, category, key))
            {
                _db.MarriageApplications.Remove(app);
                await _db.SaveChangesAsync();
                return View(model);
            }
        }

        if (model.UploadedFiles is { Count: > 0 })
        {
            foreach (var file in model.UploadedFiles.Where(f => f.Length > 0))
            {
                if (!await TrySaveApplicationDocumentAsync(app.Id, file, DocumentCategories.Supporting,
                        nameof(model.UploadedFiles)))
                {
                    _db.MarriageApplications.Remove(app);
                    await _db.SaveChangesAsync();
                    return View(model);
                }
            }
        }

        TempData["Message"] = "Your application was submitted successfully. Complete payment to continue.";
        return RedirectToAction(nameof(Checkout), new { id = app.Id });
    }

    public async Task<IActionResult> Details(int id)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications
            .Include(a => a.Documents)
            .Include(a => a.Witnesses)
            .Include(a => a.Certificate)
            .Include(a => a.Appointments)
            .ThenInclude(ap => ap.TimeSlot)
            .Include(a => a.Payment)
            .ThenInclude(p => p!.Fee)
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);
        if (app is null)
            return NotFound();

        if (AppointmentWorkflow.IsPaymentStepComplete(app.Payment)
            && AppointmentWorkflow.NeedsAppointmentBooking(app)
            && !AppointmentWorkflow.HasActiveAppointment(app.Appointment)
            && app.Status == ApplicationStatus.PendingPayment)
        {
            app.Status = ApplicationStatus.AwaitingAppointment;
            await _db.SaveChangesAsync();
        }

        return View(app);
    }

    [HttpGet]
    public async Task<IActionResult> Checkout(int id)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications
            .Include(a => a.Payment)
            .ThenInclude(p => p!.Fee)
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);
        if (app?.Payment?.Fee is null)
            return NotFound();

        var pay = app.Payment;

        if (pay.PaymentStatus == PaymentStatuses.Approved)
        {
            TempData["Message"] = "This fee is already verified.";
            return RedirectToAction(nameof(Details), new { id });
        }

        if (pay.PaymentStatus == PaymentStatuses.Pending &&
            ( !string.IsNullOrEmpty(pay.ReceiptImage)
              || pay.TransactionNumber == PaymentMethods.PayAtOfficeMarker))
        {
            TempData["Message"] = "Your payment step is complete. Please book an appointment.";
            return RedirectToAction("Book", "Appointments", new { applicationId = id });
        }

        var vm = new PaymentCheckoutViewModel
        {
            ApplicationId = id,
            FeeName = pay.Fee.ServiceName,
            Amount = pay.Amount,
            Currency = pay.Fee.Currency,
            MobileMoneyNumber = _manualPayment.MobileMoneyNumber.Trim(),
            SenderPhone = pay.SenderPhone ?? string.Empty,
            TransactionNumber = pay.TransactionNumber ?? string.Empty
        };
        return View(vm);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Checkout(PaymentCheckoutViewModel model)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications
            .Include(a => a.Payment)
            .ThenInclude(p => p!.Fee)
            .FirstOrDefaultAsync(a => a.Id == model.ApplicationId && a.UserId == userId);
        if (app?.Payment?.Fee is null)
            return NotFound();

        model.FeeName = app.Payment.Fee.ServiceName;
        model.Amount = app.Payment.Amount;
        model.Currency = app.Payment.Fee.Currency;
        model.MobileMoneyNumber = _manualPayment.MobileMoneyNumber.Trim();

        var pay = app.Payment;

        if (pay.PaymentStatus == PaymentStatuses.Approved)
        {
            TempData["Message"] = "This fee is already verified.";
            return RedirectToAction(nameof(Details), new { id = model.ApplicationId });
        }

        if (pay.PaymentStatus == PaymentStatuses.Pending &&
            ( !string.IsNullOrEmpty(pay.ReceiptImage)
              || pay.TransactionNumber == PaymentMethods.PayAtOfficeMarker))
        {
            TempData["Message"] = "Your payment step is complete. Please book an appointment.";
            return RedirectToAction("Book", "Appointments", new { applicationId = model.ApplicationId });
        }

        if (!ModelState.IsValid)
            return View(model);

        var receipt = model.ReceiptImage;
        if (receipt is null || receipt.Length == 0)
        {
            ModelState.AddModelError(nameof(model.ReceiptImage), "Please upload a receipt image (JPG or PNG).");
            return View(model);
        }

        var ext = Path.GetExtension(receipt.FileName).ToLowerInvariant();
        if (!ReceiptImageExtensions.Contains(ext))
        {
            ModelState.AddModelError(nameof(model.ReceiptImage), "Allowed receipt types: JPG, JPEG, PNG.");
            return View(model);
        }

        if (receipt.Length > MaxFileBytes)
        {
            ModelState.AddModelError(nameof(model.ReceiptImage), "Receipt must be 10 MB or smaller.");
            return View(model);
        }

        var paymentsDir = Path.Combine(_env.WebRootPath, "uploads", "payments");
        Directory.CreateDirectory(paymentsDir);

        if (!string.IsNullOrEmpty(pay.ReceiptImage))
        {
            var oldPath = Path.Combine(_env.WebRootPath, pay.ReceiptImage.Replace('/', Path.DirectorySeparatorChar));
            if (System.IO.File.Exists(oldPath))
                System.IO.File.Delete(oldPath);
        }

        var storedName = $"{app.Id}_{Guid.NewGuid():N}{ext}";
        var relative = Path.Combine("uploads", "payments", storedName).Replace('\\', '/');
        var physical = Path.Combine(_env.WebRootPath, relative.Replace('/', Path.DirectorySeparatorChar));
        await using (var fs = System.IO.File.Create(physical))
            await receipt.CopyToAsync(fs);

        pay.SenderPhone = model.SenderPhone.Trim();
        pay.TransactionNumber = model.TransactionNumber.Trim();
        pay.ReceiptImage = relative;
        pay.PaymentStatus = PaymentStatuses.Pending;
        pay.PaymentDate = null;

        app.Status = ApplicationStatus.AwaitingAppointment;
        await _db.SaveChangesAsync();

        TempData["Message"] = "Payment details submitted. Please book your office appointment.";
        return RedirectToAction("Book", "Appointments", new { applicationId = model.ApplicationId });
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> PayAtOffice(int id)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications
            .Include(a => a.Payment)
            .FirstOrDefaultAsync(a => a.Id == id && a.UserId == userId);
        if (app?.Payment is null)
            return NotFound();

        if (app.Payment.PaymentStatus == PaymentStatuses.Approved)
        {
            TempData["Message"] = "Payment is already verified.";
            return RedirectToAction(nameof(Details), new { id });
        }

        app.Payment.TransactionNumber = PaymentMethods.PayAtOfficeMarker;
        app.Payment.SenderPhone = "—";
        app.Payment.ReceiptImage = null;
        app.Payment.PaymentStatus = PaymentStatuses.Pending;
        app.Status = ApplicationStatus.AwaitingAppointment;
        await _db.SaveChangesAsync();

        TempData["Message"] = "Pay-at-office selected. Please book your appointment and bring payment to the office.";
        return RedirectToAction("Book", "Appointments", new { applicationId = id });
    }

    public IActionResult DownloadCertificate(int id) => NotFound();

    public IActionResult PrintCertificate(int id) => NotFound();

    private async Task<bool> TrySaveApplicationDocumentAsync(
        int applicationId,
        IFormFile file,
        string category,
        string modelStateKey)
    {
        var ext = Path.GetExtension(file.FileName).ToLowerInvariant();
        if (!AllowedExtensions.Contains(ext))
        {
            ModelState.AddModelError(modelStateKey, $"File type not allowed: {ext}");
            return false;
        }

        if (file.Length > MaxFileBytes)
        {
            ModelState.AddModelError(modelStateKey, "Each file must be 10 MB or smaller.");
            return false;
        }

        var storedName = $"{Guid.NewGuid():N}{ext}";
        var relative = Path.Combine("uploads", "documents", storedName).Replace('\\', '/');
        var physical = Path.Combine(_env.WebRootPath, relative.Replace('/', Path.DirectorySeparatorChar));
        await using (var fs = System.IO.File.Create(physical))
            await file.CopyToAsync(fs);

        _db.Documents.Add(new Document
        {
            ApplicationId = applicationId,
            Category = category,
            FilePath = relative
        });
        await _db.SaveChangesAsync();
        return true;
    }
}
