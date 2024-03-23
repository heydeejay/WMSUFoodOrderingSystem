-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 10, 2024 at 07:18 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wmsu_oc_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `food_id` int(11) DEFAULT NULL,
  `food_name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `store` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `complete__delivery`
--

CREATE TABLE `complete__delivery` (
  `id` int(11) NOT NULL,
  `track_no` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `food_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `food_name` varchar(255) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `mop` varchar(255) NOT NULL,
  `payment` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `response` varchar(255) NOT NULL,
  `food_ready` varchar(255) NOT NULL,
  `payment_stat` varchar(255) NOT NULL,
  `complete` int(11) DEFAULT NULL,
  `errand_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `complete__delivery`
--

INSERT INTO `complete__delivery` (`id`, `track_no`, `customer_id`, `food_id`, `vendor_id`, `food_name`, `vendor`, `quantity`, `price`, `total`, `mop`, `payment`, `location`, `response`, `food_ready`, `payment_stat`, `complete`, `errand_id`, `date_created`) VALUES
(10, 90528566, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-09 01:05:22'),
(11, 90528566, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-08 01:05:22'),
(12, 90528566, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(13, 90528566, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(14, 90528566, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(15, 90528566, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(16, 90528566, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(17, 90528566, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(18, 90528566, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(19, 90528566, 23, 18, 22, 'Halo halo', 'S.A.R.I', 1, 35, 35, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(20, 90528566, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(21, 90528566, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(22, 90528566, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(23, 90528566, 23, 18, 22, 'Halo halo', 'S.A.R.I', 1, 35, 35, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(24, 90528566, 23, 17, 22, 'Coke', 'S.A.R.I', 2, 20, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:22'),
(25, 26223573, 17, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:05:38'),
(26, 0, 0, 0, 0, 'No Record', 'No Record', 0, 0, 0, 'No Record', 'No Record', 'No Record', 'No Record', 'No Record', 'No Record', 0, 0, '2023-12-10 01:11:20'),
(27, 59330725, 18, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:16:56'),
(28, 41834397, 24, 11, 19, 'Fried rice', 'Campus B', 1, 20, 20, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:16:58'),
(29, 41834397, 18, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:17:33'),
(30, 61162101, 23, 17, 22, 'Coke', 'S.A.R.I', 10, 20, 200, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:19:19'),
(31, 93709199, 25, 14, 19, 'Coke', 'Campus B', 1, 30, 30, 'cash', 'yes', 'C', '', 'yes', 'yes', 0, 20, '2023-12-10 01:26:29'),
(32, 61162101, 21, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:27:43'),
(33, 82917310, 21, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:28:16'),
(34, 88148585, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:28:45'),
(35, 86332767, 23, 18, 22, 'Halo halo', 'S.A.R.I', 20, 35, 700, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:31:50'),
(36, 46237599, 25, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'cash', 'yes', 'V', '', 'yes', 'yes', 0, 20, '2023-12-10 01:32:58'),
(37, 50631289, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'gcash', 'yes', 'css', '', 'yes', 'yes', 0, 20, '2023-12-10 01:34:00'),
(38, 91513039, 23, 24, 22, 'Coke', 'S.A.R.I', 30, 55, 1650, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:35:10'),
(39, 32271241, 23, 13, 22, 'Sinigang', 'S.A.R.I', 2, 50, 100, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:38:49'),
(40, 76168113, 25, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:39:15'),
(41, 76168113, 25, 20, 19, 'Beef Steak', 'Campus B', 1, 55, 55, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:40:01'),
(42, 46568230, 25, 11, 19, 'Fried rice', 'Campus B', 1, 20, 20, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:48:05'),
(43, 46568230, 25, 11, 19, 'Fried rice', 'Campus B', 1, 20, 20, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:48:05'),
(44, 46568230, 25, 12, 19, 'Fried chicken', 'Campus B', 1, 45, 45, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:48:05'),
(45, 36782975, 23, 24, 22, 'Coke', 'S.A.R.I', 1, 55, 55, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:49:36'),
(46, 39967274, 26, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:51:30'),
(47, 86103188, 18, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 01:58:58'),
(48, 34899666, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:17:44'),
(49, 23783777, 17, 20, 19, 'Beef Steak', 'Campus B', 1, 55, 55, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:22:32'),
(50, 49992457, 18, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:22:56'),
(51, 49992457, 18, 19, 22, 'Lechon', 'S.A.R.I', 3, 55, 165, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:23:14'),
(52, 77924290, 25, 14, 19, 'Coke', 'Campus B', 1, 30, 30, 'cash', 'yes', 'c', '', 'yes', 'yes', 0, 20, '2023-12-10 14:24:24'),
(53, 21230189, 21, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'coe', '', 'yes', 'yes', 0, 20, '2023-12-10 14:24:33'),
(54, 21230189, 21, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'coe', '', 'yes', 'yes', 0, 20, '2023-12-10 14:24:33'),
(55, 21230189, 21, 24, 22, 'Coke', 'S.A.R.I', 1, 55, 55, 'cash', 'yes', 'coe', '', 'yes', 'yes', 0, 20, '2023-12-10 14:24:33'),
(56, 77924290, 25, 18, 22, 'Halo halo', 'S.A.R.I', 1, 35, 35, 'cash', 'yes', 'c', '', 'yes', 'yes', 0, 20, '2023-12-10 14:24:34'),
(57, 72122140, 23, 22, 22, 'Taho', 'S.A.R.I', 2, 15, 30, 'cash', 'yes', 'CCS bldg', '', 'yes', 'yes', 0, 20, '2023-12-10 14:25:22'),
(58, 58019896, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:59:18'),
(59, 74879222, 23, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 14:59:37'),
(60, 50423779, 23, 10, 19, 'Rice', 'Campus B', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:08:32'),
(61, 12170224, 23, 13, 22, 'Sinigang', 'S.A.R.I', 2, 50, 100, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:10:12'),
(62, 68081431, 23, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:18:41'),
(63, 68081431, 23, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:18:41'),
(64, 68081431, 23, 24, 22, 'Coke', 'S.A.R.I', 1, 55, 55, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:18:41'),
(65, 57881231, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:18:57'),
(66, 14198670, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:29:11'),
(67, 63427094, 23, 13, 22, 'Sinigang', 'S.A.R.I', 2, 50, 100, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:30:52'),
(68, 52119656, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:35:46'),
(69, 27141541, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'gcash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:36:06'),
(70, 94826866, 23, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:40:54'),
(71, 58270872, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:44:25'),
(72, 90411697, 23, 22, 22, 'Taho', 'S.A.R.I', 1, 15, 15, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:49:38'),
(73, 21248184, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:53:27'),
(74, 81663256, 23, 24, 22, 'Coke', 'S.A.R.I', 1, 55, 55, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:53:41'),
(75, 77640926, 23, 13, 22, 'Sinigang', 'S.A.R.I', 1, 50, 50, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 15:54:29'),
(76, 97562186, 23, 24, 22, 'Coke', 'S.A.R.I', 15, 55, 825, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 16:02:26'),
(77, 48266377, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 16:02:41'),
(78, 50181872, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 16:05:01'),
(79, 33262936, 23, 15, 22, 'Adobo', 'S.A.R.I', 1, 40, 40, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 16:06:37'),
(80, 56345358, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 17:56:17'),
(81, 64224025, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 18:03:31'),
(82, 26376614, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 18:22:44'),
(83, 12892986, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 18:29:37'),
(84, 89597448, 24, 11, 19, 'Fried rice', 'Campus B', 1, 20, 20, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 18:31:24'),
(85, 16195945, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 20:44:03'),
(86, 70457491, 24, 23, 19, 'Student meal (fried rice+veggie+chicken)', 'Campus B', 1, 70, 70, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 20:48:11'),
(87, 84975225, 24, 14, 19, 'Coke', 'Campus B', 1, 30, 30, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 20:52:34'),
(88, 82908545, 24, 16, 19, 'wilkins', 'Campus B', 1, 20, 20, 'cash', 'yes', 'pickup', '', 'yes', 'yes', 0, 0, '2023-12-10 20:58:31');

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `id` int(11) NOT NULL,
  `track_no` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `food_id` int(11) DEFAULT NULL,
  `food_name` varchar(255) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `response` varchar(255) NOT NULL,
  `mop` varchar(255) NOT NULL,
  `food_ready` varchar(255) NOT NULL,
  `payment` varchar(255) NOT NULL,
  `complete` int(11) DEFAULT NULL,
  `errand_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`id`, `track_no`, `customer_id`, `vendor_id`, `food_id`, `food_name`, `vendor`, `quantity`, `price`, `total`, `location`, `response`, `mop`, `food_ready`, `payment`, `complete`, `errand_id`, `date_created`) VALUES
(70, 61960510, 23, NULL, 18, 'Halo halo', 'S.A.R.I', 2, 35, 70, 'pickup', 'Pending', 'pickup', 'no', 'no', 0, 0, '2023-12-10 16:06:48');

-- --------------------------------------------------------

--
-- Table structure for table `errand_sales`
--

CREATE TABLE `errand_sales` (
  `id` int(11) NOT NULL,
  `track_no` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `mop` varchar(255) NOT NULL,
  `payment` varchar(255) NOT NULL,
  `errand` varchar(255) NOT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `errand_sales`
--

INSERT INTO `errand_sales` (`id`, `track_no`, `total`, `mop`, `payment`, `errand`, `date_created`) VALUES
(25, 93709199, 15, 'cash', 'yes', '20', '2023-12-10 01:26:29'),
(26, 46237599, 15, 'cash', 'yes', '20', '2023-12-10 01:32:58'),
(27, 50631289, 15, 'gcash', 'yes', '20', '2023-12-10 01:34:00'),
(28, 77924290, 18, 'cash', 'yes', '20', '2023-12-10 14:24:24'),
(29, 21230189, 15, 'cash', 'yes', '20', '2023-12-10 14:24:33'),
(30, 77924290, 18, 'cash', 'yes', '20', '2023-12-10 14:24:34'),
(31, 72122140, 15, 'cash', 'yes', '20', '2023-12-10 14:25:22');

-- --------------------------------------------------------

--
-- Table structure for table `fee`
--

CREATE TABLE `fee` (
  `id` int(11) NOT NULL,
  `fees` int(11) DEFAULT NULL,
  `additional` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fee`
--

INSERT INTO `fee` (`id`, `fees`, `additional`, `date_created`) VALUES
(1, 15, 3, '2023-12-08 15:51:59');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id` int(11) NOT NULL,
  `food_name` varchar(255) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `status` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `sold` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `food_name`, `price`, `status`, `category`, `image_url`, `vendor_id`, `sold`, `date_created`) VALUES
(10, 'Rice', 15, 'Available', 'Solo Meal', '/usercont/utC4DZKoE9kNHtDKu7L3Y6ZJntnqCZ4v.jpg', 19, 7, '2023-12-10 00:57:13'),
(11, 'Fried rice', 20, 'Available', 'Solo Meal', '/usercont/OrVEI7wBROiSa5JpYzF4IrP0VFAkhMxs.jpg', 19, 3, '2023-12-10 00:57:36'),
(12, 'Fried chicken', 45, 'Available', 'Solo Meal', '/usercont/hGNfnGqRYNpn3ShWYfbNi8HKbM3ejjgV.jpg', 19, 1, '2023-12-10 00:57:56'),
(13, 'Sinigang', 50, 'Available', 'Solo Meal', '/usercont/xv97Pudm9vOCPBu301KPfWKH5BtUBhtw.jpg', 22, 17, '2023-12-10 00:57:59'),
(14, 'Coke', 30, 'Available', 'Drinks', '/usercont/Nu1sSFyMeualYFBr5fK2C21xURNkmZcy.jpg', 19, 3, '2023-12-10 00:58:11'),
(15, 'Adobo', 40, 'Available', 'Solo Meal', '/usercont/Qodch1qunMEdLxqt3fh8YmonJfRjSFGe.jpg', 22, 5, '2023-12-10 00:58:13'),
(16, 'wilkins', 20, 'Available', 'Drinks', '/usercont/NeK512J36mEuDASYYxbcjeYAm9QIa7xn.jpg', 19, 1, '2023-12-10 00:58:26'),
(18, 'Halo halo', 35, 'Available', 'Desserts', '/usercont/BBwGbLVLaM23d9PI2K5Iem7x8WmjOfZN.jpg', 22, 3, '2023-12-10 00:58:57'),
(19, 'Lechon', 55, 'Available', 'Solo Meal', '/usercont/PPaxObJhM8PADlkl8YtH0y71Wcv6Tv0w.jpg', 22, 1, '2023-12-10 00:59:12'),
(20, 'Beef Steak', 55, 'Available', 'Solo Meal', '/usercont/9wsCkZgwH4JijzCKNMte1FC5IoGnaKyD.jpg', 19, 2, '2023-12-10 00:59:19'),
(21, 'Kare kare', 55, 'Available', 'Solo Meal', '/usercont/08qew8ughUbRoJRYUjdL7s31h0Q35zne.jpg', 22, 0, '2023-12-10 00:59:28'),
(22, 'Taho', 15, 'Available', 'Desserts', '/usercont/SSRR0Wv9rR9BlXoTgfInGRqBAaBWWeS2.jpg', 22, 6, '2023-12-10 00:59:59'),
(23, 'Student meal (fried rice+veggie+chicken)', 70, 'Available', 'Combo Meal', '/usercont/Xe9YTDrBxBiuJIzVKrkG5HYCIXphnfOr.jpg', 19, 8, '2023-12-10 01:00:22'),
(24, 'Coke', 55, 'Available', 'Drinks', '/usercont/T98mIlcRvVdQzU5jCXLiUR8EbXBdoV1w.jpg', 22, 6, '2023-12-10 01:33:36');

-- --------------------------------------------------------

--
-- Table structure for table `remittance`
--

CREATE TABLE `remittance` (
  `id` int(11) NOT NULL,
  `track_no` int(11) DEFAULT NULL,
  `vendor_name` varchar(255) NOT NULL,
  `total` int(11) DEFAULT NULL,
  `mop` varchar(255) NOT NULL,
  `payment` varchar(255) NOT NULL,
  `refereance` int(11) DEFAULT NULL,
  `errand` varchar(255) NOT NULL,
  `df` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `role` varchar(255) NOT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `role`, `date_created`) VALUES
(1, 'customer', '2023-11-29 01:49:12'),
(2, 'admin', '2023-11-29 01:49:12'),
(3, 'vendor', '2023-11-29 01:50:37'),
(4, 'errand', '2023-11-29 01:50:37'),
(5, 'staff', '2023-11-30 23:36:56');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `sex` varchar(255) NOT NULL,
  `contact` varchar(255) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `user_type` int(11) DEFAULT NULL,
  `role` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `code` int(11) DEFAULT NULL,
  `verify` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `first_name`, `middle_name`, `last_name`, `sex`, `contact`, `email`, `password`, `user_type`, `role`, `image_url`, `code`, `verify`, `date_created`) VALUES
(1, 'admin', 'admin', 'admin', 'admin', '123456789', 'admin@wmsu.edu.ph', 'sha256$OnPYmkg1So8hMpOj$e081fdad41e370990af5ec3f16c9f178a098b9b7a3087ea9e7e07768c0a91d81', 2, 'admin', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-11-29 01:53:40'),
(2, 'customer1', 'customer1', 'customer1', 'customer1', '12345678', 'customer1@wmsu.edu.ph', 'sha256$m6qhIxgeKgUOiBb6$fb8284ef3be48dedd5ac7afefa2f55376246de1e66d25271cbcbeda5d2c2dcd5', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-11-29 01:58:01'),
(10, 'No Record', 'No Record', 'No Record', 'No Record', 'No Record', 'No Record', 'No Record', 5, 'No Record', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-11-30 23:37:20'),
(13, 'customer2', 'customer2', 'customer2', 'customer2', '123456789', 'customer2@wmsu.edu.ph', 'sha256$cSnLqzEFvZkf41R7$f81c5c992b569c5fb6c6eb8f1672a56766d9b74ac479278954e0618c712c736f', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-07 00:23:35'),
(14, 'Vendor1', 'Vendor1', 'Vendor1', 'Vendor1', '123456789', 'Vendor1@gmail.com', 'pbkdf2:sha256:260000$u6TFyw9FGLJc3Qhc$69d9af3179d09b12186f563aad88a340ef87f47f1335d6b4d0bf63aa77eb79ee', 3, 'vendor', '/usercont/s2p8Xtvmlbnt9qH8MtsJi8AxgchSsCBl.jpg', 0, 0, '2023-12-08 14:35:10'),
(15, 'Vendor2', 'Vendor2', 'Vendor2', 'Vendor2', '12345678', 'Vendor2@gmail.com', 'sha256$FnRy9SAMKfcDHx82$4fb89b0d35ffe29e86742ce189cc657df584576a2ab651c13b3c85cfb48dbbac', 3, 'vendor', '/usercont/OZXEmivZLkjXKfQTIyEsec5cMgYTbQAO.jpg', 0, 0, '2023-12-08 16:01:25'),
(17, 'Maria', '', 'Estrada', 'Estrada', '09064580269', 'maria@wmsu.edu.ph', 'sha256$YvjRFCS319PgB9EC$bcf2e71f2c67ca07423368a9316c850a78c6858f405983c05b18139deff7f808', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 00:52:13'),
(18, 'Jessa', '', 'Francisco', 'Francisco', '09123456789', 'jessa@wmsu.edu.ph', 'sha256$qZXWQ1awLATKs6gS$7b8116ef2d8713b8a19ffd77f0ba7a06ddddb9294b37f744c4560cf55c265432', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 00:53:49'),
(19, 'campb', 'campb', 'campb', 'campb', '09876543212', 'campb@gmail.com', 'sha256$EcC5WpqdlrdpqgCG$d1cd18d3139fdc0174651cba897dbdb477cc174026a9c43949df80c6a7f2366e', 3, 'vendor', '/usercont/qEXbMclp8sdWSioRkDNcoo6iBzqCjWAu.png', 0, 0, '2023-12-10 00:55:29'),
(20, 'errand1', 'errand1', 'errand1', 'errand1', '0987654323', 'errand1@gmail.com', 'sha256$AnHPSVAqp0v6Ck2e$745c7a941df4ff192b89fa4ac165deb44b5a9a26cdc8ab0b6452b5ee00e08757', 4, 'errand', '/usercont/x1M4hTGZvO7DkSbLvzJrcWzeGM31t3qP.jpg', 0, 0, '2023-12-10 00:56:15'),
(21, 'Rica', '', 'Mayormita', 'Mayormita', '09111111111', 'rica@wmsu.edu.ph', 'sha256$EolJwWfHdCNByIEm$12411ae761cda8bf4bba4359bd08b5283548c35509f6581d440fa3c1b232126d', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 00:56:50'),
(22, 'sa', '', 'ri', 'ri', '095345623312', 'sari@gmail.com', 'sha256$ojN5dI6AqB5JrpU0$d71f893bc5bf3369f0741e2ef17bd8fb22174eb69cdf682980706db646816d78', 3, 'vendor', '/usercont/WX4euVfxs6UQn36IOcs7YyqfjC1TFrxE.png', 0, 0, '2023-12-10 00:56:52'),
(23, 'Arnel', 'L', 'Maala', 'Maala', '09212191232', 'ar@ils.edu.ph', 'pbkdf2:sha256:260000$A1iaF8LrxzZcho78$69d0b63979b0be9dd12b6c56e2a2836079351751228cd924c21f8302cb359b3b', 1, 'customer', '/usercont/QY7xuSwQFxB9sOsFy7pUa5uVczQu5xm5.jpg', 0, 0, '2023-12-10 01:01:53'),
(24, 'Dee', 'Lee', 'Gonzales', 'Gonzales', '09876543216', 'dee@wmsu.edu.ph', 'sha256$gKeOxioyBcg4bkHY$b380cdbd4ae321f86714745655c1330d54038e9587bf0b6b332eab5ad4cd4b9b', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 01:02:04'),
(25, 'Bam', '', 'Apostol', 'Apostol', '09064580269', 'bam@wmsu.edu.ph', 'sha256$P6s1mNtiJTnDHDe5$24fe095b6a2fafec55c30508c4911ebd060c6784b1b5ef88c92383dd90a506d0', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 01:22:00'),
(26, 'Student1', 'Student1', 'Student1', 'Student1', '123456789', 'Student1@wmsu.edu.ph', 'sha256$1FbVZeHaE8zHmzw0$b48d283187144e32827e8ed38b799bd4582251786133b6b43ec3e59c5b6660f6', 1, 'customer', 'https://i.ibb.co/T4D0vD7/334445509-1139125010112015-3116619608976503677-n.png', 0, 0, '2023-12-10 01:48:46'),
(27, 'Tin', '', 'Dahan', 'Dahan', '09343533535', 'td@gmail.com', 'sha256$DjdIFUAF42YMDe72$52b8dc4ac24659bafa367b7e08126fcf41a875f941c458034e686b4fa2d7a1dd', 3, 'vendor', 'usercont\\uJxXn22Oy5tzs5yvI4dR9k2UXXyneknl.png', 0, 0, '2023-12-10 14:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `store_name` varchar(255) NOT NULL,
  `gcash_no` int(11) DEFAULT NULL,
  `gcash_name` varchar(255) NOT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`id`, `user_id`, `store_name`, `gcash_no`, `gcash_name`, `date_created`) VALUES
(6, 19, 'Campus B', 2147483647, 'campb', '2023-12-10 00:55:29'),
(7, 22, 'S.A.R.I', 2147483647, 'S.A.R.I', '2023-12-10 00:56:52'),
(8, 27, 'Tindahan', 2147483647, 'Tindahan', '2023-12-10 14:43:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `complete__delivery`
--
ALTER TABLE `complete__delivery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `errand_sales`
--
ALTER TABLE `errand_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `fee`
--
ALTER TABLE `fee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `remittance`
--
ALTER TABLE `remittance`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_type` (`user_type`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `complete__delivery`
--
ALTER TABLE `complete__delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `errand_sales`
--
ALTER TABLE `errand_sales`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `fee`
--
ALTER TABLE `fee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `remittance`
--
ALTER TABLE `remittance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `vendor`
--
ALTER TABLE `vendor`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`user_type`) REFERENCES `role` (`id`);

--
-- Constraints for table `vendor`
--
ALTER TABLE `vendor`
  ADD CONSTRAINT `vendor_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
