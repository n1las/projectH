-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 19, 2025 at 12:41 AM
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
(1, 'gleggmire', '123', 1),
(2, NULL, NULL, 0),
(3, NULL, NULL, 0),
(4, NULL, NULL, 0),
(5, NULL, NULL, 0),
(6, NULL, NULL, 0),
(7, NULL, NULL, 0),
(8, NULL, NULL, 0),
(9, NULL, NULL, 0),
(10, NULL, NULL, 0),
(11, NULL, NULL, 0),
(12, NULL, NULL, 0),
(13, NULL, NULL, 0),
(14, 'petori', 'brian', 0),
(15, '123', '1234', 0),
(16, 'brian', '123', 0),
(17, 'test3', '1234', 0),
(18, 'lois1', 'abc', 0),
(19, '1', '1', 0),
(20, 'test4', '123', 0);

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
(1, 1, 1, 'Renovieren', '2025-06-01 14:00:00', '2025-06-01 22:00:00', 1),
(2, 4, 1, 'Einrichtung', '2025-06-30 13:00:00', '2025-06-30 15:00:00', 1),
(3, 4, 1, 'Geburtstagsfeier', '2025-06-01 14:00:00', '2025-06-01 20:00:00', 0),
(4, 4, 2, 'Hochzeitsfeier', '2025-06-03 12:00:00', '2025-06-03 23:00:00', 0),
(5, 4, 3, 'Firmenmeeting', '2025-06-05 09:00:00', '2025-06-05 17:00:00', 0),
(6, 4, 4, 'Sportveranstaltung', '2025-06-07 10:00:00', '2025-06-07 15:00:00', 0),
(7, 4, 5, 'Kunstmarkt', '2025-06-10 08:00:00', '2025-06-10 18:00:00', 0),
(8, 4, 6, 'Tanzveranstaltung', '2025-06-12 18:00:00', '2025-06-12 23:00:00', 0),
(9, 4, 7, 'Vortrag', '2025-06-14 16:00:00', '2025-06-14 19:00:00', 0),
(10, 4, 8, 'Gemeindetreffen', '2025-06-17 15:00:00', '2025-06-17 20:00:00', 0),
(11, 4, 9, 'Messe', '2025-06-20 09:00:00', '2025-06-20 17:00:00', 0),
(12, 4, 10, 'Jugendfreizeit', '2025-06-25 10:00:00', '2025-06-25 16:00:00', 0),
(13, 4, 1, 'Poco Einrichtungsdomaene', '2025-06-01 09:00:00', '2025-06-01 13:00:00', 0),
(14, 4, 15, 'Teller waschen', '2025-06-03 19:30:00', '2025-06-03 22:30:00', 0),
(15, 1, 18, 'Geburtstag', '2025-06-09 19:30:00', '2025-06-13 12:35:00', 0),
(16, 2, 18, 'fußball', '2025-06-03 19:30:00', '2025-06-03 21:36:00', 0),
(17, 3, 18, 'peter', '2025-06-12 19:30:00', '2025-06-12 23:30:00', 0),
(18, 2, 15, 'kicken', '2025-06-05 19:30:00', '2025-06-05 23:30:00', 0),
(19, 2, 15, 'zulassen', '2025-06-12 19:30:00', '2025-06-12 23:30:00', 0),
(20, 4, 20, 'Fu0ball', '2025-06-18 20:30:00', '2025-06-12 23:30:00', 0),
(21, 4, 20, 'fußball', '2025-06-18 20:30:00', '2025-06-12 22:30:00', 0),
(22, 4, 20, 'fußball', '2025-06-18 19:30:00', '2025-06-18 21:30:00', 0),
(23, 4, 20, 'fussbal', '2025-06-20 19:30:00', '2025-06-20 22:30:00', 0),
(24, 4, 20, 'fusball3', '2025-06-20 19:30:00', '2025-06-12 22:30:00', 0),
(25, 4, 20, 'messe2 ', '2025-06-20 08:30:00', '2025-06-12 22:30:00', 0);

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
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

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
