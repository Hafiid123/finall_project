using System.ComponentModel.DataAnnotations;

namespace online_mr_certi.Models.ViewModels;

public class BookAppointmentViewModel
{
    public int ApplicationId { get; set; }

    [Display(Name = "Appointment date")]
    public DateOnly? SelectedDate { get; set; }

    [Display(Name = "Time slot")]
    public int? TimeSlotId { get; set; }

    public IReadOnlyList<DateOnly> AvailableDates { get; set; } = Array.Empty<DateOnly>();
    public IReadOnlyList<AppointmentSlotOption> Slots { get; set; } = Array.Empty<AppointmentSlotOption>();
}

public class AppointmentSlotOption
{
    public int TimeSlotId { get; set; }
    public string Label { get; set; } = string.Empty;
    public bool IsAvailable { get; set; }
    public int Remaining { get; set; }
}

public class AppointmentScheduleSettingsViewModel
{
    public List<WorkingDayOption> WorkingDays { get; set; } = new();
    public List<TimeSlotEditModel> TimeSlots { get; set; } = new();
}

public class WorkingDayOption
{
    public int DayOfWeek { get; set; }
    public string Label { get; set; } = string.Empty;
    public bool IsActive { get; set; }
}

public class TimeSlotEditModel
{
    public int Id { get; set; }

    [Display(Name = "Start")]
    public TimeOnly StartTime { get; set; }

    [Display(Name = "End")]
    public TimeOnly EndTime { get; set; }

    [Display(Name = "Capacity")]
    [Range(1, 100)]
    public int Capacity { get; set; } = 5;

    public bool IsActive { get; set; } = true;
}

public class StaffVerificationListViewModel
{
    public DateOnly SelectedDate { get; set; }
    public List<StaffVerificationRow> Appointments { get; set; } = new();
}

public class StaffVerificationRow
{
    public int ApplicationId { get; set; }
    public string ReferenceNumber { get; set; } = string.Empty;
    public string ApplicantName { get; set; } = string.Empty;
    public string HusbandName { get; set; } = string.Empty;
    public string WifeName { get; set; } = string.Empty;
    public string TimeLabel { get; set; } = string.Empty;
    public string ApplicationStatus { get; set; } = string.Empty;
    public string PaymentStatus { get; set; } = string.Empty;
}

public class RequestCorrectionViewModel
{
    public int Id { get; set; }

    [Required, MaxLength(2000)]
    [Display(Name = "Correction notes")]
    public string Remarks { get; set; } = string.Empty;
}
