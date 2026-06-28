using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

/// <summary>Allows multiple appointment records per application (e.g. cancelled + rebooked).</summary>
[DbContext(typeof(AppDbContext))]
[Migration("20260622120100_AllowMultipleAppointmentsPerApplication")]
public partial class AllowMultipleAppointmentsPerApplication : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            SET @idx_exists = (
                SELECT COUNT(1) FROM information_schema.statistics
                WHERE table_schema = DATABASE()
                  AND table_name = 'appointments'
                  AND index_name = 'IX_appointments_ApplicationId'
                  AND non_unique = 0
            );
            SET @sql = IF(@idx_exists > 0,
                'ALTER TABLE `appointments` DROP INDEX `IX_appointments_ApplicationId`, ADD KEY `IX_appointments_ApplicationId` (`ApplicationId`)',
                'SELECT 1');
            PREPARE stmt FROM @sql;
            EXECUTE stmt;
            DEALLOCATE PREPARE stmt;
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        // No-op: reverting to unique could fail if duplicates exist.
    }
}
