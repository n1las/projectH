-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 12, 2025 at 11:13 AM
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
(1, 'Sporthalle-Bundespolizei', 'http://localhost:8080/img/Bundespolizei.png', 'Molzbacher Strasse', 1, 1050, 35, 36088, 'Huenfeld'),
(2, 'Sporthalle-Justizvollzugsanstalt', 'http://localhost:8080/img/jvz.png', 'Molzbacher Strasse', 3, 800, 37, 36088, 'Huenfeld'),
(3, 'Sportcenter Grossenbach', 'http://localhost:8080/img/grossenbach', 'Linkbergerstrasse', 1, 288, 29, 36088, 'Huenfeld'),
(4, 'Grundschule Mackenzell', 'http://localhost:8080/img/mackenzell.jpg', 'Dallbergerstr', 1, 405, 12, 36088, 'Huenfeld'),
(5, 'Grundschule Michelsrombach', 'http://localhost:8080/img/michelsrombach.jpg', 'Richard-Schick-Strasse', 1, 187, 12, 36088, 'Huenfeld'),
(6, 'Johann-Adam-Foersterschule', 'http://localhost:8080/img/JAF-Schule.jpg', 'Ostlandring', 1, 288, 10, 36088, 'Huenfeld'),
(7, 'Paul-Gerhardt-Schule', 'http://localhost:8080/img/PGS-Schule.jpg', 'Mackenzeller Strasse', 1, 91, 4, 36088, 'Huenfeld'),
(8, 'Kreissporthalle 2', 'http://localhost:8080/img/Kreissporthalle-1.jpg', 'Jahnstrasse', 2, 568, 18, 36088, 'Huenfeld'),
(9, 'Kreissporthalle 1', 'http://localhost:8080/img/Kreissporthalle-1.jpg', 'Jahnstrasse', 3, 800, 18, 36088, 'Huenfeld'),
(10, 'Kreissporthalle 3', 'http://localhost:8080/img/Kreissporthalle-3.jpg', 'Karl-Medler-Strasse', 2, 528, 10, NULL, NULL),
(11, 'Kreissporthalle 3 Buehne', 'http://localhost:8080/img/Kreissporthalle-3.jpg', 'Karl-Medler-Strasse', 1, 170, 10, NULL, NULL),
(12, 'Kreissporthalle 4', 'http://localhost:8080/img/Kreissporthalle-4.jpg', 'Karl-Medler-Strasse', 2, 800, 8, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `feld`
--

CREATE TABLE `feld` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `entities_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feld`
--

INSERT INTO `feld` (`id`, `name`, `entities_id`) VALUES
(1, 'Feld 1', 1),
(2, 'Feld 1', 2),
(3, 'Feld 2', 2),
(4, 'Feld 3', 2),
(5, 'Feld 1', 3),
(6, 'Feld 1', 4),
(7, 'Feld 1', 5),
(8, 'Feld 1', 6),
(9, 'Feld 1', 7),
(10, 'Feld 1', 8),
(11, 'Feld 2', 8),
(12, 'Feld 1', 9),
(13, 'Feld 2', 9),
(14, 'Feld 3', 9),
(15, 'Feld 1', 10),
(16, 'Feld 2', 10),
(17, 'Feld 1', 11),
(18, 'Feld 1', 12),
(19, 'Feld 2', 12);

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
(21, 'FcBvBodereSo', '12345494', 1),
(22, 'LauraSchmidt', 'passwort123', 1),
(23, 'TobiasMeier', 'passwort123', 1),
(24, 'FcBayern', 'passwort123', 0),
(25, 'VfBStuttgart', 'passwort123', 0),
(26, 'BorussiaDortmund', 'passwort123', 0),
(27, 'TSGHoffenheim', 'passwort123', 0),
(28, 'HamburgerSV', 'passwort123', 0),
(29, 'RBLeipzig', 'passwort123', 0),
(30, 'EintrachtFrankfurt', 'passwort123', 0),
(32, '123', '123', 1),
(33, 'pleb', '123', 0);

-- --------------------------------------------------------

--
-- Table structure for table `termin`
--

CREATE TABLE `termin` (
  `ID` bigint(20) NOT NULL,
  `Mieter_ID` bigint(20) DEFAULT NULL,
  `Anlass` varchar(255) DEFAULT NULL,
  `Anfang` datetime DEFAULT NULL,
  `Ende` datetime DEFAULT NULL,
  `isConfirmed` varchar(255) DEFAULT NULL,
  `feld_id` bigint(20) NOT NULL
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
-- Indexes for table `feld`
--
ALTER TABLE `feld`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entities_id` (`entities_id`);

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
  ADD KEY `Mieter_ID` (`Mieter_ID`),
  ADD KEY `fk_termin_feld` (`feld_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `entities`
--
ALTER TABLE `entities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `feld`
--
ALTER TABLE `feld`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `mieter`
--
ALTER TABLE `mieter`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feld`
--
ALTER TABLE `feld`
  ADD CONSTRAINT `feld_ibfk_1` FOREIGN KEY (`entities_id`) REFERENCES `entities` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `termin`
--
ALTER TABLE `termin`
  ADD CONSTRAINT `fk_termin_feld` FOREIGN KEY (`feld_id`) REFERENCES `feld` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`Mieter_ID`) REFERENCES `mieter` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
