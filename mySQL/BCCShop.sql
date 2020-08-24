-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 24, 2020 at 06:35 AM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `BCCShop`
--

-- --------------------------------------------------------

--
-- Table structure for table `userTABLE`
--

CREATE TABLE `userTABLE` (
  `id` int(11) NOT NULL,
  `ChooseType` text COLLATE utf8_unicode_ci NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `User` text COLLATE utf8_unicode_ci NOT NULL,
  `Password` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userTABLE`
--

INSERT INTO `userTABLE` (`id`, `ChooseType`, `Name`, `User`, `Password`) VALUES
(1, 'User', 'ณเดช คุ๊กกี้มั้ยจ๊ะ', 'user1', '1234'),
(2, 'User', 'TestName2', 'user2', '1234'),
(3, 'chooseType', 'name', 'user', 'password'),
(4, 'User', 'flutter1', 'f1', '1234'),
(5, 'Shop', 'flutter2', 'f2', '1234'),
(6, 'Shop', 'Test1234', 'user9', '12344'),
(7, 'Rider', 'Tu', 'User3', '1234');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `userTABLE`
--
ALTER TABLE `userTABLE`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `userTABLE`
--
ALTER TABLE `userTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
