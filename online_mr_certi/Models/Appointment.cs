using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace online_mr_certi.Models;

[Table("appointments")]
public class Appointment
{
    public int Id { get; set; }

    public int ApplicationId { get; set; }
    public MarriageApplication Application { get; set; } = null!;

    public int TimeSlotId { get; set; }
    public AppointmentTimeSlot TimeSlot { get; set; } = null!;

    public DateTime AppointmentDate { get; set; }

    [Required, MaxLength(30)]
    public string ReferenceNumber { get; set; } = string.Empty;

    [Required, MaxLength(30)]
    public string Status { get; set; } = AppointmentStatuses.Booked;

    public DateTime BookedAt { get; set; } = DateTime.UtcNow;

    public DateTime? CancelledAt { get; set; }
}
