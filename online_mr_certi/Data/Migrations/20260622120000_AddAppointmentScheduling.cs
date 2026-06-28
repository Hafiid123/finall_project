using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Migrations;
using online_mr_certi.Data;

#nullable disable

namespace online_mr_certi.Data.Migrations;

[DbContext(typeof(AppDbContext))]
[Migration("20260622120000_AddAppointmentScheduling")]
public partial class AddAppointmentScheduling : Migration
{
    protected override void Up(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            CREATE TABLE `appointment_working_days` (
                `Id` int NOT NULL AUTO_INCREMENT,
                `DayOfWeek` int NOT NULL,
                `IsActive` tinyint(1) NOT NULL DEFAULT 1,
                PRIMARY KEY (`Id`),
                UNIQUE KEY `IX_appointment_working_days_DayOfWeek` (`DayOfWeek`)
            );

            CREATE TABLE `appointment_time_slots` (
                `Id` int NOT NULL AUTO_INCREMENT,
                `StartTime` time(6) NOT NULL,
                `EndTime` time(6) NOT NULL,
                `Capacity` int NOT NULL DEFAULT 5,
                `IsActive` tinyint(1) NOT NULL DEFAULT 1,
                PRIMARY KEY (`Id`)
            );

            CREATE TABLE `appointments` (
                `Id` int NOT NULL AUTO_INCREMENT,
                `ApplicationId` int NOT NULL,
                `TimeSlotId` int NOT NULL,
                `AppointmentDate` datetime(6) NOT NULL,
                `ReferenceNumber` varchar(30) NOT NULL,
                `Status` varchar(30) NOT NULL,
                `BookedAt` datetime(6) NOT NULL,
                `CancelledAt` datetime(6) NULL,
                PRIMARY KEY (`Id`),
                KEY `IX_appointments_ApplicationId` (`ApplicationId`),
                UNIQUE KEY `IX_appointments_ReferenceNumber` (`ReferenceNumber`),
                KEY `IX_appointments_TimeSlotId` (`TimeSlotId`),
                CONSTRAINT `FK_appointments_marriage_applications_ApplicationId`
                    FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE,
                CONSTRAINT `FK_appointments_appointment_time_slots_TimeSlotId`
                    FOREIGN KEY (`TimeSlotId`) REFERENCES `appointment_time_slots` (`Id`) ON DELETE RESTRICT
            );

            INSERT INTO `appointment_working_days` (`DayOfWeek`, `IsActive`) VALUES
                (6, 1), (0, 1), (1, 1), (2, 1), (3, 1);

            INSERT INTO `appointment_time_slots` (`StartTime`, `EndTime`, `Capacity`, `IsActive`) VALUES
                ('08:00:00', '10:00:00', 5, 1),
                ('10:00:00', '12:00:00', 5, 1);
            """);
    }

    protected override void Down(MigrationBuilder migrationBuilder)
    {
        migrationBuilder.Sql(
            """
            DROP TABLE IF EXISTS `appointments`;
            DROP TABLE IF EXISTS `appointment_time_slots`;
            DROP TABLE IF EXISTS `appointment_working_days`;
            """);
    }
}
