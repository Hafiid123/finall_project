using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations
{
    [DbContext(typeof(AppDbContext))]
    [Migration("20260720120000_SeedRequiredFees")]
    public partial class SeedRequiredFees : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            // If there are fees but none named "Appointment Fee", rename the first active one
            migrationBuilder.Sql(@"
                UPDATE `fees`
                SET `ServiceName` = 'Appointment Fee'
                WHERE `ServiceName` <> 'Appointment Fee'
                  AND `ServiceName` <> 'Certificate Fee'
                  AND `IsActive` = 1
                  AND NOT EXISTS (SELECT 1 FROM `fees` WHERE `ServiceName` = 'Appointment Fee')
                LIMIT 1;
            ");

            // Insert Appointment Fee if none exist
            migrationBuilder.Sql(@"
                INSERT INTO `fees` (`ServiceName`, `Amount`, `Currency`, `IsActive`, `CreatedAt`)
                SELECT 'Appointment Fee', 15.00, 'USD', 1, UTC_TIMESTAMP()
                WHERE NOT EXISTS (SELECT 1 FROM `fees` WHERE `ServiceName` = 'Appointment Fee');
            ");

            // Insert Certificate Fee if it doesn't exist
            migrationBuilder.Sql(@"
                INSERT INTO `fees` (`ServiceName`, `Amount`, `Currency`, `IsActive`, `CreatedAt`)
                SELECT 'Certificate Fee', 10.00, 'USD', 1, UTC_TIMESTAMP()
                WHERE NOT EXISTS (SELECT 1 FROM `fees` WHERE `ServiceName` = 'Certificate Fee');
            ");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
        }
    }
}
