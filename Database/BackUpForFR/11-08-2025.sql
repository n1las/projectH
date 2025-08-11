-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 11, 2025 at 10:03 PM
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
  `Halle_ID` bigint(20) DEFAULT NULL,
  `Mieter_ID` bigint(20) DEFAULT NULL,
  `Anlass` varchar(255) DEFAULT NULL,
  `Anfang` datetime DEFAULT NULL,
  `Ende` datetime DEFAULT NULL,
  `isConfirmed` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `termin`
--

INSERT INTO `termin` (`ID`, `Halle_ID`, `Mieter_ID`, `Anlass`, `Anfang`, `Ende`, `isConfirmed`) VALUES
(38, 1, 24, 'Training', '2025-07-01 10:00:00', '2025-07-01 12:00:00', 'confirmed'),
(39, 2, 25, 'Turnier', '2025-07-02 15:00:00', '2025-07-02 18:00:00', 'expired'),
(40, 3, 26, 'Testspiel', '2025-07-03 09:00:00', '2025-07-03 11:00:00', 'expired'),
(41, 4, 27, 'Training', '2025-07-04 16:00:00', '2025-07-04 18:00:00', 'expired'),
(42, 5, 28, 'Freundschaftsspiel', '2025-07-05 14:00:00', '2025-07-05 16:00:00', 'expired'),
(43, 6, 29, 'Training', '2025-07-06 17:00:00', '2025-07-06 19:00:00', 'expired'),
(44, 7, 30, 'Turnier', '2025-07-07 13:00:00', '2025-07-07 16:00:00', 'expired'),
(45, 8, 24, 'Testspiel', '2025-07-08 08:00:00', '2025-07-08 10:00:00', 'confirmed'),
(47, 1, 26, 'Freundschaftsspiel', '2025-07-10 12:00:00', '2025-07-10 14:00:00', 'expired'),
(48, 2, 27, 'Training', '2025-07-11 10:00:00', '2025-07-11 12:00:00', 'expired'),
(49, 3, 28, 'Turnier', '2025-07-12 14:00:00', '2025-07-12 17:00:00', 'expired'),
(50, 4, 29, 'Testspiel', '2025-07-13 09:00:00', '2025-07-13 11:30:00', 'expired'),
(51, 5, 30, 'Training', '2025-07-14 15:00:00', '2025-07-14 17:00:00', 'expired'),
(52, 6, 24, 'Training', '2025-07-15 13:00:00', '2025-07-15 15:00:00', 'confirmed'),
(53, 7, 25, 'Turnier', '2025-07-16 11:00:00', '2025-07-16 14:00:00', 'expired'),
(54, 8, 26, 'Freundschaftsspiel', '2025-07-17 17:00:00', '2025-07-17 19:00:00', 'expired'),
(56, 1, 28, 'Testspiel', '2025-07-19 09:00:00', '2025-07-19 11:00:00', 'expired'),
(57, 2, 29, 'Training', '2025-07-20 14:00:00', '2025-07-20 16:00:00', 'expired'),
(58, 3, 30, 'Turnier', '2025-07-21 13:00:00', '2025-07-21 15:00:00', 'expired'),
(59, 4, 24, 'Testspiel', '2025-07-22 08:00:00', '2025-07-22 10:00:00', 'confirmed'),
(60, 5, 25, 'Training', '2025-07-23 16:00:00', '2025-07-23 18:00:00', 'expired'),
(61, 6, 26, 'Turnier', '2025-07-24 11:00:00', '2025-07-24 13:00:00', 'expired'),
(62, 7, 27, 'Freundschaftsspiel', '2025-07-25 17:00:00', '2025-07-25 19:00:00', 'expired'),
(63, 8, 28, 'Training', '2025-07-26 10:00:00', '2025-07-26 12:00:00', 'expired'),
(65, 1, 30, 'Training', '2025-07-28 14:00:00', '2025-07-28 16:00:00', 'expired'),
(66, 2, 24, 'Turnier', '2025-07-29 13:00:00', '2025-07-29 15:00:00', 'confirmed'),
(67, 3, 25, 'Freundschaftsspiel', '2025-07-30 15:00:00', '2025-07-30 17:00:00', 'expired'),
(363, 9, 21, 'UpInTheClub', '2025-08-06 13:00:00', '2025-08-06 18:00:00', 'expired'),
(364, 9, 21, 'UpInTheClub', '2025-08-13 13:00:00', '2025-08-13 18:00:00', 'unconfirmed'),
(365, 9, 21, 'UpInTheClub', '2025-08-20 13:00:00', '2025-08-20 18:00:00', 'unconfirmed'),
(366, 9, 21, 'UpInTheClub', '2025-08-27 13:00:00', '2025-08-27 18:00:00', 'unconfirmed'),
(368, 1, 24, 'bitte', '2025-09-17 08:25:00', '2025-09-17 19:25:00', 'confirmed'),
(369, 1, 24, 'bitte', '2025-09-24 08:25:00', '2025-09-24 19:25:00', 'confirmed'),
(370, 1, 24, 'bitte', '2025-10-01 08:25:00', '2025-10-01 19:25:00', 'confirmed'),
(371, 1, 24, 'bitte', '2025-10-08 08:25:00', '2025-10-08 19:25:00', 'confirmed'),
(372, 1, 24, 'bitte', '2025-10-15 08:25:00', '2025-10-15 19:25:00', 'confirmed'),
(373, 1, 24, 'bitte', '2025-10-22 08:25:00', '2025-10-22 19:25:00', 'confirmed'),
(374, 1, 24, 'bitte', '2025-10-29 08:25:00', '2025-10-29 19:25:00', 'confirmed'),
(375, 1, 24, 'bitte', '2025-11-05 08:25:00', '2025-11-05 19:25:00', 'confirmed'),
(376, 1, 24, 'bitte', '2025-11-12 08:25:00', '2025-11-12 19:25:00', 'confirmed'),
(377, 1, 24, 'bitte', '2025-11-19 08:25:00', '2025-11-19 19:25:00', 'confirmed'),
(378, 1, 24, 'bitte', '2025-11-26 08:25:00', '2025-11-26 19:25:00', 'confirmed'),
(379, 1, 24, 'bitte', '2025-12-03 08:25:00', '2025-12-03 19:25:00', 'confirmed'),
(380, 1, 24, 'bitte', '2025-12-10 08:25:00', '2025-12-10 19:25:00', 'confirmed'),
(381, 1, 24, 'bitte', '2025-12-17 08:25:00', '2025-12-17 19:25:00', 'confirmed'),
(382, 1, 24, 'bitte', '2025-12-24 08:25:00', '2025-12-24 19:25:00', 'confirmed'),
(383, 1, 24, 'bitte', '2025-12-31 08:25:00', '2025-12-31 19:25:00', 'confirmed'),
(384, 1, 24, 'bitte', '2026-01-07 08:25:00', '2026-01-07 19:25:00', 'confirmed'),
(385, 1, 24, 'bitte', '2026-01-14 08:25:00', '2026-01-14 19:25:00', 'confirmed'),
(386, 1, 24, 'dance', '2025-09-10 09:35:00', '2025-09-10 14:31:00', 'confirmed'),
(387, 1, 24, 'dance', '2026-01-21 09:35:00', '2026-01-21 14:31:00', 'confirmed'),
(388, NULL, NULL, 'sommer', '2025-08-01 19:30:00', '2025-08-13 19:30:00', 'confirmed'),
(389, 7, NULL, 'sommerferien', '2025-08-01 19:30:00', '2025-08-12 19:30:00', 'confirmed'),
(390, 5, NULL, 'sommer', '2025-08-01 17:45:00', '2025-11-15 17:46:00', 'confirmed'),
(391, 5, 24, 'fussssballl', '2025-11-19 18:47:00', '2025-11-19 23:49:00', 'confirmed'),
(392, 5, 24, 'fussssballl', '2025-11-26 18:47:00', '2025-11-26 23:49:00', 'confirmed'),
(393, 5, 24, 'fussssballl', '2025-12-03 18:47:00', '2025-12-03 23:49:00', 'confirmed'),
(394, 5, 24, 'fussssballl', '2025-12-10 18:47:00', '2025-12-10 23:49:00', 'confirmed'),
(395, 5, 24, 'fussssballl', '2025-12-17 18:47:00', '2025-12-17 23:49:00', 'confirmed'),
(396, 5, 24, 'fussssballl', '2025-12-24 18:47:00', '2025-12-24 23:49:00', 'confirmed'),
(397, 5, 24, 'fussssballl', '2025-12-31 18:47:00', '2025-12-31 23:49:00', 'confirmed'),
(398, 5, 24, 'fussssballl', '2026-01-07 18:47:00', '2026-01-07 23:49:00', 'confirmed'),
(399, 5, 24, 'fussssballl', '2026-01-14 18:47:00', '2026-01-14 23:49:00', 'confirmed'),
(400, 5, 24, 'fussssballl', '2026-01-21 18:47:00', '2026-01-21 23:49:00', 'confirmed'),
(401, 5, 24, 'fussssballl', '2026-01-28 18:47:00', '2026-01-28 23:49:00', 'confirmed'),
(402, 5, 24, 'fussssballl', '2026-02-04 18:47:00', '2026-02-04 23:49:00', 'confirmed'),
(403, 5, 24, 'fussssballl', '2026-02-11 18:47:00', '2026-02-11 23:49:00', 'confirmed'),
(404, 5, 24, 'fussssballl', '2026-02-18 18:47:00', '2026-02-18 23:49:00', 'confirmed'),
(405, 5, 24, 'fussssballl', '2026-02-25 18:47:00', '2026-02-25 23:49:00', 'confirmed'),
(406, 5, 24, 'fussssballl', '2026-03-04 18:47:00', '2026-03-04 23:49:00', 'confirmed'),
(407, 5, 24, 'fussssballl', '2026-03-11 18:47:00', '2026-03-11 23:49:00', 'confirmed'),
(408, 5, 24, 'training', '2025-11-20 09:53:00', '2025-11-20 16:54:00', 'confirmed'),
(409, 5, 24, 'training', '2025-11-27 09:53:00', '2025-11-27 16:54:00', 'confirmed'),
(410, 5, 24, 'training', '2025-12-04 09:53:00', '2025-12-04 16:54:00', 'confirmed'),
(411, 5, 24, 'training', '2025-12-11 09:53:00', '2025-12-11 16:54:00', 'confirmed'),
(412, 5, 24, 'training', '2025-12-18 09:53:00', '2025-12-18 16:54:00', 'confirmed'),
(413, 5, 24, 'training', '2025-12-25 09:53:00', '2025-12-25 16:54:00', 'confirmed'),
(414, 5, 24, 'training', '2026-01-01 09:53:00', '2026-01-01 16:54:00', 'confirmed'),
(415, 5, 24, 'training', '2026-01-08 09:53:00', '2026-01-08 16:54:00', 'confirmed'),
(416, 5, 24, 'training', '2026-01-15 09:53:00', '2026-01-15 16:54:00', 'unconfirmed'),
(417, 5, 24, 'training', '2026-01-22 09:53:00', '2026-01-22 16:54:00', 'unconfirmed'),
(418, 5, 24, 'training', '2026-01-29 09:53:00', '2026-01-29 16:54:00', 'unconfirmed'),
(419, 5, 24, 'training', '2026-02-05 09:53:00', '2026-02-05 16:54:00', 'unconfirmed'),
(420, 5, 24, 'training', '2026-02-12 09:53:00', '2026-02-12 16:54:00', 'unconfirmed'),
(421, 5, 24, 'training', '2026-02-19 09:53:00', '2026-02-19 16:54:00', 'unconfirmed'),
(422, 5, 24, 'training', '2026-02-26 09:53:00', '2026-02-26 16:54:00', 'unconfirmed'),
(423, 5, 24, 'training', '2026-03-05 09:53:00', '2026-03-05 16:54:00', 'unconfirmed'),
(424, 5, 24, 'training', '2026-03-12 09:53:00', '2026-03-12 16:54:00', 'unconfirmed'),
(425, 5, 24, 'training', '2026-03-19 09:53:00', '2026-03-19 16:54:00', 'unconfirmed'),
(426, 5, 24, 'training', '2026-03-26 09:53:00', '2026-03-26 16:54:00', 'unconfirmed'),
(427, 5, 24, 'training', '2026-04-02 09:53:00', '2026-04-02 16:54:00', 'unconfirmed'),
(428, 5, 24, 'training', '2026-04-09 09:53:00', '2026-04-09 16:54:00', 'unconfirmed'),
(429, 5, 24, 'training', '2026-04-16 09:53:00', '2026-04-16 16:54:00', 'unconfirmed'),
(430, 5, 24, 'training', '2026-04-23 09:53:00', '2026-04-23 16:54:00', 'unconfirmed'),
(431, 5, 24, 'training', '2026-04-30 09:53:00', '2026-04-30 16:54:00', 'unconfirmed'),
(432, 5, 24, 'training', '2026-05-07 09:53:00', '2026-05-07 16:54:00', 'unconfirmed'),
(433, 5, 24, 'training', '2026-05-14 09:53:00', '2026-05-14 16:54:00', 'unconfirmed'),
(434, 1, 25, 'handball', '2025-07-31 02:56:00', '2025-07-31 02:56:00', 'false'),
(435, 1, 24, 'handball', '2025-07-31 19:17:00', '2025-07-31 20:17:00', 'false'),
(436, 1, 24, 'sneakyGolem', '2025-07-29 03:22:00', '2025-07-29 05:22:00', 'expired'),
(438, 1, 32, 'test', '2025-10-13 14:49:00', '2025-10-13 18:49:00', 'confirmed'),
(441, 1, 32, 'test', '2025-11-03 14:49:00', '2025-11-03 18:49:00', 'confirmed'),
(443, 1, 32, 'test', '2025-11-17 14:49:00', '2025-11-17 18:49:00', 'confirmed'),
(451, 1, 32, 'test', '2026-01-12 14:49:00', '2026-01-12 18:49:00', 'confirmed'),
(453, 1, 32, 'test', '2026-01-26 14:49:00', '2026-01-26 18:49:00', 'cancelled'),
(454, 1, 32, 'test', '2026-02-02 14:49:00', '2026-02-02 18:49:00', 'cancelled'),
(455, 1, 32, 'test', '2026-02-09 14:49:00', '2026-02-09 18:49:00', 'cancelled'),
(456, 1, 32, 'test', '2026-02-16 14:49:00', '2026-02-16 18:49:00', 'confirmed'),
(457, 1, 32, 'test', '2026-02-23 14:49:00', '2026-02-23 18:49:00', 'cancelled'),
(458, 1, 32, 'test', '2026-03-02 14:49:00', '2026-03-02 18:49:00', 'unconfirmed'),
(459, 1, 32, 'test', '2026-03-09 14:49:00', '2026-03-09 18:49:00', 'unconfirmed'),
(460, 1, 32, 'test', '2026-03-16 14:49:00', '2026-03-16 18:49:00', 'unconfirmed'),
(461, 1, 32, 'test', '2026-03-23 14:49:00', '2026-03-23 18:49:00', 'unconfirmed'),
(462, 1, 32, 'test', '2026-03-30 14:49:00', '2026-03-30 18:49:00', 'unconfirmed'),
(463, 1, 32, 'test', '2026-04-06 14:49:00', '2026-04-06 18:49:00', 'unconfirmed'),
(464, 1, 32, 'test', '2026-04-13 14:49:00', '2026-04-13 18:49:00', 'unconfirmed'),
(465, 1, 33, 'testing', '2025-08-14 13:27:00', '2025-08-14 16:27:00', 'unconfirmed'),
(466, 1, 33, 'trainingggg', '2025-08-24 15:28:00', '2025-08-24 19:28:00', 'unconfirmed'),
(467, 1, 33, 'trainingggg', '2025-08-31 15:28:00', '2025-08-31 19:28:00', 'unconfirmed'),
(468, 1, 33, 'trainingggg', '2025-09-07 15:28:00', '2025-09-07 19:28:00', 'unconfirmed'),
(469, 1, 33, 'trainingggg', '2025-09-14 15:28:00', '2025-09-14 19:28:00', 'unconfirmed'),
(470, 1, 33, 'trainingggg', '2025-09-21 15:28:00', '2025-09-21 19:28:00', 'unconfirmed'),
(471, 1, 33, 'trainingggg', '2025-09-28 15:28:00', '2025-09-28 19:28:00', 'unconfirmed'),
(472, 1, 33, 'trainingggg', '2025-10-05 15:28:00', '2025-10-05 19:28:00', 'unconfirmed'),
(473, 1, 33, 'trainingggg', '2025-10-12 15:28:00', '2025-10-12 19:28:00', 'unconfirmed'),
(474, 1, 33, 'trainingggg', '2025-10-19 15:28:00', '2025-10-19 19:28:00', 'unconfirmed'),
(475, 1, 33, 'trainingggg', '2025-10-26 15:28:00', '2025-10-26 19:28:00', 'unconfirmed'),
(476, 1, 33, 'trainingggg', '2025-11-02 15:28:00', '2025-11-02 19:28:00', 'unconfirmed'),
(477, 1, 33, 'trainingggg', '2025-11-09 15:28:00', '2025-11-09 19:28:00', 'unconfirmed'),
(478, 1, 33, 'trainingggg', '2025-11-16 15:28:00', '2025-11-16 19:28:00', 'unconfirmed'),
(479, 1, 33, 'trainingggg', '2025-11-23 15:28:00', '2025-11-23 19:28:00', 'unconfirmed'),
(480, 1, 33, 'trainingggg', '2025-11-30 15:28:00', '2025-11-30 19:28:00', 'unconfirmed'),
(481, 1, 33, 'trainingggg', '2025-12-07 15:28:00', '2025-12-07 19:28:00', 'unconfirmed'),
(482, 1, 33, 'trainingggg', '2025-12-14 15:28:00', '2025-12-14 19:28:00', 'unconfirmed'),
(483, 1, 33, 'trainingggg', '2025-12-21 15:28:00', '2025-12-21 19:28:00', 'unconfirmed'),
(484, 1, 33, 'trainingggg', '2025-12-28 15:28:00', '2025-12-28 19:28:00', 'unconfirmed'),
(485, 1, 33, 'trainingggg', '2026-01-04 15:28:00', '2026-01-04 19:28:00', 'unconfirmed'),
(486, 1, 33, 'trainingggg', '2026-01-11 15:28:00', '2026-01-11 19:28:00', 'unconfirmed'),
(487, 1, 33, 'trainingggg', '2026-01-18 15:28:00', '2026-01-18 19:28:00', 'unconfirmed'),
(488, 1, 33, 'trainingggg', '2026-01-25 15:28:00', '2026-01-25 19:28:00', 'unconfirmed'),
(489, 1, 33, 'trainingggg', '2026-02-01 15:28:00', '2026-02-01 19:28:00', 'unconfirmed'),
(490, 1, 33, 'trainingggg', '2026-02-08 15:28:00', '2026-02-08 19:28:00', 'unconfirmed'),
(491, 1, 33, 'trainingggg', '2026-02-15 15:28:00', '2026-02-15 19:28:00', 'unconfirmed'),
(492, 1, 33, 'trainingggg', '2026-02-22 15:28:00', '2026-02-22 19:28:00', 'unconfirmed'),
(493, 1, 33, 'trainingggg', '2026-03-01 15:28:00', '2026-03-01 19:28:00', 'unconfirmed'),
(494, 1, 33, 'trainingggg', '2026-03-08 15:28:00', '2026-03-08 19:28:00', 'unconfirmed'),
(495, 1, 33, 'trainingggg', '2026-03-15 15:28:00', '2026-03-15 19:28:00', 'unconfirmed'),
(496, 1, 33, 'trainingggg', '2026-03-22 15:28:00', '2026-03-22 19:28:00', 'unconfirmed'),
(497, 1, 33, 'trainingggg', '2026-03-29 15:28:00', '2026-03-29 19:28:00', 'unconfirmed'),
(498, 1, 33, 'trainingggg', '2026-04-05 15:28:00', '2026-04-05 19:28:00', 'unconfirmed'),
(499, 1, 33, 'trainingggg', '2026-04-12 15:28:00', '2026-04-12 19:28:00', 'unconfirmed'),
(500, 1, 33, 'trainingggg', '2026-04-19 15:28:00', '2026-04-19 19:28:00', 'unconfirmed'),
(501, 1, 33, 'trainingggg', '2026-04-26 15:28:00', '2026-04-26 19:28:00', 'unconfirmed'),
(502, 1, NULL, 'freien', '2026-05-21 20:42:00', '2026-07-17 20:43:00', 'block');

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `mieter`
--
ALTER TABLE `mieter`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=503;

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
