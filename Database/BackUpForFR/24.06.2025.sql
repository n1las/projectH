-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2025 at 12:59 AM
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
  `username` varchar(255) DEFAULT NULL,
  `passwort` varchar(255) DEFAULT NULL,
  `isAdmin` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mieter`
--

INSERT INTO `mieter` (`ID`, `username`, `passwort`, `isAdmin`) VALUES
(21, 'MarkusMueller', 'passwort123', 1),
(22, 'LauraSchmidt', 'passwort123', 1),
(23, 'TobiasMeier', 'passwort123', 1),
(24, 'FcBayern', 'passwort123', 0),
(25, 'VfBStuttgart', 'passwort123', 0),
(26, 'BorussiaDortmund', 'passwort123', 0),
(27, 'TSGHoffenheim', 'passwort123', 0),
(28, 'HamburgerSV', 'passwort123', 0),
(29, 'RBLeipzig', 'passwort123', 0),
(30, 'EintrachtFrankfurt', 'passwort123', 0);

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
  `Ende` datetime DEFAULT NULL,
  `isConfirmed` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `termin`
--

INSERT INTO `termin` (`ID`, `Halle_ID`, `Mieter_ID`, `Anlass`, `Anfang`, `Ende`, `isConfirmed`) VALUES
(38, 1, 24, 'Training', '2025-07-01 10:00:00', '2025-07-01 12:00:00', 0),
(39, 2, 25, 'Turnier', '2025-07-02 15:00:00', '2025-07-02 18:00:00', 0),
(40, 3, 26, 'Testspiel', '2025-07-03 09:00:00', '2025-07-03 11:00:00', 0),
(41, 4, 27, 'Training', '2025-07-04 16:00:00', '2025-07-04 18:00:00', 0),
(42, 5, 28, 'Freundschaftsspiel', '2025-07-05 14:00:00', '2025-07-05 16:00:00', 0),
(43, 6, 29, 'Training', '2025-07-06 17:00:00', '2025-07-06 19:00:00', 0),
(44, 7, 30, 'Turnier', '2025-07-07 13:00:00', '2025-07-07 16:00:00', 0),
(45, 8, 24, 'Testspiel', '2025-07-08 08:00:00', '2025-07-08 10:00:00', 0),
(46, 9, 25, 'Training', '2025-07-09 11:00:00', '2025-07-09 13:00:00', 0),
(47, 1, 26, 'Freundschaftsspiel', '2025-07-10 12:00:00', '2025-07-10 14:00:00', 0),
(48, 2, 27, 'Training', '2025-07-11 10:00:00', '2025-07-11 12:00:00', 0),
(49, 3, 28, 'Turnier', '2025-07-12 14:00:00', '2025-07-12 17:00:00', 0),
(50, 4, 29, 'Testspiel', '2025-07-13 09:00:00', '2025-07-13 11:30:00', 0),
(51, 5, 30, 'Training', '2025-07-14 15:00:00', '2025-07-14 17:00:00', 0),
(52, 6, 24, 'Training', '2025-07-15 13:00:00', '2025-07-15 15:00:00', 0),
(53, 7, 25, 'Turnier', '2025-07-16 11:00:00', '2025-07-16 14:00:00', 0),
(54, 8, 26, 'Freundschaftsspiel', '2025-07-17 17:00:00', '2025-07-17 19:00:00', 0),
(55, 9, 27, 'Training', '2025-07-18 10:00:00', '2025-07-18 12:00:00', 0),
(56, 1, 28, 'Testspiel', '2025-07-19 09:00:00', '2025-07-19 11:00:00', 0),
(57, 2, 29, 'Training', '2025-07-20 14:00:00', '2025-07-20 16:00:00', 0),
(58, 3, 30, 'Turnier', '2025-07-21 13:00:00', '2025-07-21 15:00:00', 0),
(59, 4, 24, 'Testspiel', '2025-07-22 08:00:00', '2025-07-22 10:00:00', 0),
(60, 5, 25, 'Training', '2025-07-23 16:00:00', '2025-07-23 18:00:00', 0),
(61, 6, 26, 'Turnier', '2025-07-24 11:00:00', '2025-07-24 13:00:00', 0),
(62, 7, 27, 'Freundschaftsspiel', '2025-07-25 17:00:00', '2025-07-25 19:00:00', 0),
(63, 8, 28, 'Training', '2025-07-26 10:00:00', '2025-07-26 12:00:00', 0),
(64, 9, 29, 'Testspiel', '2025-07-27 09:00:00', '2025-07-27 11:00:00', 0),
(65, 1, 30, 'Training', '2025-07-28 14:00:00', '2025-07-28 16:00:00', 0),
(66, 2, 24, 'Turnier', '2025-07-29 13:00:00', '2025-07-29 15:00:00', 0),
(67, 3, 25, 'Freundschaftsspiel', '2025-07-30 15:00:00', '2025-07-30 17:00:00', 0);

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
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

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
