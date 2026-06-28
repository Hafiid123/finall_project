using Microsoft.EntityFrameworkCore;
using online_mr_certi.Data;
using online_mr_certi.Infrastructure;
using online_mr_certi.Models;

namespace online_mr_certi.Services;

public sealed class AppointmentBookingService : IAppointmentBookingService
{
    private readonly AppDbContext _db;

    public AppointmentBookingService(AppDbContext db) => _db = db;

    public async Task<IReadOnlyList<DateOnly>> GetAvailableDatesAsync(int daysAhead = 60)
    {
        var workingDays = await _db.AppointmentWorkingDays.AsNoTracking()
            .Where(d => d.IsActive)
            .Select(d => d.DayOfWeek)
            .ToListAsync();

        if (workingDays.Count == 0)
            return Array.Empty<DateOnly>();

        var today = DateOnly.FromDateTime(DateTime.Today);
        var dates = new List<DateOnly>();
        for (var i = 1; i <= daysAhead; i++)
        {
            var d = today.AddDays(i);
            if (workingDays.Contains((int)d.DayOfWeek))
                dates.Add(d);
        }

        return dates;
    }

    public async Task<IReadOnlyList<AppointmentSlotAvailability>> GetSlotAvailabilityAsync(DateOnly date)
    {
        var slots = await _db.AppointmentTimeSlots.AsNoTracking()
            .Where(s => s.IsActive)
            .OrderBy(s => s.StartTime)
            .ToListAsync();

        if (slots.Count == 0)
            return Array.Empty<AppointmentSlotAvailability>();

        var dateStart = date.ToDateTime(TimeOnly.MinValue);
        var bookedCounts = await _db.Appointments.AsNoTracking()
            .Where(a => a.AppointmentDate == dateStart && a.Status == AppointmentStatuses.Booked)
            .GroupBy(a => a.TimeSlotId)
            .Select(g => new { TimeSlotId = g.Key, Count = g.Count() })
            .ToDictionaryAsync(x => x.TimeSlotId, x => x.Count);

        return slots.Select(s => new AppointmentSlotAvailability
        {
            TimeSlotId = s.Id,
            StartTime = s.StartTime,
            EndTime = s.EndTime,
            Capacity = s.Capacity,
            BookedCount = bookedCounts.GetValueOrDefault(s.Id)
        }).ToList();
    }

    public async Task<(bool Success, string? Error, Appointment? Appointment)> TryBookAsync(
        int applicationId,
        int userId,
        DateOnly date,
        int timeSlotId)
    {
        await using var tx = await _db.Database.BeginTransactionAsync();

        var app = await _db.MarriageApplications
            .Include(a => a.Payment)
            .Include(a => a.Appointments)
            .FirstOrDefaultAsync(a => a.Id == applicationId && a.UserId == userId);

        if (app is null)
            return (false, "Application not found.", null);

        if (!AppointmentWorkflow.CanBookAppointment(app, app.Payment))
            return (false, "Complete payment before booking an appointment.", null);

        var hasActive = await _db.Appointments.AnyAsync(a =>
            a.ApplicationId == applicationId && a.Status == AppointmentStatuses.Booked);
        if (hasActive)
            return (false, "This application already has an active appointment.", null);

        var isWorkingDay = await _db.AppointmentWorkingDays.AnyAsync(d =>
            d.IsActive && d.DayOfWeek == (int)date.DayOfWeek);
        if (!isWorkingDay)
            return (false, "Selected date is not a working day.", null);

        var slot = await _db.AppointmentTimeSlots.FirstOrDefaultAsync(s => s.Id == timeSlotId && s.IsActive);
        if (slot is null)
            return (false, "Time slot not found.", null);

        var dateStart = date.ToDateTime(TimeOnly.MinValue);
        var booked = await _db.Appointments.CountAsync(a =>
            a.AppointmentDate == dateStart
            && a.TimeSlotId == timeSlotId
            && a.Status == AppointmentStatuses.Booked);

        if (booked >= slot.Capacity)
            return (false, "This time slot is fully booked. Please choose another.", null);

        var appointment = new Appointment
        {
            ApplicationId = applicationId,
            TimeSlotId = timeSlotId,
            AppointmentDate = dateStart,
            Status = AppointmentStatuses.Booked,
            BookedAt = DateTime.UtcNow
        };

        _db.Appointments.Add(appointment);
        app.Status = ApplicationStatus.AppointmentBooked;
        await _db.SaveChangesAsync();

        appointment.ReferenceNumber = $"APT-{DateTime.UtcNow:yyyy}-{appointment.Id:D6}";
        await _db.SaveChangesAsync();
        await tx.CommitAsync();

        return (true, null, appointment);
    }
}
