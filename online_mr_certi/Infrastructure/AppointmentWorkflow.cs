using online_mr_certi.Models;

namespace online_mr_certi.Infrastructure;

public static class AppointmentWorkflow
{
    public static bool IsPaymentStepComplete(Payment? payment)
    {
        if (payment is null)
            return false;

        if (payment.PaymentStatus == PaymentStatuses.Approved)
            return true;

        if (string.Equals(payment.TransactionNumber, PaymentMethods.PayAtOfficeMarker, StringComparison.Ordinal))
            return true;

        return payment.PaymentStatus == PaymentStatuses.Pending
               && !string.IsNullOrEmpty(payment.ReceiptImage);
    }

    public static bool CanBookAppointment(MarriageApplication app, Payment? payment)
    {
        if (app.Status is ApplicationStatus.Rejected or ApplicationStatus.Approved)
            return false;

        if (app.Status == ApplicationStatus.AppointmentBooked)
            return false;

        return IsPaymentStepComplete(payment);
    }

    public static bool NeedsAppointmentBooking(MarriageApplication app)
        => app.Status is ApplicationStatus.AwaitingAppointment
            or ApplicationStatus.PendingPayment
            or ApplicationStatus.CorrectionRequired;

    public static bool HasActiveAppointment(Appointment? appointment)
        => appointment is not null && appointment.Status == AppointmentStatuses.Booked;
}
