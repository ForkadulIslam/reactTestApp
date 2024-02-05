-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 05, 2024 at 04:59 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `react_app_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `sectors`
--

CREATE TABLE `sectors` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sectors`
--

INSERT INTO `sectors` (`id`, `title`) VALUES
(1, 'Manufacturing'),
(2, 'Construction materials'),
(3, 'Electronics and Optics'),
(4, 'Bakery confectionery products'),
(5, 'Food and Beverage'),
(6, 'Fish & fish products'),
(7, 'Meat & meat products'),
(8, 'Milk & dairy products'),
(9, 'Other'),
(10, 'Sweets & snack food'),
(11, 'Furniture'),
(12, 'Bathroom/sauna'),
(13, 'Bedroom'),
(14, 'Children’s room'),
(15, 'Kitchen'),
(16, 'Living room'),
(17, 'Office'),
(18, 'Other (Furniture)'),
(19, 'Outdoor'),
(20, 'Project furniture'),
(21, 'Machinery'),
(22, 'Machinery components'),
(23, 'Machinery equipment/tools'),
(24, 'Manufacture of machinery'),
(25, 'Maritime'),
(26, 'Aluminium and steel workboats'),
(27, 'Boat/Yacht building'),
(28, 'Ship repair and conversion'),
(29, 'Metal structures'),
(30, 'Other'),
(31, 'Repair and maintenance service'),
(32, 'Metalworking'),
(33, 'Construction of metal structures'),
(34, 'Houses and buildings'),
(35, 'Metal products'),
(36, 'Metal works'),
(37, 'CNC-machining'),
(38, 'Forgings, Fasteners'),
(39, 'Gas, Plasma, Laser cutting'),
(40, 'MIG, TIG, Aluminum welding'),
(41, 'Plastic and Rubber'),
(42, 'Packaging'),
(43, 'Plastic goods'),
(44, 'Plastic processing technology'),
(45, 'Blowing'),
(46, 'Moulding'),
(47, 'Plastics welding and processing'),
(48, 'Plastic profiles'),
(49, 'Advertising'),
(50, 'Book/Periodicals printing'),
(51, 'Labelling and packaging printing'),
(52, 'Textile and Clothing'),
(53, 'Clothing'),
(54, 'Textile'),
(55, 'Wood'),
(56, 'Other (Wood)'),
(57, 'Wooden building materials'),
(58, 'Wooden houses'),
(59, 'Other'),
(60, 'Creative industries'),
(61, 'Energy technology'),
(62, 'Environment'),
(63, 'Service'),
(64, 'Business services'),
(65, 'Engineering'),
(66, 'Information Technology and Telecommunications'),
(67, 'Data processing, Web portals, E-marketing'),
(68, 'Programming, Consultancy'),
(69, 'Software, Hardware'),
(70, 'Telecommunications'),
(71, 'Tourism'),
(72, 'Translation services'),
(73, 'Transport and Logistics'),
(74, 'Air'),
(75, 'Rail'),
(76, 'Road'),
(77, 'Water');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sector_id` int(11) NOT NULL,
  `agree_to_terms` tinyint(1) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `sectors`
--
ALTER TABLE `sectors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `sectors`
--
ALTER TABLE `sectors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
