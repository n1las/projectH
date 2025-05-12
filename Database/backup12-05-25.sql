-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 12. Mai 2025 um 09:00
-- Server-Version: 10.4.32-MariaDB
-- PHP-Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `project`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `entities`
--

CREATE TABLE `entities` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `strasse` varchar(255) DEFAULT NULL,
  `kontaktperson` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `HallenTyp` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `entities`
--

INSERT INTO `entities` (`id`, `name`, `image_url`, `strasse`, `kontaktperson`, `email`, `HallenTyp`) VALUES
(1, 'Hallenbad', 'http://localhost:8080/img/Hallenbad.jpg', NULL, NULL, NULL, NULL),
(2, 'Rhoenkampfbahn', 'http://localhost:8080/img/Rhoenkampfbahn.jpg', NULL, NULL, NULL, NULL),
(3, 'lauftreff', 'http://localhost:8080/img/lauftreff.jpg', NULL, NULL, NULL, NULL),
(4, 'bundespolizei', 'http://localhost:8080/img/bundespolizei.png', NULL, NULL, NULL, NULL),
(5, 'JAF-Schule', 'http://localhost:8080/img/JAF-Schule.jpg', NULL, NULL, NULL, NULL),
(6, 'Kreissporthalle-1', 'http://localhost:8080/img/Kreissporthalle-1.jpg', NULL, NULL, NULL, NULL),
(7, 'Kreissporthalle-3', 'http://localhost:8080/img/Kreissporthalle-3.jpg', NULL, NULL, NULL, NULL),
(8, 'Kreissporthalle-4', 'http://localhost:8080/img/Kreissporthalle-4.jpg', NULL, NULL, NULL, NULL),
(9, 'PGS-Schule', 'http://localhost:8080/img/PGS-Schule.jpg', NULL, NULL, NULL, NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `entities`
--
ALTER TABLE `entities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
