-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 22, 2020 at 09:10 AM
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
  `Password` text COLLATE utf8_unicode_ci NOT NULL,
  `NameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `Address` text COLLATE utf8_unicode_ci NOT NULL,
  `Phone` text COLLATE utf8_unicode_ci NOT NULL,
  `URLImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Lat` text COLLATE utf8_unicode_ci NOT NULL,
  `Lng` text COLLATE utf8_unicode_ci NOT NULL,
  `Token` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `userTABLE`
--

INSERT INTO `userTABLE` (`id`, `ChooseType`, `Name`, `User`, `Password`, `NameShop`, `Address`, `Phone`, `URLImage`, `Lat`, `Lng`, `Token`) VALUES
(1, 'User', 'ณเดช คุ๊กกี้มั้ยจ๊ะ', 'user1', '1234', '', '', '', '', '', '', ''),
(7, 'Rider', 'FoodEPA', 'User3', '1234', '', '', '', '', '', '', ''),
(8, 'Shop', 'AppleShop', 'appleshop', '1234', 'Apple Store ICONSIAM', 'River front', '02-111-1111', '/BCCShop/Shop/editShop795.jpg', '13.673455', '100.606933', ''),
(10, 'User', 'NADOL', 'NADOL', '1234', '', '', '', '', '', '', ''),
(11, 'Shop', 'NADOLSHOP', 'NADOLSHOP', '1234', 'Nadol Shop', 'Chonburi', '1234', '/BCCShop/Shop/shop357108.jpg', '13.552964', '100.997494', ''),
(12, 'Shop', 'Dev', 'Dev01', '1234', 'ทุ่งนาการไฟฟ้า', 'สายไฟฟ้าบางกอกเคเบิล จ.ฉะเชิงเทรา', '1222', '/BCCShop/Shop/editShop66675.jpg', '13.604333', '101.021101', ''),
(13, 'Shop', 'Dev02', 'Dev02', '1234', 'มาดูเอง', '111', '111', '/BCCShop/Shop/shop899205.jpg', '13.578382375095575', '101.00159714724177', ''),
(14, 'Shop', 'Dev03', 'Dev03', '1234', 'ไม่ต้องมาซื้อร้านกู', '111', '111', '/BCCShop/Shop/shop984683.jpg', '13.513499', '100.988095', ''),
(15, 'Shop', 'คนไทยรึเปล่า', 'Dev4', '1234', '', '', '', '', '', '', ''),
(16, 'Shop', 'คนไทยรึเปล่า', 'Dev4', '1234', 'Gameboy', '111', '4444', '/BCCShop/Shop/shop512247.jpg', '13.540347', '100.989026', '');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
