-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 14, 2025 at 06:08 PM
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
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `entities`
--

CREATE TABLE `entities` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `strasse` varchar(255) DEFAULT NULL,
  `HallenTyp` int(11) DEFAULT NULL,
  `Spielfeldgroesse` int(11) DEFAULT NULL,
  `strasse_nr` int(11) DEFAULT NULL,
  `plz` int(11) DEFAULT NULL,
  `ort` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entities`
--

INSERT INTO `entities` (`id`, `name`, `image_url`, `strasse`, `HallenTyp`, `Spielfeldgroesse`, `strasse_nr`, `plz`, `ort`) VALUES
(1, 'Hallenbad', 'http://localhost:8080/img/Hallenbad.jpg', 'Grossenbacher-Tor', 1, NULL, NULL, 36088, 'Huenfeld'),
(2, 'Rhoenkampfbahn', 'http://localhost:8080/img/Rhoenkampfbahn.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(3, 'lauftreff', 'http://localhost:8080/img/lauftreff.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(4, 'bundespolizei', 'http://localhost:8080/img/bundespolizei.png', 'Molzebacherstrasse', 1, 1050, 35, 36088, 'Huenfeld'),
(5, 'JAF-Schule', 'http://localhost:8080/img/JAF-Schule.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(6, 'Kreissporthalle-1', 'http://localhost:8080/img/Kreissporthalle-1.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(7, 'Kreissporthalle-3', 'http://localhost:8080/img/Kreissporthalle-3.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(8, 'Kreissporthalle-4', 'http://localhost:8080/img/Kreissporthalle-4.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(9, 'PGS-Schule', 'http://localhost:8080/img/PGS-Schule.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld');

-- --------------------------------------------------------

--
-- Table structure for table `mieter`
--

CREATE TABLE `mieter` (
  `ID` bigint(20) NOT NULL,
  `Name` varchar(100) DEFAULT NULL,
  `Nachname` varchar(100) DEFAULT NULL,
  `Telefonnummer` varchar(20) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mieter`
--

INSERT INTO `mieter` (`ID`, `Name`, `Nachname`, `Telefonnummer`, `Email`) VALUES
(1, 'Martin', 'Matratze', '12346789', 'poco.domaene@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `termin`
--

CREATE TABLE `termin` (
  `ID` bigint(20) NOT NULL,
  `Halle_ID` bigint(20) DEFAULT NULL,
  `Mieter_ID` bigint(20) DEFAULT NULL,
  `Anlass` varchar(255) DEFAULT NULL,
  `Anfang` datetime DEFAULT NULL,
  `Ende` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mieter`
--
ALTER TABLE `mieter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `termin`
--
ALTER TABLE `termin`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Halle_ID` (`Halle_ID`),
  ADD KEY `Mieter_ID` (`Mieter_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entities`
--
ALTER TABLE `entities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `mieter`
--
ALTER TABLE `mieter`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `termin`
--
ALTER TABLE `termin`
  ADD CONSTRAINT `termin_ibfk_1` FOREIGN KEY (`Halle_ID`) REFERENCES `entities` (`id`),
  ADD CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`Mieter_ID`) REFERENCES `mieter` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
