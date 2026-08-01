using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace online_mr_certi.Models;

[Table("payments")]
public class Payment
{
    public int Id { get; set; }

    public int ApplicationId { get; set; }
    public MarriageApplication Application { get; set; } = null!;

    public int? UserId { get; set; }
    public User? User { get; set; }

    public int FeeId { get; set; }
    public Fee Fee { get; set; } = null!;

    [Column(TypeName = "decimal(18,2)")]
    public decimal Amount { get; set; }

    [Column(TypeName = "decimal(18,2)")]
    public decimal ApplicationFee { get; set; }

    [Required, MaxLength(30)]
    public string PaymentStatus { get; set; } = PaymentStatuses.Pending;

    [MaxLength(20)]
    public string? PaymentMethod { get; set; }

    public DateTime? PaymentDate { get; set; }

    [MaxLength(500)]
    public string? ReceiptImage { get; set; }

    [MaxLength(50)]
    public string? SenderPhone { get; set; }

    [MaxLength(100)]
    public string? TransactionNumber { get; set; }

    [MaxLength(500)]
    public string? PaymentProofPath { get; set; }

    [MaxLength(100)]
    public string? TransactionReference { get; set; }

    [MaxLength(500)]
    public string? RejectionReason { get; set; }

    [MaxLength(200)]
    public string? VerifiedBy { get; set; }

    public DateTime? VerifiedAt { get; set; }

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}
