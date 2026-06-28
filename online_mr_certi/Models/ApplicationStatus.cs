namespace online_mr_certi.Models;

public static class ApplicationStatus
{
    /// <summary>Awaiting fee payment and receipt submission.</summary>
    public const string PendingPayment = "Pending Payment";

    /// <summary>Payment step complete; applicant must book an appointment.</summary>
    public const string AwaitingAppointment = "Awaiting Appointment";

    /// <summary>Appointment booked; awaiting office visit.</summary>
    public const string AppointmentBooked = "Appointment Booked";

    /// <summary>Legacy / under review after payment (kept for existing rows).</summary>
    public const string Pending = "Pending";

    public const string Approved = "Approved";
    public const string Rejected = "Rejected";

    /// <summary>Staff requested corrections; applicant must update and rebook.</summary>
    public const string CorrectionRequired = "Correction Required";
}
