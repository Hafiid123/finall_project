using System.ComponentModel.DataAnnotations;
using online_mr_certi.Models;

namespace online_mr_certi.Models.ViewModels;

public class AdminUserEditViewModel
{
    [Required]
    public int Id { get; set; }

    [Required, MaxLength(200)]
    public string Name { get; set; } = string.Empty;

    [Required, EmailAddress, MaxLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required]
    public string Role { get; set; } = AppRoles.User;
}

public class AdminCreateUserViewModel
{
    [Required, MaxLength(200)]
    public string Name { get; set; } = string.Empty;

    [Required, EmailAddress, MaxLength(256)]
    public string Email { get; set; } = string.Empty;

    [Required, DataType(DataType.Password), MinLength(8)]
    public string Password { get; set; } = string.Empty;

    [Required]
    [Display(Name = "Role")]
    public int RoleId { get; set; }
}

public class RolePermissionCheckboxViewModel
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public bool Selected { get; set; }
}

public class RoleEditViewModel
{
    public int? Id { get; set; }

    [Required, MaxLength(100)]
    [Display(Name = "Role name")]
    public string Name { get; set; } = string.Empty;

    public List<RolePermissionCheckboxViewModel> Permissions { get; set; } = new();
}

public class AdminApplicationEditViewModel : IValidatableObject
{
    [Required]
    public int Id { get; set; }

    [Required, MaxLength(200)]
    [Display(Name = "Full name")]
    public string HusbandName { get; set; } = string.Empty;

    [MaxLength(200)]
    [Display(Name = "Mother name")]
    public string? HusbandMotherName { get; set; }

    [Required, DataType(DataType.Date)]
    [Display(Name = "Date of birth")]
    public DateTime HusbandDob { get; set; }

    [Required, MaxLength(100)]
    [Display(Name = "National ID number")]
    public string HusbandIdNumber { get; set; } = string.Empty;

    [Required, MaxLength(500)]
    [Display(Name = "Address (Residence)")]
    public string HusbandAddress { get; set; } = string.Empty;

    [MaxLength(150)]
    [Display(Name = "Occupation")]
    public string? HusbandOccupation { get; set; }

    [Display(Name = "Marital status")]
    public MaritalStatus? HusbandMaritalStatus { get; set; }

    [MaxLength(100)]
    [Display(Name = "Religion")]
    public string? HusbandReligion { get; set; }

    [MaxLength(50)]
    [Display(Name = "Contact number")]
    public string? HusbandContactNumber { get; set; }

    [Required, MaxLength(200)]
    [Display(Name = "Full name")]
    public string WifeName { get; set; } = string.Empty;

    [MaxLength(200)]
    [Display(Name = "Mother name")]
    public string? WifeMotherName { get; set; }

    [Required, DataType(DataType.Date)]
    [Display(Name = "Date of birth")]
    public DateTime WifeDob { get; set; }

    [Required, MaxLength(100)]
    [Display(Name = "National ID number")]
    public string WifeIdNumber { get; set; } = string.Empty;

    [Required, MaxLength(500)]
    [Display(Name = "Address (Residence)")]
    public string WifeAddress { get; set; } = string.Empty;

    [MaxLength(150)]
    [Display(Name = "Occupation")]
    public string? WifeOccupation { get; set; }

    [Display(Name = "Marital status")]
    public MaritalStatus? WifeMaritalStatus { get; set; }

    [MaxLength(100)]
    [Display(Name = "Religion")]
    public string? WifeReligion { get; set; }

    [MaxLength(50)]
    [Display(Name = "Contact number")]
    public string? WifeContactNumber { get; set; }

    [Required, DataType(DataType.Date)]
    [Display(Name = "Marriage date")]
    public DateTime MarriageDate { get; set; }

    [Required, MaxLength(300)]
    [Display(Name = "Marriage location")]
    public string MarriageLocation { get; set; } = string.Empty;

    [MaxLength(200)]
    [Display(Name = "District")]
    public string? District { get; set; }

    [MaxLength(200)]
    [Display(Name = "Sheikh name (Officiant)")]
    public string? SheikhName { get; set; }

    [Display(Name = "Meher type")]
    public MeherType? MeherType { get; set; }

    [MaxLength(500)]
    [Display(Name = "Meher amount / description")]
    public string? Meher { get; set; }

    public int? Witness1Id { get; set; }

    public AdminWitnessFormModel Witness1 { get; set; } = new();

    public int? Witness2Id { get; set; }

    public AdminWitnessFormModel Witness2 { get; set; } = new();

    [Required, MaxLength(30)]
    [Display(Name = "Status")]
    public string Status { get; set; } = ApplicationStatus.Pending;

    [MaxLength(2000)]
    [Display(Name = "Remarks")]
    public string? Remarks { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        foreach (var err in ValidateWitness(Witness1, nameof(Witness1), validationContext))
            yield return err;
        foreach (var err in ValidateWitness(Witness2, nameof(Witness2), validationContext))
            yield return err;
    }

    private static IEnumerable<ValidationResult> ValidateWitness(
        AdminWitnessFormModel witness,
        string prefix,
        ValidationContext parent)
    {
        var ctx = new ValidationContext(witness, parent, parent.Items);
        var errs = new List<ValidationResult>();
        if (Validator.TryValidateObject(witness, ctx, errs, validateAllProperties: true))
            yield break;

        foreach (var e in errs)
        {
            foreach (var member in e.MemberNames.DefaultIfEmpty(string.Empty))
            {
                var key = string.IsNullOrEmpty(member) ? prefix : $"{prefix}.{member}";
                yield return new ValidationResult(e.ErrorMessage ?? "Invalid value.", new[] { key });
            }
        }
    }
}

public class FeeCreateViewModel
{
    [Required, MaxLength(200)]
    [Display(Name = "Service name")]
    public string ServiceName { get; set; } = string.Empty;

    [Required]
    [Range(0, 999999.99)]
    [Display(Name = "Amount")]
    public decimal Amount { get; set; }

    [Required, MaxLength(10)]
    [Display(Name = "Currency")]
    public string Currency { get; set; } = "USD";

    [Display(Name = "Active")]
    public bool IsActive { get; set; } = true;
}

public class FeeEditViewModel
{
    [Required]
    public int Id { get; set; }

    [Required, MaxLength(200)]
    public string ServiceName { get; set; } = string.Empty;

    [Required]
    [Range(0, 999999.99)]
    public decimal Amount { get; set; }

    [Required, MaxLength(10)]
    [Display(Name = "Currency")]
    public string Currency { get; set; } = "USD";

    [Display(Name = "Active")]
    public bool IsActive { get; set; }
}
