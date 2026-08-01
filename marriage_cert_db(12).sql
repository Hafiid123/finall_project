-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 01, 2026 at 09:43 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `marriage_cert_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_notification_read_states`
--

CREATE TABLE `admin_notification_read_states` (
  `UserId` int(11) NOT NULL,
  `LastReadAt` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin_notification_read_states`
--

INSERT INTO `admin_notification_read_states` (`UserId`, `LastReadAt`) VALUES
(1, '2026-07-24 14:25:36.023608'),
(14, '2026-05-30 04:46:58.449745');

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `Id` int(11) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `TimeSlotId` int(11) NOT NULL,
  `AppointmentDate` datetime(6) NOT NULL,
  `ReferenceNumber` varchar(30) NOT NULL,
  `Status` varchar(30) NOT NULL,
  `BookedAt` datetime(6) NOT NULL,
  `CancelledAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`Id`, `ApplicationId`, `TimeSlotId`, `AppointmentDate`, `ReferenceNumber`, `Status`, `BookedAt`, `CancelledAt`) VALUES
(5, 33, 1, '2026-07-21 00:00:00.000000', 'APT-2026-000005', 'Completed', '2026-07-20 17:28:38.869241', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `appointment_time_slots`
--

CREATE TABLE `appointment_time_slots` (
  `Id` int(11) NOT NULL,
  `StartTime` time(6) NOT NULL,
  `EndTime` time(6) NOT NULL,
  `Capacity` int(11) NOT NULL DEFAULT 5,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_time_slots`
--

INSERT INTO `appointment_time_slots` (`Id`, `StartTime`, `EndTime`, `Capacity`, `IsActive`) VALUES
(1, '08:00:00.000000', '10:00:00.000000', 5, 1),
(2, '10:00:00.000000', '15:00:00.000000', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `appointment_working_days`
--

CREATE TABLE `appointment_working_days` (
  `Id` int(11) NOT NULL,
  `DayOfWeek` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `appointment_working_days`
--

INSERT INTO `appointment_working_days` (`Id`, `DayOfWeek`, `IsActive`) VALUES
(1, 6, 1),
(2, 0, 1),
(3, 1, 1),
(4, 2, 1),
(5, 3, 1),
(6, 4, 1),
(7, 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `certificates`
--

CREATE TABLE `certificates` (
  `Id` int(11) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `CertificateFile` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `certificates`
--

INSERT INTO `certificates` (`Id`, `ApplicationId`, `CertificateFile`) VALUES
(92, 32, 'uploads/certificates/32_73ff9008cb4d4adc9b138714f32a6729.pdf'),
(93, 33, 'uploads/certificates/33_aa68cee2652b45beaba6cd9065d2f4de.pdf'),
(94, 34, 'uploads/certificates/34_be2c3242129c4134967e4bee8751d3a2.pdf');

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `Id` int(11) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `FilePath` varchar(500) NOT NULL,
  `Category` varchar(50) NOT NULL DEFAULT 'Supporting'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`Id`, `ApplicationId`, `FilePath`, `Category`) VALUES
(106, 32, '/uploads/c7049554-a1bf-4240-b566-24d7ef1ff24f_a15.jpg', 'HusbandIdentityDocument'),
(107, 32, '/uploads/deb041bf-9ece-46a7-8df2-bc3a1053c86a_a15.jpg', 'WifeIdentityDocument'),
(108, 32, '/uploads/0c33b0f6-12ef-4037-a1f1-8ef4ac341d02_a15.jpg', 'Witness1IdentityDocument'),
(109, 32, '/uploads/605b9525-f0f8-4d1e-af4b-b76b4328e6ac_a15.jpg', 'Witness2IdentityDocument'),
(110, 33, 'uploads/documents/b0ee673c46144eb09020e0f9829950bb.jpg', 'HusbandIdentityDocument'),
(111, 33, 'uploads/documents/e3832d99c31d4f32a1f9045871f10808.jpg', 'WifeIdentityDocument'),
(112, 33, 'uploads/documents/75e639ac31324ac1813f11a9d80efd02.jpg', 'Witness1IdentityDocument'),
(113, 33, 'uploads/documents/d50ab91dfbe849119fe1491035882cfa.jpg', 'Witness2IdentityDocument'),
(114, 34, '/uploads/18c4e3d8-933d-409f-8349-1af66c349db1_a15.jpg', 'HusbandIdentityDocument'),
(115, 34, '/uploads/41c43333-c1fc-4a10-bf3e-669d1592ccf4_a15.jpg', 'WifeIdentityDocument'),
(116, 34, '/uploads/46004f74-206d-4069-ba2c-ebfbd7468041_a15.jpg', 'Witness1IdentityDocument'),
(117, 34, '/uploads/becd7474-aeb9-4a67-8fa2-9a8a00543ec2_a15.jpg', 'Witness2IdentityDocument');

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `Id` int(11) NOT NULL,
  `ServiceName` varchar(200) NOT NULL,
  `Amount` decimal(18,2) NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  `Currency` varchar(10) NOT NULL DEFAULT 'USD',
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fees`
--

INSERT INTO `fees` (`Id`, `ServiceName`, `Amount`, `IsActive`, `Currency`, `CreatedAt`) VALUES
(1, 'Appointment Fee', 10.00, 1, 'USD', '2026-05-02 09:15:25.238786'),
(3, 'Certificate Fee', 25.00, 1, 'USD', '2026-07-20 11:53:53.000000');

-- --------------------------------------------------------

--
-- Table structure for table `marriage_applications`
--

CREATE TABLE `marriage_applications` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) DEFAULT NULL,
  `HusbandName` varchar(200) NOT NULL,
  `HusbandDob` datetime(6) NOT NULL,
  `HusbandIdNumber` varchar(100) NOT NULL,
  `HusbandContactNumber` varchar(50) NOT NULL,
  `HusbandAddress` varchar(500) NOT NULL,
  `WifeName` varchar(200) NOT NULL,
  `WifeDob` datetime(6) NOT NULL,
  `WifeIdNumber` varchar(100) NOT NULL,
  `WifeContactNumber` varchar(50) NOT NULL,
  `WifeAddress` varchar(500) NOT NULL,
  `MarriageDate` datetime(6) NOT NULL,
  `MarriageLocation` varchar(300) NOT NULL,
  `Status` varchar(30) NOT NULL,
  `SubmissionDate` datetime(6) NOT NULL,
  `Remarks` varchar(2000) DEFAULT NULL,
  `DecisionDate` datetime(6) DEFAULT NULL,
  `HusbandFatherName` varchar(200) DEFAULT NULL,
  `HusbandMotherName` varchar(200) DEFAULT NULL,
  `HusbandNationality` varchar(100) DEFAULT NULL,
  `HusbandOccupation` varchar(150) DEFAULT NULL,
  `HusbandResidenceStatus` varchar(30) DEFAULT NULL,
  `HusbandMaritalStatus` varchar(100) DEFAULT NULL,
  `WifeFatherName` varchar(200) DEFAULT NULL,
  `WifeMotherName` varchar(200) DEFAULT NULL,
  `WifeNationality` varchar(100) DEFAULT NULL,
  `WifeOccupation` varchar(150) DEFAULT NULL,
  `WifeResidenceStatus` varchar(30) DEFAULT NULL,
  `WifeMaritalStatus` varchar(100) DEFAULT NULL,
  `MarriageType` varchar(30) DEFAULT NULL,
  `Meher` varchar(500) DEFAULT NULL,
  `HusbandReligion` varchar(100) DEFAULT NULL,
  `WifeReligion` varchar(100) DEFAULT NULL,
  `SheikhName` varchar(200) DEFAULT NULL,
  `District` varchar(200) DEFAULT NULL,
  `AppointmentDate` datetime(6) DEFAULT NULL,
  `AppointmentTime` varchar(50) DEFAULT NULL,
  `AppointmentStatus` varchar(30) NOT NULL DEFAULT 'Pending',
  `CertificateFeeStatus` varchar(30) DEFAULT NULL,
  `CertificateFeeAmount` decimal(18,2) DEFAULT NULL,
  `CertificateFeePaidAt` datetime(6) DEFAULT NULL,
  `CertificateFeeVerifiedBy` varchar(200) DEFAULT NULL,
  `CertificateFeeVerifiedAt` datetime(6) DEFAULT NULL,
  `CertificateFeeReceiptImage` varchar(500) DEFAULT NULL,
  `CertificateFeeSenderPhone` varchar(50) DEFAULT NULL,
  `CertificateFeeTransactionNumber` varchar(100) DEFAULT NULL,
  `CertificateFeeRejectionReason` varchar(500) DEFAULT NULL,
  `CertificateFeePaymentMethod` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marriage_applications`
--

INSERT INTO `marriage_applications` (`Id`, `UserId`, `HusbandName`, `HusbandDob`, `HusbandIdNumber`, `HusbandContactNumber`, `HusbandAddress`, `WifeName`, `WifeDob`, `WifeIdNumber`, `WifeContactNumber`, `WifeAddress`, `MarriageDate`, `MarriageLocation`, `Status`, `SubmissionDate`, `Remarks`, `DecisionDate`, `HusbandFatherName`, `HusbandMotherName`, `HusbandNationality`, `HusbandOccupation`, `HusbandResidenceStatus`, `HusbandMaritalStatus`, `WifeFatherName`, `WifeMotherName`, `WifeNationality`, `WifeOccupation`, `WifeResidenceStatus`, `WifeMaritalStatus`, `MarriageType`, `Meher`, `HusbandReligion`, `WifeReligion`, `SheikhName`, `District`, `AppointmentDate`, `AppointmentTime`, `AppointmentStatus`, `CertificateFeeStatus`, `CertificateFeeAmount`, `CertificateFeePaidAt`, `CertificateFeeVerifiedBy`, `CertificateFeeVerifiedAt`, `CertificateFeeReceiptImage`, `CertificateFeeSenderPhone`, `CertificateFeeTransactionNumber`, `CertificateFeeRejectionReason`, `CertificateFeePaymentMethod`) VALUES
(32, NULL, 'Maxamed xasan Axmed', '1989-07-20 00:00:00.000000', '7676777', '62263536', 'kaaran', 'Xalimo Xsan Axmed', '2012-07-20 00:00:00.000000', '3743443', '56223235', 'Kaaran', '2021-07-20 00:00:00.000000', 'Banaadir', 'Approved', '2026-07-20 16:54:37.383876', NULL, NULL, NULL, 'Faadumo  xasan cali', NULL, 'Bajaaj', NULL, 'Ma guursan', NULL, 'xaawo xasan cali', NULL, 'Gurijogto', NULL, 'Ma guursan', 'Dahab', '50 gram', 'Islam', 'islam', 'sheikh Dabcasar', 'Kaaran', NULL, NULL, 'Pending', NULL, 10.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 17, 'kdjfdkjfdk', '1996-07-20 00:00:00.000000', '4454', '454', 'dksdjskdjsk', 'msjskdjsk', '1998-07-20 00:00:00.000000', '34343', '3435353', 'sdjskdjsk', '2026-07-20 00:00:00.000000', 'sjhdhdsj', 'Approved', '2026-07-20 17:16:56.978737', NULL, '2026-07-20 17:55:08.540701', NULL, 'dkdkfjdk', NULL, 'dfhdhd', NULL, 'Ma guursan', NULL, 'sdsjdkdjsk', NULL, 'sjdsjshdjs', NULL, 'Ma guursan', 'Lacag', '33', 'sksjdsk', 'sdksdjsk', 'kjksdjsdjsdkj', 'sskdjsdk', NULL, NULL, 'Pending', 'Paid', 10.00, '2026-07-20 17:54:40.337076', NULL, NULL, NULL, NULL, NULL, NULL, 'Office'),
(34, 25, 'jdshdjshdjs', '2026-07-21 00:00:00.000000', '2837238278', '87878787', 'shdjshdsj', 'jshdjsdhsjs', '2026-07-21 00:00:00.000000', '747376473', '338473874', 'hdjsdhsjdhs', '2026-07-21 00:00:00.000000', 'hddjdhs', 'Approved', '2026-07-21 07:06:52.044255', NULL, NULL, NULL, 'jshasjahjhj', NULL, 'sjshjshjhj', NULL, 'Guursaday', NULL, 'sjhshjshds', NULL, 'wsdgsdgsdjs', NULL, 'Guursatay', 'Dahab', '3673', 'dhhfjshds', 'hfjdhfdj', 'hdhdkdfhdksfdfks', 'hjshdsjdhsd', NULL, NULL, 'Pending', 'Paid', 10.00, '2026-07-21 07:07:24.645441', NULL, NULL, NULL, NULL, NULL, NULL, 'Office');

-- --------------------------------------------------------

--
-- Table structure for table `marriage_witnesses`
--

CREATE TABLE `marriage_witnesses` (
  `Id` int(11) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `SortOrder` tinyint(3) UNSIGNED NOT NULL,
  `FullName` varchar(200) NOT NULL,
  `DateOfBirth` datetime(6) NOT NULL,
  `IdNumber` varchar(100) NOT NULL,
  `ContactNumber` varchar(50) NOT NULL,
  `Address` varchar(500) NOT NULL,
  `MotherName` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marriage_witnesses`
--

INSERT INTO `marriage_witnesses` (`Id`, `ApplicationId`, `SortOrder`, `FullName`, `DateOfBirth`, `IdNumber`, `ContactNumber`, `Address`, `MotherName`) VALUES
(59, 32, 1, 'Xasan geedi nuur', '1992-07-20 00:00:00.000000', '37634747', '634747436', 'Banaadir, Hodan', 'Nuuo xasan cali'),
(60, 32, 2, 'Cali nuur axmed', '2007-07-20 00:00:00.000000', '226734343', '376434343', 'Banaadir, Yaqshiid', 'xaawo geedi nuur'),
(61, 33, 1, 'jsdjsdhsdsjhj', '1991-07-20 00:00:00.000000', '36474637', '7346374637', 'jdhjdshhj', 'shdhdsdhsjh'),
(62, 33, 2, 'jshdjhsdjs', '1986-07-20 00:00:00.000000', '3764736', '73736', 'jhjhdjdhsj', 'shdshdsdjh'),
(63, 34, 1, 'shdhsjdhsjdhdjs', '2026-07-21 00:00:00.000000', '3838484738', '6374634367', 'shjhdshdsjdh', 'sdhsjdhsjdhs'),
(64, 34, 2, 'sdyudsuddsu', '2026-07-21 00:00:00.000000', '746723723', '3763746343', 'shdjhsdjhdhdjs', 'sjhdhsjhdsdhj');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `Id` int(11) NOT NULL,
  `ApplicationId` int(11) NOT NULL,
  `Amount` decimal(18,2) NOT NULL,
  `PaymentStatus` varchar(30) NOT NULL,
  `PaymentDate` datetime(6) DEFAULT NULL,
  `ReceiptImage` varchar(500) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  `FeeId` int(11) NOT NULL,
  `SenderPhone` varchar(50) DEFAULT NULL,
  `TransactionNumber` varchar(100) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL,
  `ApplicationFee` decimal(18,2) NOT NULL DEFAULT 0.00,
  `PaymentMethod` varchar(20) DEFAULT NULL,
  `PaymentProofPath` varchar(500) DEFAULT NULL,
  `TransactionReference` varchar(100) DEFAULT NULL,
  `RejectionReason` varchar(500) DEFAULT NULL,
  `VerifiedBy` varchar(200) DEFAULT NULL,
  `VerifiedAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`Id`, `ApplicationId`, `Amount`, `PaymentStatus`, `PaymentDate`, `ReceiptImage`, `UserId`, `FeeId`, `SenderPhone`, `TransactionNumber`, `CreatedAt`, `ApplicationFee`, `PaymentMethod`, `PaymentProofPath`, `TransactionReference`, `RejectionReason`, `VerifiedBy`, `VerifiedAt`) VALUES
(36, 32, 25.00, 'Approved', '2026-07-20 16:55:44.633302', NULL, NULL, 1, '61233252', '62652645', '2026-07-20 16:54:37.958787', 15.00, 'Office', NULL, NULL, NULL, NULL, NULL),
(37, 33, 15.00, 'Approved', '2026-07-20 17:54:40.333876', 'uploads/payments/33_1f2393555c374bbca318b9a6a3e806aa.jpg', 17, 1, '622224', '34343', '2026-07-20 17:16:57.296160', 15.00, 'Office', NULL, NULL, NULL, NULL, NULL),
(38, 34, 25.00, 'Approved', '2026-07-21 07:08:41.731418', NULL, 25, 1, '846574', '746437', '2026-07-21 07:06:52.661983', 15.00, 'Office', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`Id`, `Name`) VALUES
(3, 'ApproveApplication'),
(10, 'ApproveApplications'),
(1, 'CreateApplication'),
(4, 'IssueCertificate'),
(12, 'ManageAppointments'),
(7, 'ManageFees'),
(8, 'ManagePayments'),
(6, 'ManageRoles'),
(5, 'ManageUsers'),
(11, 'RejectApplications'),
(13, 'VerifyApplications'),
(2, 'ViewApplication'),
(9, 'ViewDashboard');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `Id` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `CreatedAt` datetime(6) NOT NULL DEFAULT current_timestamp(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`Id`, `Name`, `CreatedAt`) VALUES
(1, 'Staff', '2026-05-07 14:02:59.118116'),
(2, 'Admin', '2026-05-07 14:02:59.133364'),
(3, 'User', '2026-05-07 12:15:53.156583');

-- --------------------------------------------------------

--
-- Table structure for table `role_permissions`
--

CREATE TABLE `role_permissions` (
  `RoleId` int(11) NOT NULL,
  `PermissionId` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permissions`
--

INSERT INTO `role_permissions` (`RoleId`, `PermissionId`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(2, 11),
(2, 12),
(2, 13);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `Id` int(11) NOT NULL,
  `Name` varchar(200) NOT NULL,
  `Email` varchar(256) NOT NULL,
  `Password` varchar(500) NOT NULL,
  `Role` varchar(50) NOT NULL,
  `PaymentStatus` varchar(30) NOT NULL DEFAULT 'Unpaid',
  `RoleId` int(11) DEFAULT NULL,
  `ResetOtpCode` varchar(6) DEFAULT NULL,
  `ResetOtpExpiry` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `Name`, `Email`, `Password`, `Role`, `PaymentStatus`, `RoleId`, `ResetOtpCode`, `ResetOtpExpiry`) VALUES
(1, 'System Administrator', 'admin@system.local', '$2a$11$DHJI2HRt4i0XCz8Nq0214.dOunhx2LG7P0ObaEsuviwA7MoKj.Ls6', 'Admin', 'Unpaid', 2, NULL, NULL),
(2, 'cali', 'cali@gmail.com', '$2a$11$KfPlOFqDGcfwkX8iMeVt1e1kFuDkRGTxS4UlcrQqgc5t8wsqlcJpe', 'User', 'Paid', 1, NULL, NULL),
(6, 'ahmed', 'ahmed@gmail.com', '$2a$11$gz/SDZG5L3/R5XsnjJgZw.tWvqwmPARlcj4PqUt9HXL8PF.EnwSO2', 'User', 'Unpaid', 1, NULL, NULL),
(7, 'moha abdi ali', 'moha12@gmail.com', '$2a$11$EAnldWG6OX5bNxQy3yJpAOBEqC0zD9BKjTdHLRUnKWsZFXypw.4NS', 'User', 'Paid', 1, NULL, NULL),
(11, 'yuu', 'yuu@gmail.com', '$2a$11$gXEfqbA69t0.LsUhUbHWpe86HXP3Miwk9hXigIDv5wOnr9aO9lUqC', 'Staff', 'Unpaid', 1, NULL, NULL),
(12, 'nuuro', 'nuuro@gmail.com', '$2a$11$3SPKgDivkIqUocQlojlzR.h91.cJskf25kzEAUsKdbMOQFy3dnmTW', 'User', 'Paid', 3, NULL, NULL),
(14, 'abdihafiid abdi', 'hafiidabdi6@gmail.com', '$2a$11$L1bZrVbnVm0y8fzMU.RB7uChgpeQPje/Jx7zkkDujxCYuXIrB06My', 'Admin', 'Unpaid', 2, NULL, NULL),
(16, 'cabdi', 'cabdi@gmail.com', '$2a$11$eYXZpZsDCN6.NSRJIYtBcu8UU94S6eGzMHXGPtcBf4ak.E9ref/lK', 'User', 'Unpaid', NULL, NULL, NULL),
(17, 'axmed', 'axmed@gmail.com', '$2a$11$J76Erx5GAONPrS3/guX4AeyNX8iRPNGo0LDhjeq3ucxGuESwYyxXe', 'User', 'Paid', 3, NULL, NULL),
(18, 'Hafso', 'Hafso@gmail.com', '$2a$11$39UZI6dzFKyWCr6gMdjAZ.4UzYuHrQW3KiWGq8Mr/dr44H1UQ.5tK', 'User', 'Unpaid', NULL, NULL, NULL),
(19, 'kaafi', 'kaafi@gmail.com', '$2a$11$5zC6JAxNkd/Gt1ZWjkqqauYGtqIrjEzMW7AuvBS5T/X6O/yF36.z2', 'User', 'Unpaid', NULL, NULL, NULL),
(20, 'Nuur cali', 'nuur@gmail.com', '$2a$11$3R9vSwH7VumI5FO1ZoytauYLcEFp5xiGwTDzK0fIMywbUJEUODsta', 'User', 'Unpaid', 3, NULL, NULL),
(21, 'test', 'test@gmail.com', '$2a$11$toOOr2yaaDAJSIWl0G2WY.OT7G9Lh7H67E4oFf9jCVIsFYkSBOjjW', 'User', 'Unpaid', NULL, NULL, NULL),
(22, 'ABDUQADIR AWYS MOHAMED', 'shaatax@123', '$2a$11$UJHHM1/Jg4E9XukJPHhKXePPv1hWhi8RggwYiuxPhyi4txLq.ktAi', 'User', 'Unpaid', 3, NULL, NULL),
(23, 'mustaf husein', 'mustaf@gmail.com', '$2a$11$WHwrS7o1lxYUXHmbWweQgOPynaJq.lGOV.bhQHdSudktCz548x9x6', 'User', 'Unpaid', 3, NULL, NULL),
(24, 'abdirah', 'dalnuurshe758@gmail.com', '$2a$11$.m91Znf2uuiTHzCGYDXyceBE/MhOT5tdnIqwrEFMon5b0qGy36HH6', 'User', 'Unpaid', 3, NULL, NULL),
(25, 'jdhhfd', 'hhhh@gmail.com', '$2a$11$dF6mL0n7HEQK4uiThetwquynuwhiyE.oNSR4fDUqI/poJhC96yQtO', 'User', 'Paid', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `__efmigrationshistory`
--

CREATE TABLE `__efmigrationshistory` (
  `MigrationId` varchar(150) NOT NULL,
  `ProductVersion` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `__efmigrationshistory`
--

INSERT INTO `__efmigrationshistory` (`MigrationId`, `ProductVersion`) VALUES
('20260405051534_InitialCreate', '8.0.11'),
('20260405064655_AddMarriageWitnesses', '8.0.11'),
('20260502051853_AddFeesAndPayments', '8.0.11'),
('20260502061052_ManualPaymentGatewayFlow', '8.0.11'),
('20260503104500_AddDocumentCategory', '8.0.11'),
('20260507103000_AddRbacCore', '8.0.11'),
('20260507120000_AddAdminPermissionsAndAccess', '8.0.11'),
('20260507141500_AddApplicationDecisionDate', '8.0.11'),
('20260507153000_AddAdminNotificationReadState', '8.0.11'),
('20260526120000_AddMarriageApplicationExtendedDetails', '8.0.11'),
('20260526130000_ChangeMeherToText', '8.0.11'),
('20260526140000_AddCreateApplicationFormFields', '8.0.11'),
('20260526150000_RenameWitnessFatherNameToMotherName', '8.0.11'),
('20260621120000_AddMarriageDistrict', '8.0.11'),
('20260622120000_AddAppointmentScheduling', '8.0.11'),
('20260622120100_AllowMultipleAppointmentsPerApplication', '8.0.11'),
('20260720100000_AddPaymentAndAppointmentFields', '8.0.11'),
('20260720110000_AddCertificateFeeTracking', '8.0.11'),
('20260720120000_SeedRequiredFees', '8.0.11'),
('20260720133154_MakeUserIdNullable', '8.0.11'),
('20260720144753_AddCertificateFeePaymentMethod', '8.0.11');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_notification_read_states`
--
ALTER TABLE `admin_notification_read_states`
  ADD PRIMARY KEY (`UserId`);

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_appointments_ReferenceNumber` (`ReferenceNumber`),
  ADD KEY `IX_appointments_ApplicationId` (`ApplicationId`),
  ADD KEY `IX_appointments_TimeSlotId` (`TimeSlotId`);

--
-- Indexes for table `appointment_time_slots`
--
ALTER TABLE `appointment_time_slots`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `appointment_working_days`
--
ALTER TABLE `appointment_working_days`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_appointment_working_days_DayOfWeek` (`DayOfWeek`);

--
-- Indexes for table `certificates`
--
ALTER TABLE `certificates`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_certificates_ApplicationId` (`ApplicationId`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_documents_ApplicationId` (`ApplicationId`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD PRIMARY KEY (`Id`);

--
-- Indexes for table `marriage_applications`
--
ALTER TABLE `marriage_applications`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IX_marriage_applications_UserId` (`UserId`);

--
-- Indexes for table `marriage_witnesses`
--
ALTER TABLE `marriage_witnesses`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_marriage_witnesses_ApplicationId_SortOrder` (`ApplicationId`,`SortOrder`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_payments_ApplicationId` (`ApplicationId`),
  ADD KEY `IX_payments_UserId` (`UserId`),
  ADD KEY `IX_payments_FeeId` (`FeeId`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `UX_permissions_Name` (`Name`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `UX_roles_Name` (`Name`);

--
-- Indexes for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`RoleId`,`PermissionId`),
  ADD KEY `IX_role_permissions_PermissionId` (`PermissionId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`Id`),
  ADD UNIQUE KEY `IX_users_Email` (`Email`),
  ADD KEY `IX_users_RoleId` (`RoleId`);

--
-- Indexes for table `__efmigrationshistory`
--
ALTER TABLE `__efmigrationshistory`
  ADD PRIMARY KEY (`MigrationId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `appointment_time_slots`
--
ALTER TABLE `appointment_time_slots`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `appointment_working_days`
--
ALTER TABLE `appointment_working_days`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `certificates`
--
ALTER TABLE `certificates`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=118;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `marriage_applications`
--
ALTER TABLE `marriage_applications`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `marriage_witnesses`
--
ALTER TABLE `marriage_witnesses`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `admin_notification_read_states`
--
ALTER TABLE `admin_notification_read_states`
  ADD CONSTRAINT `FK_admin_notification_read_states_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `FK_appointments_appointment_time_slots_TimeSlotId` FOREIGN KEY (`TimeSlotId`) REFERENCES `appointment_time_slots` (`Id`),
  ADD CONSTRAINT `FK_appointments_marriage_applications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `certificates`
--
ALTER TABLE `certificates`
  ADD CONSTRAINT `FK_certificates_marriage_applications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `FK_documents_marriage_applications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `marriage_applications`
--
ALTER TABLE `marriage_applications`
  ADD CONSTRAINT `FK_marriage_applications_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE SET NULL;

--
-- Constraints for table `marriage_witnesses`
--
ALTER TABLE `marriage_witnesses`
  ADD CONSTRAINT `FK_marriage_witnesses_marriage_applications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `FK_payments_fees_FeeId` FOREIGN KEY (`FeeId`) REFERENCES `fees` (`Id`),
  ADD CONSTRAINT `FK_payments_marriage_applications_ApplicationId` FOREIGN KEY (`ApplicationId`) REFERENCES `marriage_applications` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_payments_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`);

--
-- Constraints for table `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `FK_role_permissions_permissions_PermissionId` FOREIGN KEY (`PermissionId`) REFERENCES `permissions` (`Id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_role_permissions_roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `FK_users_roles_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `roles` (`Id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
