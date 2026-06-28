namespace online_mr_certi.Models;

public enum MeherType
{
    Dahab,
    Lacag
}

public static class MeherTypeExtensions
{
    public static string? ToLabel(this MeherType? type) => type switch
    {
        MeherType.Dahab => "Dahab",
        MeherType.Lacag => "Lacag",
        _ => null
    };

    public static MeherType? FromLabel(string? label)
    {
        if (string.IsNullOrWhiteSpace(label))
            return null;

        return label.Trim() switch
        {
            "Dahab" => MeherType.Dahab,
            "Lacag" => MeherType.Lacag,
            _ => Enum.TryParse<MeherType>(label, ignoreCase: true, out var parsed) ? parsed : null
        };
    }
}
