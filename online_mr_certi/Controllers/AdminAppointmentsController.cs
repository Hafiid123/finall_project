using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using online_mr_certi.Data;
using online_mr_certi.Filters;
using online_mr_certi.Infrastructure;
using online_mr_certi.Models;
using online_mr_certi.Models.ViewModels;

namespace online_mr_certi.Controllers;

[RequireAdminPanel]
public class AdminAppointmentsController : Controller
{
    private readonly AppDbContext _db;

    private static readonly string[] DayLabels =
        ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];

    public AdminAppointmentsController(AppDbContext db)
    {
        _db = db;
    }

    [RequirePermission(AppPermissions.ManageAppointments)]
    public async Task<IActionResult> ScheduleSettings()
    {
        var days = await _db.AppointmentWorkingDays.OrderBy(d => d.DayOfWeek).ToListAsync();
        if (days.Count == 0)
        {
            foreach (var dow in new[] { 6, 0, 1, 2, 3 })
                _db.AppointmentWorkingDays.Add(new AppointmentWorkingDay { DayOfWeek = dow, IsActive = true });
            await _db.SaveChangesAsync();
            days = await _db.AppointmentWorkingDays.OrderBy(d => d.DayOfWeek).ToListAsync();
        }

        var slots = await _db.AppointmentTimeSlots.OrderBy(s => s.StartTime).ToListAsync();

        var vm = new AppointmentScheduleSettingsViewModel
        {
            WorkingDays = Enumerable.Range(0, 7).Select(dow =>
            {
                var row = days.FirstOrDefault(x => x.DayOfWeek == dow);
                return new WorkingDayOption
                {
                    DayOfWeek = dow,
                    Label = DayLabels[dow],
                    IsActive = row?.IsActive ?? false
                };
            }).ToList(),
            TimeSlots = slots.Select(s => new TimeSlotEditModel
            {
                Id = s.Id,
                StartTime = s.StartTime,
                EndTime = s.EndTime,
                Capacity = s.Capacity,
                IsActive = s.IsActive
            }).ToList()
        };

        return View(vm);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    [RequirePermission(AppPermissions.ManageAppointments)]
    public async Task<IActionResult> ScheduleSettings(AppointmentScheduleSettingsViewModel model)
    {
        var existingDays = await _db.AppointmentWorkingDays.ToListAsync();
        foreach (var opt in model.WorkingDays)
        {
            var row = existingDays.FirstOrDefault(d => d.DayOfWeek == opt.DayOfWeek);
            if (row is null)
            {
                _db.AppointmentWorkingDays.Add(new AppointmentWorkingDay
                {
                    DayOfWeek = opt.DayOfWeek,
                    IsActive = opt.IsActive
                });
            }
            else
            {
                row.IsActive = opt.IsActive;
            }
        }

        foreach (var slotModel in model.TimeSlots)
        {
            if (slotModel.Id == 0)
            {
                if (slotModel.EndTime <= slotModel.StartTime)
                    continue;
                _db.AppointmentTimeSlots.Add(new AppointmentTimeSlot
                {
                    StartTime = slotModel.StartTime,
                    EndTime = slotModel.EndTime,
                    Capacity = slotModel.Capacity,
                    IsActive = slotModel.IsActive
                });
                continue;
            }

            var slot = await _db.AppointmentTimeSlots.FindAsync(slotModel.Id);
            if (slot is null)
                continue;
            slot.StartTime = slotModel.StartTime;
            slot.EndTime = slotModel.EndTime;
            slot.Capacity = slotModel.Capacity;
            slot.IsActive = slotModel.IsActive;
        }

        await _db.SaveChangesAsync();
        TempData["SuccessMessage"] = "Appointment schedule settings saved.";
        return RedirectToAction(nameof(ScheduleSettings));
    }

    [RequirePermission(AppPermissions.ManageAppointments)]
    public async Task<IActionResult> Index(DateOnly? date)
    {
        var selected = date ?? DateOnly.FromDateTime(DateTime.Today);
        var dateStart = selected.ToDateTime(TimeOnly.MinValue);

        var list = await _db.Appointments.AsNoTracking()
            .Include(a => a.TimeSlot)
            .Include(a => a.Application)
            .ThenInclude(app => app.User)
            .Include(a => a.Application)
            .ThenInclude(app => app.Payment)
            .Where(a => a.AppointmentDate == dateStart && a.Status == AppointmentStatuses.Booked)
            .OrderBy(a => a.TimeSlot.StartTime)
            .ThenBy(a => a.ReferenceNumber)
            .Select(a => new StaffVerificationRow
            {
                ApplicationId = a.ApplicationId,
                ReferenceNumber = a.ReferenceNumber,
                ApplicantName = a.Application.User.Name,
                HusbandName = a.Application.HusbandName,
                WifeName = a.Application.WifeName,
                TimeLabel = a.TimeSlot.StartTime.ToString("HH:mm") + " – " + a.TimeSlot.EndTime.ToString("HH:mm"),
                ApplicationStatus = a.Application.Status,
                PaymentStatus = a.Application.Payment != null ? a.Application.Payment.PaymentStatus : "—"
            })
            .ToListAsync();

        ViewBag.SelectedDate = selected;
        return View(list);
    }

    [RequirePermission(AppPermissions.VerifyApplications)]
    public async Task<IActionResult> Verification(DateOnly? date, string? reference)
    {
        if (!string.IsNullOrWhiteSpace(reference))
        {
            var appt = await _db.Appointments.AsNoTracking()
                .FirstOrDefaultAsync(a => a.ReferenceNumber == reference.Trim());
            if (appt is not null)
                return RedirectToAction("ApplicationDetails", "Admin", new { id = appt.ApplicationId });
            TempData["Error"] = "Appointment reference not found.";
        }

        var selected = date ?? DateOnly.FromDateTime(DateTime.Today);
        var dateStart = selected.ToDateTime(TimeOnly.MinValue);

        var rows = await _db.Appointments.AsNoTracking()
            .Include(a => a.TimeSlot)
            .Include(a => a.Application)
            .ThenInclude(app => app.User)
            .Include(a => a.Application.Payment)
            .Where(a => a.AppointmentDate == dateStart && a.Status == AppointmentStatuses.Booked)
            .OrderBy(a => a.TimeSlot.StartTime)
            .Select(a => new StaffVerificationRow
            {
                ApplicationId = a.ApplicationId,
                ReferenceNumber = a.ReferenceNumber,
                ApplicantName = a.Application.User.Name,
                HusbandName = a.Application.HusbandName,
                WifeName = a.Application.WifeName,
                TimeLabel = a.TimeSlot.StartTime.ToString("HH:mm") + " – " + a.TimeSlot.EndTime.ToString("HH:mm"),
                ApplicationStatus = a.Application.Status,
                PaymentStatus = a.Application.Payment != null ? a.Application.Payment.PaymentStatus : "—"
            })
            .ToListAsync();

        return View(new StaffVerificationListViewModel
        {
            SelectedDate = selected,
            Appointments = rows
        });
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    [RequirePermission(AppPermissions.VerifyApplications)]
    public async Task<IActionResult> RequestCorrection(RequestCorrectionViewModel model)
    {
        var app = await _db.MarriageApplications
            .Include(a => a.Appointments)
            .FirstOrDefaultAsync(a => a.Id == model.Id);
        if (app is null)
            return NotFound();

        app.Status = ApplicationStatus.CorrectionRequired;
        app.Remarks = model.Remarks.Trim();
        app.DecisionDate = null;

        var active = app.Appointments.Where(a => a.Status == AppointmentStatuses.Booked).ToList();
        foreach (var appt in active)
        {
            appt.Status = AppointmentStatuses.Cancelled;
            appt.CancelledAt = DateTime.UtcNow;
        }

        await _db.SaveChangesAsync();
        TempData["Message"] = "Correction requested. Applicant must update the application and book a new appointment.";
        return RedirectToAction("ApplicationDetails", "Admin", new { id = model.Id });
    }
}
