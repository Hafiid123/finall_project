using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using online_mr_certi.Data;
using online_mr_certi.Filters;
using online_mr_certi.Infrastructure;
using online_mr_certi.Models;
using online_mr_certi.Models.ViewModels;
using online_mr_certi.Services;

namespace online_mr_certi.Controllers;

[RequireLogin]
[RequireUserRole]
public class AppointmentsController : Controller
{
    private readonly AppDbContext _db;
    private readonly IAppointmentBookingService _booking;

    public AppointmentsController(AppDbContext db, IAppointmentBookingService booking)
    {
        _db = db;
        _booking = booking;
    }

    [HttpGet]
    public async Task<IActionResult> Book(int applicationId)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications
            .Include(a => a.Payment)
            .Include(a => a.Appointments)
            .FirstOrDefaultAsync(a => a.Id == applicationId && a.UserId == userId);

        if (app is null)
            return NotFound();

        if (AppointmentWorkflow.HasActiveAppointment(app.Appointment))
        {
            TempData["Message"] = $"You already have an appointment: {app.Appointment!.ReferenceNumber}";
            return RedirectToAction("Details", "Applications", new { id = applicationId });
        }

        if (!AppointmentWorkflow.CanBookAppointment(app, app.Payment))
        {
            TempData["Error"] = "Please complete payment (online or pay-at-office) before booking an appointment.";
            return RedirectToAction("Checkout", "Applications", new { id = applicationId });
        }

        var dates = await _booking.GetAvailableDatesAsync();
        return View(new BookAppointmentViewModel
        {
            ApplicationId = applicationId,
            AvailableDates = dates
        });
    }

    [HttpGet]
    public async Task<IActionResult> Slots(int applicationId, DateOnly date)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;
        var app = await _db.MarriageApplications.AsNoTracking()
            .FirstOrDefaultAsync(a => a.Id == applicationId && a.UserId == userId);
        if (app is null)
            return NotFound();

        var availability = await _booking.GetSlotAvailabilityAsync(date);
        var vm = new BookAppointmentViewModel
        {
            ApplicationId = applicationId,
            SelectedDate = date,
            AvailableDates = await _booking.GetAvailableDatesAsync(),
            Slots = availability.Select(s => new AppointmentSlotOption
            {
                TimeSlotId = s.TimeSlotId,
                Label = $"{s.StartTime:HH:mm} – {s.EndTime:HH:mm}",
                IsAvailable = s.IsAvailable,
                Remaining = Math.Max(0, s.Capacity - s.BookedCount)
            }).ToList()
        };

        return View("Book", vm);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Book(BookAppointmentViewModel model)
    {
        var userId = HttpContext.Session.GetInt32(SessionKeys.UserId)!.Value;

        if (!model.SelectedDate.HasValue || !model.TimeSlotId.HasValue)
        {
            ModelState.AddModelError(string.Empty, "Please select a date and time slot.");
            model.AvailableDates = await _booking.GetAvailableDatesAsync();
            if (model.SelectedDate.HasValue)
            {
                var availability = await _booking.GetSlotAvailabilityAsync(model.SelectedDate.Value);
                model.Slots = availability.Select(s => new AppointmentSlotOption
                {
                    TimeSlotId = s.TimeSlotId,
                    Label = $"{s.StartTime:HH:mm} – {s.EndTime:HH:mm}",
                    IsAvailable = s.IsAvailable,
                    Remaining = Math.Max(0, s.Capacity - s.BookedCount)
                }).ToList();
            }
            return View(model);
        }

        var (success, error, appointment) = await _booking.TryBookAsync(
            model.ApplicationId,
            userId,
            model.SelectedDate.Value,
            model.TimeSlotId.Value);

        if (!success)
        {
            TempData["Error"] = error;
            return RedirectToAction(nameof(Book), new { applicationId = model.ApplicationId });
        }

        TempData["Message"] =
            $"Appointment booked successfully. Your reference number is {appointment!.ReferenceNumber}. Please visit the office on the scheduled date with original documents.";
        return RedirectToAction("Details", "Applications", new { id = model.ApplicationId });
    }
}
