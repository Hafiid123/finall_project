using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace online_mr_certi.Models;

[Table("appointment_working_days")]
public class AppointmentWorkingDay
{
    public int Id { get; set; }

    /// <summary>0 = Sunday … 6 = Saturday (System.DayOfWeek).</summary>
    public int DayOfWeek { get; set; }

    public bool IsActive { get; set; } = true;
}
