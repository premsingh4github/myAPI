-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 18, 2015 at 02:15 PM
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
  `amount` double(8,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `memberId`, `addedBy`, `type`, `amount`, `created_at`, `updated_at`) VALUES
(4, 2, 11, '1', 100000.00, '2015-08-08 05:11:09', '2015-08-08 05:11:09'),
(5, 1, 11, '0', 100.00, '2015-08-08 05:21:29', '2015-08-08 05:21:29'),
(6, 2, 11, '0', 1.00, '2015-08-08 05:24:16', '2015-08-08 05:24:16'),
(7, 10, 11, '1', 25000.00, '2015-08-11 11:48:15', '2015-08-11 11:48:15'),
(8, 1, 11, '1', 100.00, '2015-08-12 05:35:06', '2015-08-12 05:35:06'),
(9, 1, 11, '1', 100.00, '2015-08-12 05:44:38', '2015-08-12 05:44:38'),
(10, 1, 11, '1', 50.00, '2015-08-12 05:46:59', '2015-08-12 05:46:59'),
(11, 1, 11, '1', 100.00, '2015-08-12 05:50:56', '2015-08-12 05:50:56'),
(12, 1, 11, '0', 100.00, '2015-08-12 05:51:06', '2015-08-12 05:51:06'),
(14, 1, 11, '1', 999999.99, '2015-08-16 12:42:25', '2015-08-16 12:42:25');

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `add_products`
--

INSERT INTO `add_products` (`id`, `stockId`, `quantity`, `addedBy`, `created_at`, `updated_at`) VALUES
(5, 23, 1200.00, 1, '2015-08-12 11:22:32', '2015-08-12 11:22:32'),
(6, 24, 2200.00, 1, '2015-08-12 11:23:28', '2015-08-12 11:23:28'),
(14, 24, 200.00, 1, '2015-08-15 16:25:55', '2015-08-15 16:25:55'),
(15, 24, 200.00, 1, '2015-08-15 17:09:28', '2015-08-15 17:09:28');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE IF NOT EXISTS `branches` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(44, 'ktm', 'ktm', '2015-08-05 17:07:51', '0000-00-00 00:00:00'),
(45, 'prem', 'ktm', '2015-08-05 17:09:16', '0000-00-00 00:00:00'),
(46, 'ktm12', 'ktm', '2015-08-05 17:11:04', '0000-00-00 00:00:00'),
(47, 'laitpur', 'lalitpur', '2015-08-05 17:20:11', '0000-00-00 00:00:00');

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
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `client_stocks`
--

INSERT INTO `client_stocks` (`id`, `memberId`, `stockId`, `amount`, `status`, `created_at`, `updated_at`) VALUES
(3, 10, 23, 200, '1', '2015-08-12 09:48:09', '2015-08-15 15:11:50'),
(4, 10, 24, 150, '0', '2015-08-12 09:51:31', '2015-08-15 14:12:12'),
(5, 10, 23, 300, '1', '2015-08-16 12:38:32', '2015-08-16 12:40:35');

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
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`id`, `member_id`, `remember_token`, `status`, `login_from`, `created_at`, `updated_at`) VALUES
(68, 10, 'cQpAfvb1PtngDeE', '0', '::1', '2015-08-12 09:17:42', '2015-08-12 10:25:19'),
(69, 1, '6bdZJHhN6LvIbXE', '1', '::1', '2015-08-12 09:52:17', '2015-08-12 09:52:17'),
(70, 1, 'sFbQKqYgKqGyBh8', '1', '::1', '2015-08-12 10:25:26', '2015-08-12 10:25:26'),
(71, 1, 'Qy2xnbfhyBcyczH', '0', '::1', '2015-08-12 11:17:30', '2015-08-12 11:41:06'),
(72, 10, 'zlQCxdaDnXQFCLb', '0', '::1', '2015-08-12 11:41:15', '2015-08-12 11:41:35'),
(73, 1, 'GnVmC7ZgQt4JdoO', '0', '::1', '2015-08-12 11:41:41', '2015-08-12 11:54:01'),
(74, 10, 'qDZZAck7TNnPJyR', '0', '::1', '2015-08-12 11:54:08', '2015-08-12 11:55:41'),
(75, 1, 'r6ObIvFOgng43YO', '0', '::1', '2015-08-12 11:55:46', '2015-08-12 12:11:07'),
(76, 1, 'SPR9cjUYyOJo3Jg', '0', '::1', '2015-08-14 15:19:22', '2015-08-15 05:42:35'),
(77, 1, 'dzHurzzqmiJO4cp', '0', '::1', '2015-08-15 05:42:50', '2015-08-15 06:00:50'),
(78, 1, 'YwXvRKR1a3sMpIe', '1', '::1', '2015-08-15 06:01:20', '2015-08-15 06:01:20'),
(79, 10, 'VrD4xzWgx2ZSGHZ', '0', '::1', '2015-08-15 06:02:15', '2015-08-15 15:19:03'),
(80, 10, 'tr65sYp6kiIPEkg', '0', '::1', '2015-08-16 12:37:25', '2015-08-16 12:43:42'),
(81, 1, '8As5NvfJYpx0oc0', '0', '::1', '2015-08-16 12:39:10', '2015-08-16 12:41:22'),
(82, 11, 'OspUiTYjWzrd2zq', '0', '::1', '2015-08-16 12:41:47', '2015-08-16 12:51:46'),
(83, 1, '6wXQ512JpFDK9Fq', '1', '::1', '2015-08-16 12:43:50', '2015-08-16 12:43:50'),
(84, 10, 'Ixrefl7hBvIRnQu', '0', '::1', '2015-08-16 12:51:55', '2015-08-16 13:13:09'),
(85, 1, 'OfrbvDVUmlaATCS', '1', '::1', '2015-08-16 13:16:32', '2015-08-16 13:16:32'),
(86, 1, 'hxJu38YtFubA91b', '1', '::1', '2015-08-16 13:16:32', '2015-08-16 13:16:32'),
(87, 1, 'iLNrG12LMZmDWlK', '0', '::1', '2015-08-16 13:30:22', '2015-08-17 14:26:00'),
(88, 10, '4FwVYvO11WLoURr', '1', '::1', '2015-08-16 14:04:10', '2015-08-16 14:04:10'),
(89, 1, 'N87D0gJv8dYrm4n', '0', '::1', '2015-08-17 14:29:53', '2015-08-17 15:44:56'),
(90, 1, 'UvWo6ZzxBYoSAKX', '0', '::1', '2015-08-18 04:09:53', '2015-08-18 04:10:57'),
(91, 1, '85hXhKrW6mnrrjo', '0', '::1', '2015-08-18 04:11:36', '2015-08-18 05:08:14'),
(92, 1, 'DSvKELLAuFOEKU0', '1', '::1', '2015-08-18 05:15:57', '2015-08-18 05:15:57'),
(93, 10, 'PKXN1ZHcAgjHkTM', '0', '::1', '2015-08-18 06:25:40', '2015-08-18 09:44:36'),
(94, 82, 'TRYE3eAS42UfL08', '0', '::1', '2015-08-18 09:45:20', '2015-08-18 09:45:28'),
(95, 10, 'mw2nXWn6SpL4X2P', '0', '::1', '2015-08-18 10:55:22', '2015-08-18 11:07:17'),
(96, 10, 'TT4VU0mx6rNfTBj', '1', '::1', '2015-08-18 12:12:02', '2015-08-18 12:12:02');

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
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `notices`
--

INSERT INTO `notices` (`id`, `sendBy`, `subject`, `for`, `body`, `created_at`, `updated_at`) VALUES
(1, 0, 'test', 0, 'thskdks', '2015-08-18 11:53:00', '2015-08-18 11:53:00'),
(2, 0, 'test', 6, 'this is test', '2015-08-18 11:53:23', '2015-08-18 11:53:23');

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
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'diamond', '2015-08-06 04:45:44', '2015-08-06 04:45:44'),
(3, 'Gold', '2015-08-06 04:46:31', '2015-08-06 04:46:31'),
(5, 'silver', '2015-08-06 04:50:45', '2015-08-06 04:50:45');

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
  `deliveryCharge` double(8,2) NOT NULL,
  `lot` varchar(55) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `branchId`, `productTypeId`, `minQuantity`, `onlineQuantity`, `deliveryCharge`, `lot`, `created_at`, `updated_at`) VALUES
(23, 44, 2, '200', '400', 500.00, '2', '2015-08-12 11:22:32', '2015-08-12 11:22:32'),
(24, 46, 3, '100', '2400', 500.00, '2', '2015-08-12 11:23:28', '2015-08-15 17:09:28');

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
-- Indexes for table `notices`
--
ALTER TABLE `notices`
 ADD PRIMARY KEY (`id`), ADD FULLTEXT KEY `body` (`body`), ADD FULLTEXT KEY `body_2` (`body`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
 ADD KEY `password_resets_email_index` (`email`), ADD KEY `password_resets_token_index` (`token`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `product_name_unique` (`name`);

--
-- Indexes for table `stocks`
--
ALTER TABLE `stocks`
 ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=15;
--
-- AUTO_INCREMENT for table `add_products`
--
ALTER TABLE `add_products`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=48;
--
-- AUTO_INCREMENT for table `client_stocks`
--
ALTER TABLE `client_stocks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=97;
--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT for table `member_type`
--
ALTER TABLE `member_type`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `logins`
--
ALTER TABLE `logins`
ADD CONSTRAINT `logins_member_id_foreign` FOREIGN KEY (`member_id`) REFERENCES `members` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
