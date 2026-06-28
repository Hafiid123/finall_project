using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace online_mr_certi.Models;

[Table("marriage_applications")]
public class MarriageApplication
{
    public int Id { get; set; }

    public int UserId { get; set; }
    public User User { get; set; } = null!;

    [Required, MaxLength(200)]
    public string HusbandName { get; set; } = string.Empty;

    public DateTime HusbandDob { get; set; }

    [Required, MaxLength(100)]
    public string HusbandIdNumber { get; set; } = string.Empty;

    [Required, MaxLength(50)]
    public string HusbandContactNumber { get; set; } = string.Empty;

    [Required, MaxLength(500)]
    public string HusbandAddress { get; set; } = string.Empty;

    [Required, MaxLength(200)]
    public string WifeName { get; set; } = string.Empty;

    public DateTime WifeDob { get; set; }

    [Required, MaxLength(100)]
    public string WifeIdNumber { get; set; } = string.Empty;

    [Required, MaxLength(50)]
    public string WifeContactNumber { get; set; } = string.Empty;

    [Required, MaxLength(500)]
    public string WifeAddress { get; set; } = string.Empty;

    public DateTime MarriageDate { get; set; }

    [Required, MaxLength(300)]
    public string MarriageLocation { get; set; } = string.Empty;

    [MaxLength(200)]
    public string? District { get; set; }

    [Required, MaxLength(30)]
    public string Status { get; set; } = ApplicationStatus.Pending;

    public DateTime SubmissionDate { get; set; }

    public DateTime? DecisionDate { get; set; }

    [MaxLength(2000)]
    public string? Remarks { get; set; }

    [MaxLength(200)]
    public string? HusbandFatherName { get; set; }

    [MaxLength(200)]
    public string? HusbandMotherName { get; set; }

    [MaxLength(100)]
    public string? HusbandNationality { get; set; }

    [MaxLength(150)]
    public string? HusbandOccupation { get; set; }

    [MaxLength(30)]
    public string? HusbandResidenceStatus { get; set; }

    [MaxLength(100)]
    public string? HusbandMaritalStatus { get; set; }

    [MaxLength(100)]
    public string? HusbandReligion { get; set; }

    [MaxLength(200)]
    public string? WifeFatherName { get; set; }

    [MaxLength(200)]
    public string? WifeMotherName { get; set; }

    [MaxLength(100)]
    public string? WifeNationality { get; set; }

    [MaxLength(150)]
    public string? WifeOccupation { get; set; }

    [MaxLength(30)]
    public string? WifeResidenceStatus { get; set; }

    [MaxLength(100)]
    public string? WifeMaritalStatus { get; set; }

    [MaxLength(100)]
    public string? WifeReligion { get; set; }

    [MaxLength(30)]
    public string? MarriageType { get; set; }

    [MaxLength(200)]
    public string? SheikhName { get; set; }

    [MaxLength(500)]
    public string? Meher { get; set; }

    public ICollection<Document> Documents { get; set; } = new List<Document>();
    public ICollection<MarriageWitness> Witnesses { get; set; } = new List<MarriageWitness>();
    public Payment? Payment { get; set; }
    public Certificate? Certificate { get; set; }
    public ICollection<Appointment> Appointments { get; set; } = new List<Appointment>();

    [NotMapped]
    public Appointment? Appointment => Appointments
        .Where(a => a.Status == AppointmentStatuses.Booked)
        .OrderByDescending(a => a.Id)
        .FirstOrDefault();

    [NotMapped] public string? Witness1Name => ResolveWitness(1)?.FullName;
    [NotMapped] public string? Witness1MotherName => ResolveWitness(1)?.MotherName;
    [NotMapped] public DateTime? Witness1DateOfBirth => ResolveWitness(1)?.DateOfBirth;
    [NotMapped] public string? Witness1IdNumber => ResolveWitness(1)?.IdNumber;
    [NotMapped] public string? Witness1ContactNumber => ResolveWitness(1)?.ContactNumber;
    [NotMapped] public string? Witness1Address => ResolveWitness(1)?.Address;

    [NotMapped] public string? Witness2Name => ResolveWitness(2)?.FullName;
    [NotMapped] public string? Witness2MotherName => ResolveWitness(2)?.MotherName;
    [NotMapped] public DateTime? Witness2DateOfBirth => ResolveWitness(2)?.DateOfBirth;
    [NotMapped] public string? Witness2IdNumber => ResolveWitness(2)?.IdNumber;
    [NotMapped] public string? Witness2ContactNumber => ResolveWitness(2)?.ContactNumber;
    [NotMapped] public string? Witness2Address => ResolveWitness(2)?.Address;

    private MarriageWitness? ResolveWitness(byte sortOrder)
    {
        var list = Witnesses.OrderBy(w => w.SortOrder).ThenBy(w => w.Id).ToList();
        var byOrder = list.FirstOrDefault(w => w.SortOrder == sortOrder);
        if (byOrder != null)
            return byOrder;
        if (sortOrder == 1)
            return list.FirstOrDefault();
        if (sortOrder == 2)
        {
            var first = list.FirstOrDefault();
            return list.FirstOrDefault(w => first == null || w.Id != first.Id);
        }
        return null;
    }
}
