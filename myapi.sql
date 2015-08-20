-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 20, 2015 at 02:16 PM
-- Server version: 5.6.21
-- PHP Version: 5.6.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `myapi`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE IF NOT EXISTS `accounts` (
`id` int(10) unsigned NOT NULL,
  `memberId` int(11) NOT NULL,
  `addedBy` int(11) NOT NULL,
  `type` enum('0','1') COLLATE utf8_unicode_ci NOT NULL,
  `amount` decimal(65,10) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `token_id` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `memberId`, `addedBy`, `type`, `amount`, `created_at`, `updated_at`, `token_id`) VALUES
(1, 10, 11, '1', '25000000.0000000000', '2015-08-20 11:52:47', '2015-08-20 11:52:47', NULL),
(3, 10, 0, '0', '310000.0000000000', '2015-08-20 12:10:09', '2015-08-20 12:10:09', 6);

-- --------------------------------------------------------

--
-- Table structure for table `add_products`
--

CREATE TABLE IF NOT EXISTS `add_products` (
`id` int(10) unsigned NOT NULL,
  `stockId` int(11) NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `addedBy` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `add_products`
--

INSERT INTO `add_products` (`id`, `stockId`, `quantity`, `addedBy`, `created_at`, `updated_at`) VALUES
(2, 26, 60000.00, 1, '2015-08-20 06:49:52', '2015-08-20 06:49:52');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE IF NOT EXISTS `branches` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `delivery_charge` float NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `location`, `delivery_charge`, `created_at`, `updated_at`) VALUES
(50, 'KTM', 'Kritipur', 100, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `client_stocks`
--

CREATE TABLE IF NOT EXISTS `client_stocks` (
`id` int(10) unsigned NOT NULL,
  `memberId` int(11) NOT NULL,
  `stockId` int(11) NOT NULL,
  `amount` int(11) NOT NULL,
  `status` enum('0','1','2') COLLATE utf8_unicode_ci NOT NULL,
  `cost` decimal(65,10) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `client_stocks`
--

INSERT INTO `client_stocks` (`id`, `memberId`, `stockId`, `amount`, `status`, `cost`, `created_at`, `updated_at`) VALUES
(6, 10, 26, 1000, '0', '310000.0000000000', '2015-08-20 12:10:09', '2015-08-20 12:10:09');

-- --------------------------------------------------------

--
-- Table structure for table `logins`
--

CREATE TABLE IF NOT EXISTS `logins` (
`id` int(10) unsigned NOT NULL,
  `member_id` int(10) unsigned NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` enum('1','0') COLLATE utf8_unicode_ci NOT NULL,
  `login_from` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`id`, `member_id`, `remember_token`, `status`, `login_from`, `created_at`, `updated_at`) VALUES
(5, 1, 'bslno8HTPRRL0Um', '1', '::1', '2015-08-20 04:39:51', '2015-08-20 04:39:51'),
(6, 1, 'olVWyd1l5G24uJs', '0', '::1', '2015-08-20 04:49:46', '2015-08-20 11:48:29'),
(7, 1, 'eMSCHkYQui4RLdP', '0', '::1', '2015-08-20 04:51:40', '2015-08-20 08:10:39'),
(8, 10, 'VH56dzbBVFIUcrv', '1', '::1', '2015-08-20 08:10:47', '2015-08-20 08:10:47'),
(9, 11, 'nV5Ip7nkIKW8i8a', '0', '::1', '2015-08-20 11:48:44', '2015-08-20 11:49:13'),
(10, 1, 'NyzCuC6CPLJYUT7', '0', '::1', '2015-08-20 11:49:19', '2015-08-20 11:51:59'),
(11, 11, 'BRlUpRHnJ5cIfRm', '0', '::1', '2015-08-20 11:52:07', '2015-08-20 12:08:15'),
(12, 1, 'xETwmdyg0ZUCFwD', '1', '::1', '2015-08-20 12:08:20', '2015-08-20 12:08:20');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE IF NOT EXISTS `members` (
  `id` int(10) unsigned NOT NULL,
  `fname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `identity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nationality` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dob` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `ban` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cNumber` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mNumber` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` enum('0','1','2') COLLATE utf8_unicode_ci NOT NULL,
  `mtype` int(11) DEFAULT NULL,
  `agentId` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `fname`, `mname`, `lname`, `address`, `identity`, `nationality`, `dob`, `ban`, `email`, `cNumber`, `mNumber`, `username`, `password`, `status`, `mtype`, `agentId`, `created_at`, `updated_at`) VALUES
(1, 'prem', 'kumar', 'singh', 'ktm', '1235', 'nepales', '', '', '', '', '', 'admin', '$2y$10$LpA28z1z2ti3d2bMyUB5zuvWKcFPwon1cW2TS/gyA/iP0ntAct.0q', '1', 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 'sulav', 'k', 'kafle', 'balkhu', '1234', 'nepales', '1992', '1424', 'sulav@test.com', '9804835317', '980', 'bank', '$2y$10$Ve2eaANY4oia69e9PDdMtOCohh.MiKAYwQChas5oNes3XpgZS9HHi', '1', 0, NULL, '2015-08-05 20:28:50', '2015-08-05 20:34:24'),
(3, 'suraj', '', 'sh', 'ktm', '1234', 'nepales', '1986', '1234', 'suraj@test.com', '987', '980', 'jhjh', '$2y$10$MTOfr2d8OGLPGQ7beXAWJulgz1AdExmJMtP.oh99nyTbIOaxDP08K', '0', 5, NULL, '2015-08-06 11:34:39', '2015-08-17 15:44:14'),
(10, 'sulav', 'python', 'safle', 'ktm', '123', 'ne', '1992', '123', 'sulav@test.com', '987', '987', 'client', '$2y$10$saZe/VMazuxbzsuZ7xL/5.SdAnD/JLmZApXxxV9BLLr2Tb.h34ddG', '1', 6, NULL, '2015-08-07 09:14:26', '2015-08-07 10:12:19'),
(11, 'Amrit', 'ku', 'pant', 'ktm', '1234', 'nepales', '1986', '1234', 'amrit@test.com', '987', '986', 'account', '$2y$10$ux8ib5WoczRhp7xSoej8JO8QWpc/XcAhgwmzEHMaKk7MLmZeIVPUi', '1', 3, NULL, '2015-08-08 03:10:18', '2015-08-08 03:10:58'),
(81, 'test', 'k', 'kjk', 'kjkj', 'kjk', 'jkjk', 'jkjk', 'kjkjk', 'kjkj@test.com', '987', '987', '', '$2y$10$rf6CjU3abJODCLV0Q1n69.pWUpP4dLjakQcn63E7zzrAihYVC7yAq', '0', 6, 82, '2015-08-18 05:20:14', '2015-08-18 05:20:14'),
(82, 'agent', 'k', 'test', 'test', '1234', 'nepales', '1989', '1234', 'agent@test.com', '987', '980', 'agent', '$2y$10$5hRfxVAVZDQqBI7dI2i/BeSb3NFUhwa/.CmE7ak6OlBoDlRcNUxMG', '1', 7, NULL, '2015-08-18 05:27:44', '2015-08-18 05:37:00');

-- --------------------------------------------------------

--
-- Table structure for table `member_type`
--

CREATE TABLE IF NOT EXISTS `member_type` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `member_type`
--

INSERT INTO `member_type` (`id`, `name`) VALUES
(1, 'NDEX Admin'),
(2, 'Bank Admin'),
(3, 'Account Admin'),
(4, 'Dealing Admin'),
(5, 'Branch Admin'),
(6, 'client'),
(7, 'Agent');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`migration`, `batch`) VALUES
('2014_10_12_000000_create_users_table', 1),
('2014_10_12_100000_create_password_resets_table', 1),
('2015_06_18_100716_create_members_table', 1),
('2015_06_18_101927_create_logins_table', 1),
('2015_07_05_031008_create_branches_table', 1),
('2015_08_05_095927_create_stock_table', 2),
('2015_08_06_095033_create_productType_table', 3),
('2015_08_06_172452_creat_memberType_table', 4),
('2015_08_07_174935_create_account_table', 5),
('2015_08_08_130647_create_clientStock_table', 6),
('2015_08_12_162447_create_addProduct_table', 7),
('2015_08_18_161117_create_notice_table', 8);

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE IF NOT EXISTS `notices` (
  `id` int(10) unsigned NOT NULL,
  `sendBy` int(11) NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `for` int(11) NOT NULL,
  `body` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `sendBy`, `subject`, `for`, `body`, `created_at`, `updated_at`) VALUES
(1, 0, 'test', 0, 'thskdks', '2015-08-18 11:53:00', '2015-08-18 11:53:00'),
(2, 0, 'test', 6, 'this is test', '2015-08-18 11:53:23', '2015-08-18 11:53:23'),
(0, 1, 'test2', 0, 'this is test2', '2015-08-19 17:26:44', '2015-08-19 17:26:44');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE IF NOT EXISTS `products` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `commision` float DEFAULT NULL,
  `margin` float DEFAULT NULL,
  `lot_size` float DEFAULT NULL,
  `holding_cost` float DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `created_at`, `updated_at`, `commision`, `margin`, `lot_size`, `holding_cost`) VALUES
(18, 'diamond', '2015-08-20 06:42:58', '2015-08-20 06:42:58', 1000, 2000, 10, 50),
(19, 'Gold', '2015-08-20 06:43:33', '2015-08-20 06:43:33', 1000, 2000, 10, 50),
(20, 'Silver', '2015-08-20 06:44:53', '2015-08-20 06:44:53', 1000, 2000, 10, 50);

-- --------------------------------------------------------

--
-- Table structure for table `stocks`
--

CREATE TABLE IF NOT EXISTS `stocks` (
`id` int(10) unsigned NOT NULL,
  `branchId` int(11) NOT NULL,
  `productTypeId` int(11) NOT NULL,
  `minQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `onlineQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `branchId`, `productTypeId`, `minQuantity`, `onlineQuantity`, `created_at`, `updated_at`) VALUES
(26, 50, 18, '1000', '5000', '2015-08-20 06:49:52', '2015-08-20 06:49:52');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `add_products`
--
ALTER TABLE `add_products`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `branches_name_unique` (`name`);

--
-- Indexes for table `client_stocks`
--
ALTER TABLE `client_stocks`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `logins`
--
ALTER TABLE `logins`
 ADD PRIMARY KEY (`id`), ADD KEY `logins_member_id_foreign` (`member_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `member_type`
--
ALTER TABLE `member_type`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `add_products`
--
ALTER TABLE `add_products`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=51;
--
-- AUTO_INCREMENT for table `client_stocks`
--
ALTER TABLE `client_stocks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=27;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
