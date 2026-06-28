using System.ComponentModel.DataAnnotations;

namespace online_mr_certi.Models;

public enum MaritalStatus
{
    Guursatay,

    Guursaday,

    [Display(Name = "Ma guursan")]
    MaGuursan
}

public static class MaritalStatusExtensions
{
    public static string? ToLabel(this MaritalStatus? status) => status switch
    {
        MaritalStatus.Guursatay => "Guursatay",
        MaritalStatus.Guursaday => "Guursaday",
        MaritalStatus.MaGuursan => "Ma guursan",
        _ => null
    };

    public static MaritalStatus? FromLabel(string? label)
    {
        if (string.IsNullOrWhiteSpace(label))
            return null;

        return label.Trim() switch
        {
            "Guursatay" => MaritalStatus.Guursatay,
            "Guursaday" => MaritalStatus.Guursaday,
            "Ma guursan" => MaritalStatus.MaGuursan,
            _ => Enum.TryParse<MaritalStatus>(label, ignoreCase: true, out var parsed) ? parsed : null
        };
    }
}
