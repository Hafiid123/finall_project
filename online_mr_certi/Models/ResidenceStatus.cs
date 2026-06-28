using System.ComponentModel.DataAnnotations;

namespace online_mr_certi.Models;

public enum ResidenceStatus
{
    Resident,

    [Display(Name = "Non-Resident")]
    NonResident
}
