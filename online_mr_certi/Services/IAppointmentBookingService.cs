using online_mr_certi.Models;

namespace online_mr_certi.Services;

public interface IAppointmentBookingService
{
    Task<IReadOnlyList<DateOnly>> GetAvailableDatesAsync(int daysAhead = 60);

    Task<IReadOnlyList<AppointmentSlotAvailability>> GetSlotAvailabilityAsync(DateOnly date);

    Task<(bool Success, string? Error, Appointment? Appointment)> TryBookAsync(
        int applicationId,
        int userId,
        DateOnly date,
        int timeSlotId);
}

public sealed class AppointmentSlotAvailability
{
    public int TimeSlotId { get; init; }
    public TimeOnly StartTime { get; init; }
    public TimeOnly EndTime { get; init; }
    public int Capacity { get; init; }
    public int BookedCount { get; init; }
    public bool IsAvailable => BookedCount < Capacity;
}
