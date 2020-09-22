-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 22, 2020 at 09:09 AM
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
-- Table structure for table `productTABLE`
--

CREATE TABLE `productTABLE` (
  `id` int(11) NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameProduct` text COLLATE utf8_unicode_ci NOT NULL,
  `PathImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Detail` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `productTABLE`
--

INSERT INTO `productTABLE` (`id`, `idShop`, `NameProduct`, `PathImage`, `Price`, `Detail`) VALUES
(3, '12', 'TV LED', '/BCCShop/Products/product112484.jpg', '10,000', 'TV Monitor LED 52\"'),
(4, '12', 'ttttt', '/BCCShop/Products/product89930.jpg', '3000', 'good'),
(5, '12', 'ffff', '/BCCShop/Products/product830375.jpg', '60', 'vvvv'),
(6, '14', 'TV SamSong 32\"', '/BCCShop/Products/product817313.jpg', '4000', 'Television screen FullHD'),
(7, '8', 'ไข่กะทะ', '/BCCShop/Products/product55680.jpg', '29', 'ไข่กะทะเจ้าเก่ามากๆๆๆ ไข่กะทะเจ้าเก่ามากๆๆๆ ไข่กะทะเจ้าเก่ามากๆๆๆ ไข่กะทะเจ้าเก่ามากๆๆๆ'),
(8, '8', 'การ์ตูนผีถลกหนังหัว', '/BCCShop/Products/product971765.jpg', '5', 'หนังสือการ์ตูนผีไทย 4สี'),
(9, '8', 'Salmon Sashimi', '/BCCShop/Products/product816671.jpg', '219', 'แซลมอลซาชิมิ ซอสโชยุ วาซาบี'),
(10, '8', 'สปาเกตตี้หอยลายพริกเผา', '/BCCShop/Products/product792798.jpg', '59', 'สปาเกตตี้เส้นแบนผัดกับน้ำพริกเผาสูตรพระเจ้าเหาที่8'),
(11, '8', 'ซี่โครงย่าง', '/BCCShop/Products/product172660.jpg', '115', 'ซี่โครงหมาย่าง จิ้มกับน้ำซอสจิ้มแจ่ว'),
(13, '8', 'สเต็กหมู', '/BCCShop/Products/product79944.jpg', '69', 'สเต็กหมูสันขวาน ราดซอสเกรวี่ กินแล้วขี้ไม่แตก'),
(14, '8', 'ตุ๊กแก', '/BCCShop/Products/product388696.jpg', '999', 'ตุ๊กตาแกจริง สีผิวสวยสดใส ในแววตาสีดั่งอัญมณี น้ำหนักสุทธิ 999 กรัม'),
(15, '12', 'ลอตตารี่ถูกแดก', '/BCCShop/Products/product463792.jpg', '1', 'ลอตตารี่เลข 999992 งวดที่1/09/2563 ไม่ถูกแต่เลขสวย'),
(16, '13', 'ไข่เค็ม', '/BCCShop/Products/product407078.jpg', '55', 'ไข่เค็มฝีมือลูกสาว'),
(17, '14', 'game', '/BCCShop/Products/product846152.jpg', '1500', 'เครื่องเกมส์และนาฬิกา'),
(18, '16', 'แผ่นมาริโอ้', '/BCCShop/Products/product65972.jpg', '1890', 'เกมมาริโอ้3D');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `productTABLE`
--
ALTER TABLE `productTABLE`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `productTABLE`
--
ALTER TABLE `productTABLE`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
