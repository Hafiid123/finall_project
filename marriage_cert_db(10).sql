-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2026 at 07:27 AM
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
(1, '2026-05-30 04:45:41.562143'),
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
(1, 22, 1, '2026-06-23 00:00:00.000000', 'APT-2026-000001', 'Completed', '2026-06-22 09:19:43.607859', NULL);

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
(40, 12, 'uploads/certificates/12_d15adc9bcb63482aa3df0d67a934e528.pdf'),
(64, 13, 'uploads/certificates/13_a29aa5c8cd274bf0ab3051176633f7f6.pdf'),
(79, 20, 'uploads/certificates/20_65875d170c054ee9a386d1f2e8ac11e3.pdf'),
(81, 21, 'uploads/certificates/21_be6e24cb95e54c9fb56c111203ab1bc9.pdf'),
(82, 22, 'uploads/certificates/22_427d6a086c794623be3423672d8ddd77.pdf');

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
(14, 12, 'uploads/documents/0d8f0e040ea94b92afd38874045f7bfc.jpg', 'HusbandIdentityDocument'),
(15, 12, 'uploads/documents/025ccc4712ba413f92d16e8db5b5a945.jpg', 'WifeIdentityDocument'),
(16, 12, 'uploads/documents/3be87af91137493a8e8419b930a4ecd2.jpg', 'Witness1IdentityDocument'),
(17, 12, 'uploads/documents/1912fd3770a34df38ebc17fcec1f85fc.jpg', 'Witness2IdentityDocument'),
(18, 12, 'uploads/documents/1f31df29b4b847e384ec185fbe1d07a4.webp', 'HusbandPassportPhoto'),
(19, 12, 'uploads/documents/3ba89cb1b34046bdb5710ea7c0997757.webp', 'WifePassportPhoto'),
(20, 13, 'uploads/documents/e749c0a2d6e349e7b05147d6d8c3fb8f.jpg', 'HusbandIdentityDocument'),
(21, 13, 'uploads/documents/0b94135800744b3db9dfcdf67c93c82e.jpg', 'WifeIdentityDocument'),
(22, 13, 'uploads/documents/3b59d60360c640bba5a5866a89dbdacc.jpg', 'Witness1IdentityDocument'),
(23, 13, 'uploads/documents/e297bd54bc0b4e2cb1aa363d55cd2f63.jpg', 'Witness2IdentityDocument'),
(24, 13, 'uploads/documents/4d93b24bbbf84a36aff6deb38e202259.webp', 'HusbandPassportPhoto'),
(25, 13, 'uploads/documents/32866cd6b44c460fbcfdbacd17ceeb90.webp', 'WifePassportPhoto'),
(50, 18, '/uploads/7726fc67-ef4a-4850-a546-d51ceef81410_a15.jpg', 'HusbandIdentityDocument'),
(51, 18, '/uploads/5c03f4ba-c92c-4d66-afc0-a082ebb1fdef_a15.jpg', 'HusbandPassportPhoto'),
(52, 18, '/uploads/1e3d5ed4-2219-4a17-bbee-ea591ba6a45a_a15.jpg', 'WifeIdentityDocument'),
(53, 18, '/uploads/18b3b23e-4a0d-434b-9e08-121ea3dee33b_a15.jpg', 'WifePassportPhoto'),
(54, 18, '/uploads/437d8084-a1f0-4c16-8401-323296824581_a15.jpg', 'Witness1IdentityDocument'),
(55, 18, '/uploads/c05a8052-0a0f-4261-a720-c5a903543baa_a15.jpg', 'Witness2IdentityDocument'),
(56, 20, '/uploads/47799178-bdfb-46fb-8596-c16c73487a4c_a15.jpg', 'HusbandIdentityDocument'),
(57, 20, '/uploads/593bb0af-b327-44a2-ad35-d7c3c3d7b154_a15.jpg', 'WifeIdentityDocument'),
(58, 20, '/uploads/5218cae8-e0c6-4474-9d4a-32d3b1381cbb_a15.jpg', 'Witness1IdentityDocument'),
(59, 20, '/uploads/2116a152-25fd-4b62-9e03-2e8991a22d50_a15.jpg', 'Witness2IdentityDocument'),
(60, 21, 'uploads/documents/d4467b15468643e286cdfb3f28d260fe.jpg', 'HusbandIdentityDocument'),
(61, 21, 'uploads/documents/a216d937df034bca943ea57f1d67a4d9.jpg', 'WifeIdentityDocument'),
(62, 21, 'uploads/documents/8c3f5a9fc80d47dbbda9290ea3f15974.jpg', 'Witness1IdentityDocument'),
(63, 21, 'uploads/documents/8d0524a549ae4e9291a2d29d45daaca2.jpg', 'Witness2IdentityDocument'),
(64, 22, 'uploads/documents/694ada8094194b5faa5b00bb7dfa7420.jpg', 'HusbandIdentityDocument'),
(65, 22, 'uploads/documents/bbd5e5edb87249528f14bcbd950e1af6.jpg', 'WifeIdentityDocument'),
(66, 22, 'uploads/documents/28c37abd0a2f451793347203495fa8bc.jpg', 'Witness1IdentityDocument'),
(67, 22, 'uploads/documents/1bb25825c5514bc7b41ee5cd59cd929d.jpg', 'Witness2IdentityDocument');

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
(1, 'Marriage Application', 15.00, 1, 'USD', '2026-05-02 09:15:25.238786'),
(2, 'certificate', 15.10, 1, 'USD', '2026-05-02 09:15:25.238786');

-- --------------------------------------------------------

--
-- Table structure for table `marriage_applications`
--

CREATE TABLE `marriage_applications` (
  `Id` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
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
  `District` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `marriage_applications`
--

INSERT INTO `marriage_applications` (`Id`, `UserId`, `HusbandName`, `HusbandDob`, `HusbandIdNumber`, `HusbandContactNumber`, `HusbandAddress`, `WifeName`, `WifeDob`, `WifeIdNumber`, `WifeContactNumber`, `WifeAddress`, `MarriageDate`, `MarriageLocation`, `Status`, `SubmissionDate`, `Remarks`, `DecisionDate`, `HusbandFatherName`, `HusbandMotherName`, `HusbandNationality`, `HusbandOccupation`, `HusbandResidenceStatus`, `HusbandMaritalStatus`, `WifeFatherName`, `WifeMotherName`, `WifeNationality`, `WifeOccupation`, `WifeResidenceStatus`, `WifeMaritalStatus`, `MarriageType`, `Meher`, `HusbandReligion`, `WifeReligion`, `SheikhName`, `District`) VALUES
(12, 12, 'fhdfhdjsjdfs', '1996-05-16 00:00:00.000000', '564756', '75647856', 'gdfjhgdjfh', 'dfhjkdfhjkfsd', '1998-05-16 00:00:00.000000', '8744387', '74673468', 'hdfdsjkfsdhk', '2026-05-16 00:00:00.000000', 'hjdkjdhsa', 'Rejected', '2026-05-16 10:17:08.609707', 'kulaabo wll xogta', '2026-05-18 12:56:42.591914', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(13, 12, 'Maxmed Ahmed Diini', '1993-05-15 00:00:00.000000', '46264636', '061353636', 'Yaqshiid', 'Faadmo Daahir Nuur', '1998-05-18 00:00:00.000000', '6463473', '061426366', 'Yaqshiid', '2007-05-18 00:00:00.000000', 'Yaqshiid', 'Approved', '2026-05-18 13:01:29.123007', NULL, '2026-05-18 13:05:19.440271', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 2, 'Cabdi cali geedi', '1988-05-06 00:00:00.000000', '465746547', '71746764', 'kaaran', 'Faadmo Daahir Nuur', '2001-07-05 00:00:00.000000', '545454', '646464', 'Hodan', '2016-04-05 00:00:00.000000', 'Hodan taleex', 'Approved', '2026-06-20 11:37:45.871073', NULL, NULL, 'cali geedi cali', 'Faadumo  xasan cali', 'Islam', 'Ganacsade', 'Resident', 'Single', 'Daahir Nuur cali', 'Hodan cabdi geedi', 'Islam', 'Gurijogto', 'Resident', 'Single', 'Religious', '500$', NULL, NULL, NULL, NULL),
(20, 19, 'Yasiin xasan cali', '2000-07-07 00:00:00.000000', '6756375637', '76575647', 'Hodan', 'Nuuro cali geedi', '2001-06-06 00:00:00.000000', '6757564', '736457657348', 'Hodan', '2010-06-06 00:00:00.000000', 'Muqdisho', 'Approved', '2026-06-20 10:45:04.474446', NULL, '2026-06-21 10:33:11.087710', 'Xasan cali acmed', 'Faadumo  xasan yusuf', NULL, 'Bajaaj', NULL, 'Ma guursan', 'Cali geedi xasan', 'Nuurto Cali Axmed', NULL, 'Gurijogto', NULL, 'Guursatay', 'Lacag', '500$', 'Islam', 'islam', 'Maxamed Xasan Axmed', 'Hodan'),
(21, 17, 'Maxamed xasan Axmed', '1996-06-21 00:00:00.000000', '7757655565', '657465447', 'Kaaran', 'Xaawo Axmed Nuur', '1998-06-21 00:00:00.000000', '46347367', '7356375', 'Kaaran', '2026-06-21 00:00:00.000000', 'Banaadir', 'Approved', '2026-06-21 14:57:10.550205', NULL, '2026-06-21 15:01:10.764427', 'Xasan Axmed cali', 'Safiyo Cbdi Nuur', NULL, 'Taksiile', NULL, 'Ma guursan', 'Axmed Nuur Farax', 'Nuurto Cali Axmed', NULL, 'Macalimad', NULL, 'Ma guursan', 'Dahab', '50 gram', 'Islam', 'islam', 'Muuse Nuur Gacal', 'Hodan'),
(22, 20, 'Maxamed xasan Axmed', '1996-06-22 00:00:00.000000', '545454', '756374367', 'Hodan', 'Nuuro cali geedi', '1998-06-22 00:00:00.000000', '7356376537', '45454', 'Hodan', '2013-06-22 00:00:00.000000', 'Muqdisho', 'Approved', '2026-06-22 09:19:11.631084', NULL, '2026-06-22 09:23:29.858516', NULL, 'Nuuro Xasan cali', NULL, 'Bajaaj', NULL, 'Guursaday', NULL, 'Nuurto Cali Axmed', NULL, 'Gurijogto', NULL, 'Ma guursan', 'Dahab', '5 GR', 'Islam', 'islam', 'Maxamed Xasan Axmed', 'Kaaran');

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
(19, 12, 1, 'hdfhfgdjfjdsgfsd', '1991-05-16 00:00:00.000000', '3634673463', '67534756834', 'dhfdjshskdjh', NULL),
(20, 12, 2, 'jdhfjdfhdfkjsdh', '1986-05-16 00:00:00.000000', '8375678562', '436537865', 'dhfjkjfgskjfka', NULL),
(21, 13, 1, 'Faarax Geedi Cali', '1991-05-18 00:00:00.000000', '647375377', '63463466', 'Kaaran', NULL),
(22, 13, 2, 'Maxamed Ahmed Cali', '1986-05-18 00:00:00.000000', '757347347', '612634848', 'Yaqshiid', NULL),
(35, 20, 1, 'Xasan geedi nuur', '0001-08-14 00:00:00.000000', '6547547', '75636537', 'Muqdisho, Deynile', 'Hadiyo xasan cali'),
(36, 20, 2, 'Cali nuur axmed', '2003-06-18 00:00:00.000000', '7356753', '63756375637', 'Muqdisho, Hodan', 'Kaafiyo cali nuur'),
(37, 21, 1, 'c/laahi xasan nuur', '1991-06-21 00:00:00.000000', '73637637', '7673637', 'Banaadir, Kaaran', 'Bahjo cali geedi'),
(38, 21, 2, 'Ilyaas Abdi Nuur', '1986-06-21 00:00:00.000000', '73467436', '763463743', 'Banaadir , Kaaran', 'Khadiijo Abdi Nuur'),
(39, 22, 1, 'Cali Axmed Cbdi', '1991-06-22 00:00:00.000000', '54454', '535353', 'Banaadir, Hodan', 'Bahjo cali geedi'),
(40, 22, 2, 'Cali nuur axmed', '1986-06-22 00:00:00.000000', '545454', '533535', 'Muqdisho, Hodan', 'Kaafiyo cali nuur');

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
  `UserId` int(11) NOT NULL,
  `FeeId` int(11) NOT NULL,
  `SenderPhone` varchar(50) DEFAULT NULL,
  `TransactionNumber` varchar(100) DEFAULT NULL,
  `CreatedAt` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`Id`, `ApplicationId`, `Amount`, `PaymentStatus`, `PaymentDate`, `ReceiptImage`, `UserId`, `FeeId`, `SenderPhone`, `TransactionNumber`, `CreatedAt`) VALUES
(10, 12, 15.00, 'Approved', '2026-05-16 10:18:29.776444', 'uploads/payments/12_8baaf88aac654c22b2f557a40c20a538.jpg', 12, 1, '645646', '487538457', '2026-05-16 10:17:08.750161'),
(11, 13, 15.00, 'Approved', '2026-05-18 13:03:07.034239', 'uploads/payments/13_eec93cf686c84a07a9d43127dbb765c0.jpg', 12, 1, '61967786', '6636343264', '2026-05-18 13:01:29.482089'),
(22, 21, 15.00, 'Approved', '2026-06-21 14:58:50.467897', 'uploads/payments/21_0527d0a8c2fe439f942d46609edd8392.png', 17, 1, '366434647', '77634737', '2026-06-21 14:57:10.668528'),
(23, 22, 15.00, 'Approved', '2026-06-22 09:23:29.858345', NULL, 20, 1, '—', 'PAY_AT_OFFICE', '2026-06-22 09:19:11.905988'),
(24, 18, 15.00, 'Pending', NULL, NULL, 2, 1, NULL, NULL, '2026-06-25 12:02:26.287650'),
(25, 20, 15.00, 'Pending', NULL, NULL, 19, 1, NULL, NULL, '2026-06-25 12:02:26.385059');

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
  `RoleId` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`Id`, `Name`, `Email`, `Password`, `Role`, `PaymentStatus`, `RoleId`) VALUES
(1, 'System Administrator', 'admin@system.local', '$2a$11$DHJI2HRt4i0XCz8Nq0214.dOunhx2LG7P0ObaEsuviwA7MoKj.Ls6', 'Admin', 'Unpaid', 2),
(2, 'cali', 'cali@gmail.com', '$2a$11$KfPlOFqDGcfwkX8iMeVt1e1kFuDkRGTxS4UlcrQqgc5t8wsqlcJpe', 'User', 'Paid', 1),
(6, 'ahmed', 'ahmed@gmail.com', '$2a$11$gz/SDZG5L3/R5XsnjJgZw.tWvqwmPARlcj4PqUt9HXL8PF.EnwSO2', 'User', 'Unpaid', 1),
(7, 'moha abdi ali', 'moha12@gmail.com', '$2a$11$EAnldWG6OX5bNxQy3yJpAOBEqC0zD9BKjTdHLRUnKWsZFXypw.4NS', 'User', 'Paid', 1),
(11, 'yuu', 'yuu@gmail.com', '$2a$11$gXEfqbA69t0.LsUhUbHWpe86HXP3Miwk9hXigIDv5wOnr9aO9lUqC', 'Staff', 'Unpaid', 1),
(12, 'nuuro', 'nuuro@gmail.com', '$2a$11$3SPKgDivkIqUocQlojlzR.h91.cJskf25kzEAUsKdbMOQFy3dnmTW', 'User', 'Paid', 3),
(14, 'abdihafiid abdi', 'hafiidabdi6@gmail.com', '$2a$11$L1bZrVbnVm0y8fzMU.RB7uChgpeQPje/Jx7zkkDujxCYuXIrB06My', 'Admin', 'Unpaid', 2),
(16, 'cabdi', 'cabdi@gmail.com', '$2a$11$eYXZpZsDCN6.NSRJIYtBcu8UU94S6eGzMHXGPtcBf4ak.E9ref/lK', 'User', 'Unpaid', NULL),
(17, 'axmed', 'axmed@gmail.com', '$2a$11$J76Erx5GAONPrS3/guX4AeyNX8iRPNGo0LDhjeq3ucxGuESwYyxXe', 'User', 'Paid', 3),
(18, 'Hafso', 'Hafso@gmail.com', '$2a$11$39UZI6dzFKyWCr6gMdjAZ.4UzYuHrQW3KiWGq8Mr/dr44H1UQ.5tK', 'User', 'Unpaid', NULL),
(19, 'kaafi', 'kaafi@gmail.com', '$2a$11$5zC6JAxNkd/Gt1ZWjkqqauYGtqIrjEzMW7AuvBS5T/X6O/yF36.z2', 'User', 'Unpaid', NULL),
(20, 'Nuur', 'nuur@gmail.com', '$2a$11$3R9vSwH7VumI5FO1ZoytauYLcEFp5xiGwTDzK0fIMywbUJEUODsta', 'User', 'Unpaid', 3);

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
('20260622120100_AllowMultipleAppointmentsPerApplication', '8.0.11');

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `fees`
--
ALTER TABLE `fees`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `marriage_applications`
--
ALTER TABLE `marriage_applications`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `marriage_witnesses`
--
ALTER TABLE `marriage_witnesses`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

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
  ADD CONSTRAINT `FK_marriage_applications_users_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`);

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
