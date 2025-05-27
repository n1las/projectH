-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 27. Mai 2025 um 11:30
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
  `HallenTyp` int(11) DEFAULT NULL,
  `Spielfeldgroesse` int(11) DEFAULT NULL,
  `strasse_nr` int(11) DEFAULT NULL,
  `plz` int(11) DEFAULT NULL,
  `ort` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `entities`
--

INSERT INTO `entities` (`id`, `name`, `image_url`, `strasse`, `HallenTyp`, `Spielfeldgroesse`, `strasse_nr`, `plz`, `ort`) VALUES
(1, 'Hallenbad', 'http://localhost:8080/img/Hallenbad.jpg', 'Grossenbacher-Tor', 1, NULL, NULL, 36088, 'Huenfeld'),
(2, 'Rhoenkampfbahn', 'http://localhost:8080/img/Rhoenkampfbahn.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(3, 'lauftreff', 'http://localhost:8080/img/lauftreff.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(4, 'bundespolizei', 'http://localhost:8080/img/bundespolizei.png', 'Molzebacherstrasse', 1, 1050, 35, 36088, 'Huenfeld'),
(5, 'JAF-Schule', 'http://localhost:8080/img/JAF-Schule.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(6, 'Kreissporthalle-1', 'http://localhost:8080/img/Kreissporthalle-1.jpg', 'Jahnstrasse', 1, 1700, 16, 36088, 'Huenfeld'),
(7, 'Kreissporthalle-3', 'http://localhost:8080/img/Kreissporthalle-3.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(8, 'Kreissporthalle-4', 'http://localhost:8080/img/Kreissporthalle-4.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld'),
(9, 'PGS-Schule', 'http://localhost:8080/img/PGS-Schule.jpg', '', 1, NULL, NULL, 36088, 'Huenfeld');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `mieter`
--

CREATE TABLE `mieter` (
  `ID` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `nachname` varchar(255) DEFAULT NULL,
  `telefonnummer` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `passwort` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `mieter`
--

INSERT INTO `mieter` (`ID`, `name`, `nachname`, `telefonnummer`, `email`, `username`, `passwort`) VALUES
(1, 'Martin', 'Matratze', 12346789, 'poco.domaene@gmail.com', 'gleggmire', NULL),
(2, 'Samuel', 'Autohaus', 1234567899, 'auto.samuel@poco.de', NULL, NULL),
(3, 'Thomas', 'Berger', 2147483647, 'thomas.berger@example.com', NULL, NULL),
(4, 'Julia', 'Krause', 2147483647, 'julia.krause@example.com', NULL, NULL),
(5, 'Daniel', 'Meier', 2147483647, 'daniel.meier@example.com', NULL, NULL),
(6, 'Nina', 'Schmidt', 2147483647, 'nina.schmidt@example.com', NULL, NULL),
(7, 'Sebastian', 'Vogel', 2147483647, 'sebastian.vogel@example.com', NULL, NULL),
(8, 'Kathrin', 'Horn', 2147483647, 'kathrin.horn@example.com', NULL, NULL),
(9, 'Andreas', 'Bauer', 2147483647, 'andreas.bauer@example.com', NULL, NULL),
(10, 'Melanie', 'Jansen', 2147483647, 'melanie.jansen@example.com', NULL, NULL),
(11, 'Stefan', 'Graf', 2147483647, 'stefan.graf@example.com', NULL, NULL),
(12, 'Vanessa', 'Lorenz', 2147483647, 'vanessa.lorenz@example.com', NULL, NULL),
(13, NULL, NULL, NULL, 'webtester.test@gmail.com', NULL, NULL),
(14, 'peter', 'faust', 133908395, 'test2@gmail.com', 'test2', '1234567'),
(15, '123', '123', 123, '123@dd.de', '123', '123'),
(16, 'test', 'tester', 123456789, 'test@gmsil.com', 'test3', '123'),
(17, 'test', 'tester', 1246432, 'test7@gmail.com', 'tester7', '123'),
(18, 'test', 'maier', 1246334, 'tester.10@gmail.com', 'tester10', '123');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `termin`
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
-- Daten für Tabelle `termin`
--

INSERT INTO `termin` (`ID`, `Halle_ID`, `Mieter_ID`, `Anlass`, `Anfang`, `Ende`) VALUES
(1, 1, 1, 'Renovieren', '2025-06-01 14:00:00', '2025-06-01 22:00:00'),
(2, 4, 1, 'Einrichtung', '2025-06-30 13:00:00', '2025-06-30 15:00:00'),
(3, 4, 1, 'Geburtstagsfeier', '2025-06-01 14:00:00', '2025-06-01 20:00:00'),
(4, 4, 2, 'Hochzeitsfeier', '2025-06-03 12:00:00', '2025-06-03 23:00:00'),
(5, 4, 3, 'Firmenmeeting', '2025-06-05 09:00:00', '2025-06-05 17:00:00'),
(6, 4, 4, 'Sportveranstaltung', '2025-06-07 10:00:00', '2025-06-07 15:00:00'),
(7, 4, 5, 'Kunstmarkt', '2025-06-10 08:00:00', '2025-06-10 18:00:00'),
(8, 4, 6, 'Tanzveranstaltung', '2025-06-12 18:00:00', '2025-06-12 23:00:00'),
(9, 4, 7, 'Vortrag', '2025-06-14 16:00:00', '2025-06-14 19:00:00'),
(10, 4, 8, 'Gemeindetreffen', '2025-06-17 15:00:00', '2025-06-17 20:00:00'),
(11, 4, 9, 'Messe', '2025-06-20 09:00:00', '2025-06-20 17:00:00'),
(12, 4, 10, 'Jugendfreizeit', '2025-06-25 10:00:00', '2025-06-25 16:00:00'),
(13, 4, 1, 'Poco Einrichtungsdomaene', '2025-06-01 09:00:00', '2025-06-01 13:00:00'),
(14, 4, 15, 'autohaus', '2025-06-02 19:30:00', '2025-06-02 22:30:00'),
(15, 6, 15, 'Fußballverein', '2025-06-12 19:30:00', '2025-06-12 23:30:00'),
(16, 6, 1, 'Fu?balltraining', '2025-06-02 16:00:00', '2025-06-02 18:00:00'),
(17, 6, 3, 'Privatbuchung Geburtstag', '2025-06-04 14:00:00', '2025-06-04 18:00:00'),
(18, 6, 7, 'Vereinstreffen', '2025-06-06 17:00:00', '2025-06-06 20:00:00'),
(19, 6, 12, 'Turniervorbereitung', '2025-06-08 15:00:00', '2025-06-08 19:00:00'),
(20, 6, 5, 'Tennis-Match', '2025-06-10 10:00:00', '2025-06-10 12:00:00'),
(21, 6, 14, 'Jugendtraining', '2025-06-12 16:30:00', '2025-06-12 18:30:00'),
(22, 6, 9, 'Volleyballspiel', '2025-06-15 19:00:00', '2025-06-15 21:00:00'),
(23, 6, 2, 'Schulveranstaltung', '2025-06-18 08:00:00', '2025-06-18 12:00:00'),
(24, 6, 6, 'Yoga-Kurs', '2025-06-20 09:00:00', '2025-06-20 11:00:00'),
(25, 6, 11, 'Tanzprobe', '2025-06-22 14:00:00', '2025-06-22 16:00:00'),
(26, 6, 8, 'Hallenpflege', '2025-06-24 07:00:00', '2025-06-24 09:00:00'),
(27, 6, 13, 'Handballturnier', '2025-06-26 13:00:00', '2025-06-26 17:00:00'),
(28, 6, 4, 'Basketballtraining', '2025-06-28 17:00:00', '2025-06-28 19:00:00'),
(29, 6, 10, 'Elterntreff', '2025-06-29 15:00:00', '2025-06-29 17:00:00'),
(30, 6, 15, 'Ferienfreizeit Start', '2025-06-30 09:00:00', '2025-06-30 13:00:00'),
(31, 6, 15, 'mieten', '2025-06-13 19:30:00', '2025-06-12 21:30:00'),
(32, 6, 17, 'Fussballverein', '2025-06-09 19:30:00', '2025-06-09 23:30:00'),
(33, 6, 18, 'Tennis', '2025-06-17 19:30:00', '2025-06-17 23:30:00');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `entities`
--
ALTER TABLE `entities`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `mieter`
--
ALTER TABLE `mieter`
  ADD PRIMARY KEY (`ID`);

--
-- Indizes für die Tabelle `termin`
--
ALTER TABLE `termin`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Halle_ID` (`Halle_ID`),
  ADD KEY `Mieter_ID` (`Mieter_ID`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `entities`
--
ALTER TABLE `entities`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT für Tabelle `mieter`
--
ALTER TABLE `mieter`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT für Tabelle `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `termin`
--
ALTER TABLE `termin`
  ADD CONSTRAINT `termin_ibfk_1` FOREIGN KEY (`Halle_ID`) REFERENCES `entities` (`id`),
  ADD CONSTRAINT `termin_ibfk_2` FOREIGN KEY (`Mieter_ID`) REFERENCES `mieter` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
