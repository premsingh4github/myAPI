-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2015 at 02:15 PM
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
-- Table structure for table `branches`
--

CREATE TABLE IF NOT EXISTS `branches` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `location`, `created_at`, `updated_at`) VALUES
(32, 'ktm', 'ktm', '2015-08-05 08:38:33', '0000-00-00 00:00:00'),
(33, 'jnk', 'janakpur', '2015-08-05 08:45:55', '0000-00-00 00:00:00'),
(34, 'kritipur', 'kritipur', '2015-08-05 08:59:37', '0000-00-00 00:00:00'),
(35, 'test', 'ktm', '2015-08-05 10:12:48', '0000-00-00 00:00:00'),
(36, 'test2', 'ktm10', '2015-08-05 10:40:23', '0000-00-00 00:00:00'),
(37, 'sulav', 'fjdkfd', '2015-08-05 10:42:31', '0000-00-00 00:00:00');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `logins`
--

INSERT INTO `logins` (`id`, `member_id`, `remember_token`, `status`, `login_from`, `created_at`, `updated_at`) VALUES
(1, 1, 'WjdM81LF7Vd9ZgV', '1', '::1', '2015-08-04 23:42:47', '2015-08-04 23:42:47'),
(2, 1, 'fxzXKk3pyMozhGg', '1', '::1', '2015-08-04 23:52:29', '2015-08-04 23:52:29'),
(3, 1, 'yYOJjhuHEnSwRtR', '1', '127.0.0.1', '2015-08-05 00:12:15', '2015-08-05 00:12:15'),
(4, 1, 'YG5q8MBgVv8RXga', '1', '127.0.0.1', '2015-08-05 00:12:49', '2015-08-05 00:12:49'),
(5, 1, 'oYYw98JdYWwYEBf', '1', '::1', '2015-08-05 04:25:58', '2015-08-05 04:25:58'),
(6, 1, 'Ku8ZWkONUHozfoX', '1', '::1', '2015-08-05 04:27:33', '2015-08-05 04:27:33');

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
  `mtype` enum('0','1','2') COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`id`, `fname`, `mname`, `lname`, `address`, `identity`, `nationality`, `dob`, `ban`, `email`, `cNumber`, `mNumber`, `username`, `password`, `status`, `mtype`, `created_at`, `updated_at`) VALUES
(1, 'prem', 'kumar', 'singh', 'ktm', '1235', 'nepales', '', '', '', '', '', 'admin', '$2y$10$LpA28z1z2ti3d2bMyUB5zuvWKcFPwon1cW2TS/gyA/iP0ntAct.0q', '1', '0', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

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
('2015_08_05_095927_create_stock_table', 2);

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
-- Table structure for table `stocks`
--

CREATE TABLE IF NOT EXISTS `stocks` (
`id` int(10) unsigned NOT NULL,
  `branchId` int(11) NOT NULL,
  `productTypeId` int(11) NOT NULL,
  `minQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `onlineQuantity` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deliveryCharge` double(8,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `stocks`
--

INSERT INTO `stocks` (`id`, `branchId`, `productTypeId`, `minQuantity`, `onlineQuantity`, `deliveryCharge`, `created_at`, `updated_at`) VALUES
(6, 32, 1, '100', '200', 300.00, '2015-08-05 05:58:31', '2015-08-05 05:58:31'),
(7, 33, 2, '500', '500', 500.00, '2015-08-05 06:08:38', '2015-08-05 06:08:38'),
(8, 37, 3, '234', '123', 123.00, '2015-08-05 06:09:38', '2015-08-05 06:09:38'),
(9, 35, 2, '123', '111', 111.00, '2015-08-05 06:10:11', '2015-08-05 06:10:11');

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
-- Indexes for table `branches`
--
ALTER TABLE `branches`
 ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `branches_name_unique` (`name`);

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
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
 ADD KEY `password_resets_email_index` (`email`), ADD KEY `password_resets_token_index` (`token`);

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
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=38;
--
-- AUTO_INCREMENT for table `logins`
--
ALTER TABLE `logins`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `stocks`
--
ALTER TABLE `stocks`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
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
