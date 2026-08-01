using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace online_mr_certi.Data.Migrations
{
    public partial class MakeUserIdNullable : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_marriage_applications_users_UserId",
                table: "marriage_applications");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "marriage_applications",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_marriage_applications_users_UserId",
                table: "marriage_applications",
                column: "UserId",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.SetNull);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_marriage_applications_users_UserId",
                table: "marriage_applications");

            migrationBuilder.AlterColumn<int>(
                name: "UserId",
                table: "marriage_applications",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_marriage_applications_users_UserId",
                table: "marriage_applications",
                column: "UserId",
                principalTable: "users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Restrict);
        }
    }
}
