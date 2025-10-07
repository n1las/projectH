-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: my-mariadb
-- Generation Time: Oct 07, 2025 at 06:16 PM
-- Server version: 12.0.2-MariaDB-ubu2404
-- PHP Version: 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mydatabase`
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
(1, 'Sporthalle-Bundespolizei', '/img/Bundespolizei.png', 'Molzbacher Strasse', 1, 1050, 35, 36088, 'Huenfeld'),
(2, 'Sporthalle-Justizvollzugsanstalt', '/img/jvz.jpg', 'Molzbacher Strasse', 3, 800, 37, 36088, 'Huenfeld'),
(3, 'Sportcenter Grossenbach', '/img/grossenbach.jpg', 'Linkbergerstrasse', 1, 288, 29, 36088, 'Huenfeld'),
(4, 'Grundschule Mackenzell', '/img/mackenzell.jpg', 'Dallbergerstr', 1, 405, 12, 36088, 'Huenfeld'),
(5, 'Grundschule Michelsrombach', '/img/michelsrombach.jpg', 'Richard-Schick-Strasse', 1, 187, 12, 36088, 'Huenfeld'),
(6, 'Johann-Adam-Foersterschule', '/img/JAF-Schule.jpg', 'Ostlandring', 1, 288, 10, 36088, 'Huenfeld'),
(7, 'Paul-Gerhardt-Schule', '/img/PGS-Schule.jpg', 'Mackenzeller Strasse', 1, 91, 4, 36088, 'Huenfeld'),
(8, 'Kreissporthalle 2', '/img/Kreissporthalle-1.jpg', 'Jahnstrasse', 2, 568, 18, 36088, 'Huenfeld'),
(9, 'Kreissporthalle 1', '/img/Kreissporthalle-1.jpg', 'Jahnstrasse', 3, 800, 18, 36088, 'Huenfeld'),
(10, 'Kreissporthalle 3', '/img/Kreissporthalle-3.jpg', 'Karl-Medler-Strasse', 2, 528, 10, 36088, 'Huenfeld'),
(11, 'Kreissporthalle 3 Buehne', '/img/Kreissporthalle-3.jpg', 'Karl-Medler-Strasse', 1, 170, 10, 36088, 'Huenfeld'),
(12, 'Kreissporthalle 4', '/img/Kreissporthalle-4.jpg', 'Karl-Medler-Strasse', 2, 800, 8, 36088, 'Huenfeld');

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
(22, 'LauraSchmidt', 'passwort123', 1),
(23, 'TobiasMeier', 'passwort123', 1),
(24, 'FcBayern', 'passwort123', 0),
(25, 'VfBStuttgart', 'passwort123', 0),
(26, 'BorussiaDortmund', 'passwort123', 0),
(27, 'TSGHoffenheim', 'passwort123', 0),
(28, 'HamburgerSV', 'passwort123', 0),
(29, 'RBLeipzig', 'passwort123', 0),
(30, 'EintrachtFrankfurt', 'passwort123', 0),
(32, 'Admin', '123', 1),
(33, 'TestUser', '123', 0);

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
-- Dumping data for table `termin`
--

INSERT INTO `termin` (`ID`, `Mieter_ID`, `Anlass`, `Anfang`, `Ende`, `isConfirmed`, `feld_id`) VALUES
(1, 29, 'Handball', '2025-12-19 05:34:00', '2025-12-19 10:34:00', 'cancelled', 1),
(2, 29, 'Sportkurs', '2025-12-29 13:20:00', '2025-12-29 18:20:00', 'cancelled', 7),
(3, 30, 'Vereinsmeisterschaft', '2025-10-12 05:01:00', '2025-10-12 11:01:00', 'cancelled', 13),
(4, 22, 'Freundschaftsspiel', '2025-12-26 11:18:00', '2025-12-26 16:18:00', 'confirmed', 10),
(5, 30, 'Konzert', '2025-12-22 07:36:00', '2025-12-22 12:36:00', 'cancelled', 9),
(6, 22, 'Handball', '2025-11-04 04:31:00', '2025-11-04 10:31:00', 'cancelled', 6),
(7, 29, 'Handball', '2025-12-08 11:11:00', '2025-12-08 16:11:00', 'confirmed', 1),
(8, 29, 'Messe', '2025-10-08 02:58:00', '2025-10-08 07:58:00', 'unconfirmed', 1),
(9, 22, 'Vereinsmeisterschaft', '2025-11-22 01:03:00', '2025-11-22 07:03:00', 'cancelled', 11),
(10, 22, 'Flohmarkt', '2025-11-06 12:36:00', '2025-11-06 18:36:00', 'unconfirmed', 8),
(11, 30, 'Abschlussfeier', '2025-11-10 13:29:00', '2025-11-10 18:29:00', 'cancelled', 9),
(12, 22, 'Training', '2025-11-12 13:05:00', '2025-11-12 19:05:00', 'confirmed', 7),
(13, 29, 'Fußballtraining', '2025-11-25 16:04:00', '2025-11-25 21:04:00', 'confirmed', 9),
(14, 22, 'Training', '2025-11-21 14:55:00', '2025-11-21 20:55:00', 'cancelled', 11),
(15, 30, 'Turnier', '2025-12-03 11:37:00', '2025-12-03 16:37:00', 'confirmed', 8),
(16, 22, 'Flohmarkt', '2025-10-28 14:41:00', '2025-10-28 20:41:00', 'confirmed', 4),
(17, 28, 'Fußballtraining', '2025-11-28 04:09:00', '2025-11-28 10:09:00', 'cancelled', 8),
(18, 29, 'Abschlussfeier', '2025-11-08 04:12:00', '2025-11-08 10:12:00', 'unconfirmed', 9),
(19, 28, 'Sportkurs', '2025-10-06 11:48:00', '2025-10-06 16:48:00', 'unconfirmed', 3),
(20, 30, 'Messe', '2025-12-20 11:33:00', '2025-12-20 17:33:00', 'unconfirmed', 13),
(21, 22, 'Konzert', '2025-12-08 17:27:00', '2025-12-08 22:27:00', 'cancelled', 9),
(22, 30, 'Flohmarkt', '2025-10-07 02:43:00', '2025-10-07 07:43:00', 'unconfirmed', 12),
(23, 22, 'Basketball', '2025-12-27 01:55:00', '2025-12-27 06:55:00', 'cancelled', 9),
(24, 28, 'Vereinsmeisterschaft', '2025-11-20 03:24:00', '2025-11-20 08:24:00', 'cancelled', 5),
(25, 30, 'Volleyball', '2025-10-04 00:59:00', '2025-10-04 06:59:00', 'confirmed', 3),
(26, 29, 'Tanzkurs', '2025-10-22 13:01:00', '2025-10-22 18:01:00', 'unconfirmed', 3),
(27, 22, 'Vereinsmeisterschaft', '2025-12-27 03:00:00', '2025-12-27 08:00:00', 'cancelled', 8),
(28, 28, 'Gemeindeversammlung', '2025-10-16 08:12:00', '2025-10-16 14:12:00', 'unconfirmed', 11),
(29, 22, 'Flohmarkt', '2025-12-25 13:23:00', '2025-12-25 19:23:00', 'cancelled', 5),
(30, 30, 'Gemeindeversammlung', '2025-12-25 07:32:00', '2025-12-25 13:32:00', 'cancelled', 11),
(31, 22, 'Tanzkurs', '2025-11-05 10:24:00', '2025-11-05 16:24:00', 'confirmed', 8),
(32, 29, 'Abschlussfeier', '2025-12-25 04:08:00', '2025-12-25 10:08:00', 'unconfirmed', 9),
(33, 22, 'Fußballtraining', '2025-12-11 00:40:00', '2025-12-11 05:40:00', 'unconfirmed', 7),
(34, 30, 'Abschlussfeier', '2025-11-30 17:37:00', '2025-11-30 23:37:00', 'unconfirmed', 1),
(35, 30, 'Fußballtraining', '2025-12-22 02:56:00', '2025-12-22 07:56:00', 'cancelled', 8),
(36, 29, 'Gemeindeversammlung', '2025-12-01 11:40:00', '2025-12-01 17:40:00', 'unconfirmed', 13),
(37, 28, 'Gemeindeversammlung', '2025-12-23 05:55:00', '2025-12-23 11:55:00', 'unconfirmed', 9),
(38, 30, 'Flohmarkt', '2025-11-01 07:56:00', '2025-11-01 13:56:00', 'unconfirmed', 9),
(39, 28, 'Sportkurs', '2025-10-10 13:14:00', '2025-10-10 18:14:00', 'confirmed', 2),
(40, 30, 'Sportkurs', '2025-11-09 12:08:00', '2025-11-09 17:08:00', 'confirmed', 2),
(41, 22, 'Turnier', '2025-10-11 06:14:00', '2025-10-11 11:14:00', 'cancelled', 13),
(42, 29, 'Training', '2025-12-19 13:22:00', '2025-12-19 18:22:00', 'unconfirmed', 9),
(43, 28, 'Basketball', '2025-10-17 12:56:00', '2025-10-17 17:56:00', 'confirmed', 4),
(44, 28, 'Handball', '2025-12-13 10:24:00', '2025-12-13 15:24:00', 'confirmed', 4),
(45, 30, 'Fußballtraining', '2025-12-19 02:31:00', '2025-12-19 08:31:00', 'confirmed', 11),
(46, 30, 'Vereinsmeisterschaft', '2025-11-18 05:25:00', '2025-11-18 11:25:00', 'unconfirmed', 8),
(47, 30, 'Handball', '2025-11-09 02:36:00', '2025-11-09 07:36:00', 'unconfirmed', 6),
(48, 30, 'Sportkurs', '2025-10-02 04:59:00', '2025-10-02 10:59:00', 'cancelled', 3),
(49, 28, 'Messe', '2025-11-11 02:04:00', '2025-11-11 08:04:00', 'confirmed', 1),
(50, 22, 'Training', '2025-11-08 07:31:00', '2025-11-08 13:31:00', 'confirmed', 8),
(51, 22, 'Tanzkurs', '2025-10-12 07:00:00', '2025-10-12 12:00:00', 'cancelled', 5),
(52, 29, 'Sportkurs', '2025-12-21 00:47:00', '2025-12-21 06:47:00', 'confirmed', 5),
(53, 22, 'Konzert', '2025-11-19 00:19:00', '2025-11-19 05:19:00', 'cancelled', 7),
(54, 28, 'Konzert', '2025-12-12 00:10:00', '2025-12-12 05:10:00', 'unconfirmed', 13),
(55, 30, 'Freundschaftsspiel', '2025-10-27 06:18:00', '2025-10-27 11:18:00', 'confirmed', 10),
(56, 29, 'Turnier', '2025-12-13 16:55:00', '2025-12-13 21:55:00', 'cancelled', 8),
(57, 29, 'Fußballtraining', '2025-11-14 08:19:00', '2025-11-14 13:19:00', 'confirmed', 12),
(58, 30, 'Gemeindeversammlung', '2025-10-24 11:40:00', '2025-10-24 16:40:00', 'confirmed', 13),
(59, 28, 'Fußballtraining', '2025-12-04 08:44:00', '2025-12-04 14:44:00', 'unconfirmed', 10),
(60, 30, 'Messe', '2025-10-17 06:27:00', '2025-10-17 11:27:00', 'confirmed', 2),
(61, 22, 'Turnier', '2025-10-18 10:07:00', '2025-10-18 15:07:00', 'confirmed', 10),
(62, 29, 'Vereinsmeisterschaft', '2025-10-28 00:35:00', '2025-10-28 05:35:00', 'cancelled', 4),
(63, 29, 'Volleyball', '2025-10-11 06:01:00', '2025-10-11 11:01:00', 'confirmed', 1),
(64, 29, 'Training', '2025-12-30 13:31:00', '2025-12-30 19:31:00', 'confirmed', 5),
(65, 22, 'Gemeindeversammlung', '2025-11-01 00:01:00', '2025-11-01 05:01:00', 'cancelled', 13),
(66, 28, 'Tanzkurs', '2026-01-01 10:53:00', '2026-01-01 16:53:00', 'confirmed', 10),
(67, 22, 'Basketball', '2025-10-22 06:56:00', '2025-10-22 12:56:00', 'cancelled', 14),
(68, 30, 'Messe', '2025-12-15 14:07:00', '2025-12-15 19:07:00', 'unconfirmed', 8),
(69, 29, 'Messe', '2025-11-01 17:44:00', '2025-11-01 23:44:00', 'confirmed', 12),
(70, 30, 'Vereinsmeisterschaft', '2025-12-06 08:04:00', '2025-12-06 13:04:00', 'unconfirmed', 7),
(71, 30, 'Turnier', '2025-12-31 14:43:00', '2025-12-31 19:43:00', 'unconfirmed', 4),
(72, 22, 'Fußballtraining', '2025-10-16 04:20:00', '2025-10-16 10:20:00', 'cancelled', 6),
(73, 29, 'Fußballtraining', '2025-11-07 05:43:00', '2025-11-07 11:43:00', 'confirmed', 4),
(74, 30, 'Tanzkurs', '2025-11-20 01:58:00', '2025-11-20 06:58:00', 'unconfirmed', 11),
(75, 22, 'Volleyball', '2025-10-03 10:33:00', '2025-10-03 16:33:00', 'confirmed', 5),
(76, 22, 'Freundschaftsspiel', '2025-12-11 15:52:00', '2025-12-11 21:52:00', 'confirmed', 2),
(77, 22, 'Flohmarkt', '2025-10-05 12:28:00', '2025-10-05 18:28:00', 'unconfirmed', 12),
(78, 30, 'Turnier', '2025-12-29 01:06:00', '2025-12-29 07:06:00', 'confirmed', 14),
(79, 29, 'Freundschaftsspiel', '2025-10-28 03:18:00', '2025-10-28 09:18:00', 'confirmed', 2),
(80, 28, 'Sportkurs', '2025-11-08 17:40:00', '2025-11-08 22:40:00', 'cancelled', 3),
(81, 28, 'Turnier', '2025-10-19 01:42:00', '2025-10-19 06:42:00', 'cancelled', 4),
(82, 28, 'Konzert', '2025-09-30 02:11:00', '2025-09-30 07:11:00', 'unconfirmed', 10),
(83, 22, 'Messe', '2025-10-30 09:05:00', '2025-10-30 15:05:00', 'unconfirmed', 6),
(84, 22, 'Konzert', '2025-11-22 04:48:00', '2025-11-22 09:48:00', 'confirmed', 1),
(85, 30, 'Basketball', '2025-10-14 16:45:00', '2025-10-14 21:45:00', 'unconfirmed', 3),
(86, 29, 'Basketball', '2025-11-26 16:03:00', '2025-11-26 22:03:00', 'cancelled', 1),
(87, 22, 'Gemeindeversammlung', '2025-10-05 16:32:00', '2025-10-05 22:32:00', 'confirmed', 1),
(88, 22, 'Handball', '2025-11-10 06:16:00', '2025-11-10 12:16:00', 'confirmed', 6),
(89, 30, 'Training', '2025-12-20 10:09:00', '2025-12-20 15:09:00', 'confirmed', 6),
(90, 22, 'Flohmarkt', '2025-11-12 17:14:00', '2025-11-12 22:14:00', 'cancelled', 6),
(91, 22, 'Flohmarkt', '2025-11-06 14:41:00', '2025-11-06 19:41:00', 'unconfirmed', 2),
(92, 22, 'Freundschaftsspiel', '2025-10-05 01:53:00', '2025-10-05 06:53:00', 'confirmed', 13),
(93, 28, 'Sportkurs', '2025-10-17 01:28:00', '2025-10-17 06:28:00', 'confirmed', 3),
(94, 29, 'Gemeindeversammlung', '2025-11-04 10:15:00', '2025-11-04 15:15:00', 'cancelled', 14),
(95, 22, 'Freundschaftsspiel', '2025-12-02 13:29:00', '2025-12-02 19:29:00', 'cancelled', 1),
(96, 29, 'Turnier', '2025-11-11 09:47:00', '2025-11-11 14:47:00', 'confirmed', 11),
(97, 28, 'Freundschaftsspiel', '2025-12-09 02:30:00', '2025-12-09 07:30:00', 'cancelled', 2),
(98, 28, 'Tanzkurs', '2025-10-01 03:27:00', '2025-10-01 08:27:00', 'cancelled', 1),
(99, 30, 'Gemeindeversammlung', '2025-10-14 14:49:00', '2025-10-14 19:49:00', 'cancelled', 6),
(100, 30, 'Volleyball', '2025-10-16 07:22:00', '2025-10-16 12:22:00', 'unconfirmed', 7),
(101, 30, 'Vereinsmeisterschaft', '2025-10-08 03:46:00', '2025-10-08 09:46:00', 'confirmed', 2),
(102, 29, 'Basketball', '2025-11-24 10:54:00', '2025-11-24 16:54:00', 'confirmed', 14),
(103, 29, 'Basketball', '2025-09-30 07:29:00', '2025-09-30 13:29:00', 'confirmed', 2),
(104, 22, 'Messe', '2025-10-04 03:46:00', '2025-10-04 09:46:00', 'unconfirmed', 4),
(105, 28, 'Fußballtraining', '2025-11-19 15:16:00', '2025-11-19 20:16:00', 'confirmed', 8),
(106, 30, 'Messe', '2025-12-09 02:48:00', '2025-12-09 08:48:00', 'unconfirmed', 14),
(107, 22, 'Turnier', '2025-10-14 04:50:00', '2025-10-14 10:50:00', 'cancelled', 11),
(108, 30, 'Handball', '2025-11-01 11:51:00', '2025-11-01 17:51:00', 'unconfirmed', 2),
(109, 29, 'Flohmarkt', '2025-10-22 03:12:00', '2025-10-22 08:12:00', 'confirmed', 8),
(110, 30, 'Flohmarkt', '2025-11-15 14:13:00', '2025-11-15 20:13:00', 'cancelled', 13),
(111, 22, 'Konzert', '2025-10-25 17:22:00', '2025-10-25 23:22:00', 'cancelled', 2),
(112, 30, 'Sportkurs', '2025-12-25 15:25:00', '2025-12-25 20:25:00', 'confirmed', 7),
(113, 30, 'Basketball', '2025-11-23 15:34:00', '2025-11-23 21:34:00', 'unconfirmed', 11),
(114, 28, 'Konzert', '2025-11-18 03:21:00', '2025-11-18 09:21:00', 'cancelled', 12),
(115, 30, 'Flohmarkt', '2025-12-14 05:27:00', '2025-12-14 10:27:00', 'cancelled', 11),
(116, 28, 'Freundschaftsspiel', '2025-11-20 11:20:00', '2025-11-20 17:20:00', 'cancelled', 14),
(117, 30, 'Vereinsmeisterschaft', '2025-11-18 09:54:00', '2025-11-18 15:54:00', 'confirmed', 14),
(118, 30, 'Turnier', '2025-11-10 13:04:00', '2025-11-10 19:04:00', 'unconfirmed', 8),
(119, 29, 'Vereinsmeisterschaft', '2025-10-14 15:55:00', '2025-10-14 21:55:00', 'unconfirmed', 13),
(120, 22, 'Sportkurs', '2025-12-09 02:37:00', '2025-12-09 08:37:00', 'confirmed', 9),
(121, 29, 'Volleyball', '2025-10-12 09:56:00', '2025-10-12 15:56:00', 'cancelled', 6),
(122, 22, 'Volleyball', '2025-12-29 11:38:00', '2025-12-29 17:38:00', 'unconfirmed', 11),
(123, 28, 'Turnier', '2025-11-17 06:48:00', '2025-11-17 12:48:00', 'confirmed', 3),
(124, 28, 'Turnier', '2025-11-16 15:54:00', '2025-11-16 21:54:00', 'cancelled', 8),
(125, 28, 'Training', '2025-11-10 17:08:00', '2025-11-10 23:08:00', 'confirmed', 5),
(126, 30, 'Turnier', '2025-10-18 14:51:00', '2025-10-18 20:51:00', 'unconfirmed', 6),
(127, 28, 'Gemeindeversammlung', '2025-12-03 16:20:00', '2025-12-03 21:20:00', 'cancelled', 10),
(128, 22, 'Gemeindeversammlung', '2025-10-10 01:24:00', '2025-10-10 06:24:00', 'confirmed', 11),
(129, 28, 'Sportkurs', '2025-11-09 04:10:00', '2025-11-09 10:10:00', 'unconfirmed', 2),
(130, 30, 'Konzert', '2025-12-15 00:00:00', '2025-12-15 06:00:00', 'unconfirmed', 10),
(131, 22, 'Handball', '2025-11-25 03:37:00', '2025-11-25 08:37:00', 'unconfirmed', 9),
(132, 22, 'Volleyball', '2025-10-08 07:15:00', '2025-10-08 12:15:00', 'unconfirmed', 3),
(133, 22, 'Freundschaftsspiel', '2025-11-27 05:42:00', '2025-11-27 10:42:00', 'confirmed', 6),
(134, 22, 'Tanzkurs', '2025-10-28 13:35:00', '2025-10-28 18:35:00', 'cancelled', 12),
(135, 30, 'Tanzkurs', '2025-12-04 16:15:00', '2025-12-04 22:15:00', 'unconfirmed', 1),
(136, 28, 'Messe', '2025-11-12 04:44:00', '2025-11-12 10:44:00', 'cancelled', 1),
(137, 22, 'Abschlussfeier', '2025-12-17 16:13:00', '2025-12-17 21:13:00', 'unconfirmed', 3),
(138, 22, 'Volleyball', '2025-10-04 15:30:00', '2025-10-04 21:30:00', 'confirmed', 5),
(139, 28, 'Gemeindeversammlung', '2025-12-10 15:13:00', '2025-12-10 20:13:00', 'confirmed', 2),
(140, 30, 'Gemeindeversammlung', '2025-10-05 14:36:00', '2025-10-05 19:36:00', 'confirmed', 14),
(141, 30, 'Vereinsmeisterschaft', '2025-12-31 15:26:00', '2025-12-31 20:26:00', 'cancelled', 5),
(142, 29, 'Training', '2025-11-05 07:39:00', '2025-11-05 12:39:00', 'cancelled', 13),
(143, 29, 'Basketball', '2025-10-11 11:55:00', '2025-10-11 16:55:00', 'confirmed', 10),
(144, 30, 'Flohmarkt', '2025-11-30 02:18:00', '2025-11-30 07:18:00', 'unconfirmed', 10),
(145, 29, 'Sportkurs', '2025-11-20 14:51:00', '2025-11-20 19:51:00', 'unconfirmed', 6),
(146, 22, 'Sportkurs', '2025-11-17 17:51:00', '2025-11-17 23:51:00', 'unconfirmed', 3),
(147, 28, 'Handball', '2025-10-26 12:58:00', '2025-10-26 18:58:00', 'confirmed', 10),
(148, 22, 'Fußballtraining', '2025-11-24 15:19:00', '2025-11-24 21:19:00', 'confirmed', 4),
(149, 22, 'Basketball', '2025-12-27 07:18:00', '2025-12-27 13:18:00', 'cancelled', 5),
(150, 30, 'Sportkurs', '2025-10-23 04:36:00', '2025-10-23 09:36:00', 'confirmed', 4),
(151, 29, 'Flohmarkt', '2025-11-29 08:35:00', '2025-11-29 14:35:00', 'unconfirmed', 11),
(152, 28, 'Training', '2025-10-27 13:21:00', '2025-10-27 19:21:00', 'confirmed', 6),
(153, 29, 'Sportkurs', '2025-12-04 14:52:00', '2025-12-04 19:52:00', 'confirmed', 5),
(154, 30, 'Fußballtraining', '2025-10-15 16:05:00', '2025-10-15 21:05:00', 'confirmed', 3),
(155, 28, 'Konzert', '2025-10-03 06:16:00', '2025-10-03 11:16:00', 'confirmed', 7),
(156, 29, 'Konzert', '2025-10-19 16:21:00', '2025-10-19 22:21:00', 'cancelled', 14),
(157, 29, 'Handball', '2025-12-11 11:22:00', '2025-12-11 16:22:00', 'confirmed', 6),
(158, 29, 'Training', '2025-10-04 12:54:00', '2025-10-04 18:54:00', 'confirmed', 9),
(159, 30, 'Tanzkurs', '2026-01-01 14:47:00', '2026-01-01 20:47:00', 'unconfirmed', 3),
(160, 22, 'Sportkurs', '2025-10-10 07:50:00', '2025-10-10 13:50:00', 'confirmed', 10),
(161, 22, 'Abschlussfeier', '2025-10-01 10:34:00', '2025-10-01 16:34:00', 'cancelled', 4),
(162, 22, 'Gemeindeversammlung', '2025-12-08 10:42:00', '2025-12-08 16:42:00', 'unconfirmed', 8),
(163, 28, 'Training', '2025-10-07 12:36:00', '2025-10-07 18:36:00', 'unconfirmed', 13),
(164, 28, 'Freundschaftsspiel', '2025-12-31 01:42:00', '2025-12-31 06:42:00', 'cancelled', 8),
(165, 22, 'Sportkurs', '2025-10-23 15:23:00', '2025-10-23 21:23:00', 'cancelled', 12),
(166, 28, 'Konzert', '2025-12-24 15:22:00', '2025-12-24 21:22:00', 'confirmed', 1),
(167, 30, 'Sportkurs', '2025-10-20 04:06:00', '2025-10-20 10:06:00', 'confirmed', 12),
(168, 22, 'Fußballtraining', '2025-11-25 07:20:00', '2025-11-25 12:20:00', 'cancelled', 5),
(169, 30, 'Fußballtraining', '2025-10-08 16:20:00', '2025-10-08 21:20:00', 'cancelled', 4),
(170, 30, 'Sportkurs', '2025-12-13 07:40:00', '2025-12-13 13:40:00', 'unconfirmed', 12),
(171, 30, 'Training', '2025-10-12 16:14:00', '2025-10-12 21:14:00', 'confirmed', 4),
(172, 30, 'Konzert', '2025-11-02 12:50:00', '2025-11-02 17:50:00', 'unconfirmed', 4),
(173, 30, 'Messe', '2025-12-03 12:17:00', '2025-12-03 17:17:00', 'cancelled', 2),
(174, 28, 'Turnier', '2025-11-23 14:18:00', '2025-11-23 20:18:00', 'confirmed', 3),
(175, 22, 'Sportkurs', '2025-12-26 17:25:00', '2025-12-26 22:25:00', 'confirmed', 12),
(176, 29, 'Gemeindeversammlung', '2025-10-17 10:58:00', '2025-10-17 16:58:00', 'confirmed', 1),
(177, 28, 'Konzert', '2025-11-30 07:42:00', '2025-11-30 13:42:00', 'cancelled', 3),
(178, 22, 'Training', '2025-10-30 07:14:00', '2025-10-30 13:14:00', 'confirmed', 2),
(179, 29, 'Abschlussfeier', '2025-12-23 17:45:00', '2025-12-23 23:45:00', 'unconfirmed', 11),
(180, 22, 'Konzert', '2025-11-25 00:22:00', '2025-11-25 06:22:00', 'confirmed', 8),
(181, 29, 'Sportkurs', '2025-12-21 01:23:00', '2025-12-21 06:23:00', 'unconfirmed', 7),
(182, 29, 'Basketball', '2025-10-03 10:07:00', '2025-10-03 16:07:00', 'unconfirmed', 6),
(183, 22, 'Gemeindeversammlung', '2025-10-17 06:08:00', '2025-10-17 11:08:00', 'unconfirmed', 8),
(184, 22, 'Sportkurs', '2025-11-02 13:00:00', '2025-11-02 18:00:00', 'confirmed', 7),
(185, 22, 'Basketball', '2025-11-17 08:44:00', '2025-11-17 13:44:00', 'cancelled', 8),
(186, 28, 'Fußballtraining', '2025-12-14 05:56:00', '2025-12-14 10:56:00', 'confirmed', 5),
(187, 22, 'Flohmarkt', '2025-10-16 01:36:00', '2025-10-16 07:36:00', 'unconfirmed', 3),
(188, 29, 'Fußballtraining', '2025-10-14 02:18:00', '2025-10-14 07:18:00', 'unconfirmed', 9),
(189, 30, 'Messe', '2025-10-28 15:27:00', '2025-10-28 20:27:00', 'confirmed', 7),
(190, 29, 'Basketball', '2025-12-04 12:59:00', '2025-12-04 18:59:00', 'confirmed', 7),
(191, 28, 'Freundschaftsspiel', '2025-11-06 01:31:00', '2025-11-06 07:31:00', 'cancelled', 1),
(192, 29, 'Freundschaftsspiel', '2025-12-12 02:39:00', '2025-12-12 07:39:00', 'cancelled', 7),
(193, 30, 'Sportkurs', '2025-12-11 05:19:00', '2025-12-11 10:19:00', 'confirmed', 9),
(194, 22, 'Messe', '2025-11-22 00:27:00', '2025-11-22 05:27:00', 'confirmed', 12),
(195, 22, 'Messe', '2025-12-26 03:31:00', '2025-12-26 08:31:00', 'confirmed', 7),
(196, 22, 'Sportkurs', '2025-11-21 10:31:00', '2025-11-21 15:31:00', 'unconfirmed', 6),
(197, 30, 'Tanzkurs', '2025-10-25 03:26:00', '2025-10-25 09:26:00', 'unconfirmed', 7),
(198, 30, 'Tanzkurs', '2025-11-18 03:37:00', '2025-11-18 09:37:00', 'confirmed', 2),
(199, 30, 'Fußballtraining', '2025-12-18 17:56:00', '2025-12-18 23:56:00', 'cancelled', 4),
(200, 22, 'Fußballtraining', '2025-10-08 02:57:00', '2025-10-08 07:57:00', 'unconfirmed', 12),
(201, 30, 'Flohmarkt', '2025-12-21 10:07:00', '2025-12-21 15:07:00', 'confirmed', 6),
(202, 28, 'Fußballtraining', '2025-11-22 11:47:00', '2025-11-22 16:47:00', 'unconfirmed', 12),
(203, 22, 'Tanzkurs', '2025-12-16 16:54:00', '2025-12-16 22:54:00', 'cancelled', 14),
(204, 29, 'Gemeindeversammlung', '2025-12-18 10:52:00', '2025-12-18 15:52:00', 'confirmed', 4),
(205, 29, 'Vereinsmeisterschaft', '2025-11-22 02:29:00', '2025-11-22 07:29:00', 'unconfirmed', 7),
(206, 29, 'Turnier', '2025-11-02 04:40:00', '2025-11-02 09:40:00', 'confirmed', 11),
(207, 30, 'Basketball', '2025-10-20 04:27:00', '2025-10-20 10:27:00', 'unconfirmed', 7),
(208, 22, 'Messe', '2025-10-01 14:24:00', '2025-10-01 20:24:00', 'confirmed', 11),
(209, 28, 'Turnier', '2025-12-29 17:42:00', '2025-12-29 22:42:00', 'cancelled', 14),
(210, 29, 'Sportkurs', '2025-11-18 00:04:00', '2025-11-18 06:04:00', 'cancelled', 3),
(211, 28, 'Basketball', '2025-10-11 00:00:00', '2025-10-11 05:00:00', 'cancelled', 3),
(212, 28, 'Handball', '2025-10-09 00:53:00', '2025-10-09 06:53:00', 'confirmed', 6),
(213, 30, 'Fußballtraining', '2025-10-07 14:45:00', '2025-10-07 19:45:00', 'unconfirmed', 10),
(214, 30, 'Sportkurs', '2025-10-02 08:03:00', '2025-10-02 14:03:00', 'confirmed', 5),
(215, 28, 'Volleyball', '2025-12-25 16:01:00', '2025-12-25 22:01:00', 'unconfirmed', 12),
(216, 28, 'Messe', '2025-12-26 03:58:00', '2025-12-26 08:58:00', 'cancelled', 12),
(217, 22, 'Volleyball', '2025-12-13 03:14:00', '2025-12-13 09:14:00', 'confirmed', 2),
(218, 28, 'Tanzkurs', '2025-10-11 14:52:00', '2025-10-11 19:52:00', 'unconfirmed', 8),
(219, 30, 'Vereinsmeisterschaft', '2025-10-07 14:39:00', '2025-10-07 20:39:00', 'unconfirmed', 9),
(220, 29, 'Abschlussfeier', '2025-12-23 03:49:00', '2025-12-23 09:49:00', 'confirmed', 3),
(221, 30, 'Freundschaftsspiel', '2025-10-22 06:44:00', '2025-10-22 12:44:00', 'cancelled', 1),
(222, 28, 'Basketball', '2025-12-13 08:25:00', '2025-12-13 13:25:00', 'unconfirmed', 6),
(223, 22, 'Gemeindeversammlung', '2025-11-30 17:40:00', '2025-11-30 23:40:00', 'cancelled', 2),
(224, 29, 'Turnier', '2025-12-02 06:41:00', '2025-12-02 12:41:00', 'unconfirmed', 8),
(225, 30, 'Volleyball', '2025-12-20 06:49:00', '2025-12-20 11:49:00', 'cancelled', 3),
(226, 22, 'Handball', '2025-10-03 11:45:00', '2025-10-03 16:45:00', 'unconfirmed', 7),
(227, 22, 'Vereinsmeisterschaft', '2025-10-28 07:58:00', '2025-10-28 12:58:00', 'confirmed', 1),
(228, 29, 'Handball', '2025-12-24 17:36:00', '2025-12-24 22:36:00', 'confirmed', 4),
(229, 22, 'Volleyball', '2025-12-02 01:32:00', '2025-12-02 06:32:00', 'confirmed', 5),
(230, 22, 'Basketball', '2025-11-30 06:55:00', '2025-11-30 11:55:00', 'unconfirmed', 9),
(231, 28, 'Konzert', '2025-10-21 04:32:00', '2025-10-21 09:32:00', 'unconfirmed', 5),
(232, 22, 'Freundschaftsspiel', '2025-10-03 05:41:00', '2025-10-03 10:41:00', 'unconfirmed', 10),
(233, 22, 'Konzert', '2025-10-15 06:46:00', '2025-10-15 11:46:00', 'confirmed', 8),
(234, 30, 'Turnier', '2025-12-15 01:51:00', '2025-12-15 07:51:00', 'unconfirmed', 9),
(235, 28, 'Training', '2025-12-31 03:20:00', '2025-12-31 08:20:00', 'cancelled', 10),
(236, 22, 'Abschlussfeier', '2025-12-10 02:11:00', '2025-12-10 08:11:00', 'cancelled', 9),
(237, 28, 'Basketball', '2025-11-07 04:57:00', '2025-11-07 09:57:00', 'confirmed', 5),
(238, 30, 'Fußballtraining', '2025-10-02 13:27:00', '2025-10-02 19:27:00', 'cancelled', 13),
(239, 22, 'Flohmarkt', '2025-10-02 05:57:00', '2025-10-02 11:57:00', 'confirmed', 4),
(240, 22, 'Training', '2025-12-31 02:28:00', '2025-12-31 08:28:00', 'unconfirmed', 2),
(241, 29, 'Training', '2025-10-31 13:00:00', '2025-10-31 18:00:00', 'unconfirmed', 2),
(242, 22, 'Fußballtraining', '2025-10-11 02:51:00', '2025-10-11 08:51:00', 'cancelled', 7),
(243, 29, 'Handball', '2025-11-08 12:16:00', '2025-11-08 18:16:00', 'unconfirmed', 13),
(244, 28, 'Basketball', '2025-11-27 14:31:00', '2025-11-27 20:31:00', 'cancelled', 9),
(245, 29, 'Tanzkurs', '2025-12-05 04:57:00', '2025-12-05 10:57:00', 'unconfirmed', 13),
(246, 30, 'Basketball', '2025-12-09 12:01:00', '2025-12-09 18:01:00', 'confirmed', 5),
(247, 29, 'Flohmarkt', '2025-11-05 09:22:00', '2025-11-05 14:22:00', 'confirmed', 3),
(248, 22, 'Fußballtraining', '2025-11-11 16:02:00', '2025-11-11 22:02:00', 'cancelled', 3),
(249, 30, 'Tanzkurs', '2025-12-14 04:36:00', '2025-12-14 10:36:00', 'cancelled', 12),
(250, 30, 'Freundschaftsspiel', '2025-12-13 11:20:00', '2025-12-13 16:20:00', 'confirmed', 1),
(251, 28, 'Abschlussfeier', '2025-12-15 16:54:00', '2025-12-15 22:54:00', 'unconfirmed', 2),
(252, 29, 'Handball', '2025-11-21 01:41:00', '2025-11-21 06:41:00', 'cancelled', 10),
(253, 28, 'Gemeindeversammlung', '2025-10-16 01:14:00', '2025-10-16 06:14:00', 'unconfirmed', 14),
(254, 28, 'Vereinsmeisterschaft', '2025-11-08 05:57:00', '2025-11-08 11:57:00', 'unconfirmed', 5),
(255, 22, 'Turnier', '2025-12-28 06:55:00', '2025-12-28 11:55:00', 'unconfirmed', 11),
(256, 30, 'Handball', '2025-12-19 14:40:00', '2025-12-19 19:40:00', 'confirmed', 14),
(257, 30, 'Sportkurs', '2025-10-07 03:45:00', '2025-10-07 08:45:00', 'cancelled', 10),
(258, 29, 'Abschlussfeier', '2025-11-18 17:51:00', '2025-11-18 23:51:00', 'unconfirmed', 13),
(259, 28, 'Messe', '2025-11-03 15:13:00', '2025-11-03 20:13:00', 'confirmed', 10),
(260, 29, 'Sportkurs', '2025-12-10 13:48:00', '2025-12-10 19:48:00', 'unconfirmed', 9),
(261, 30, 'Fußballtraining', '2025-10-08 13:00:00', '2025-10-08 19:00:00', 'cancelled', 2),
(262, 28, 'Konzert', '2025-12-12 03:09:00', '2025-12-12 08:09:00', 'unconfirmed', 10),
(263, 29, 'Volleyball', '2025-12-01 08:37:00', '2025-12-01 13:37:00', 'cancelled', 6),
(264, 30, 'Turnier', '2025-11-16 03:53:00', '2025-11-16 09:53:00', 'cancelled', 12),
(265, 30, 'Sportkurs', '2025-10-31 17:46:00', '2025-10-31 22:46:00', 'cancelled', 11),
(266, 29, 'Vereinsmeisterschaft', '2025-11-08 16:33:00', '2025-11-08 21:33:00', 'unconfirmed', 9),
(267, 29, 'Abschlussfeier', '2025-12-07 04:02:00', '2025-12-07 09:02:00', 'cancelled', 1),
(268, 28, 'Messe', '2025-12-02 17:17:00', '2025-12-02 23:17:00', 'unconfirmed', 6),
(269, 22, 'Vereinsmeisterschaft', '2025-10-21 17:52:00', '2025-10-21 22:52:00', 'cancelled', 9),
(270, 28, 'Sportkurs', '2025-10-03 07:21:00', '2025-10-03 13:21:00', 'cancelled', 14),
(271, 28, 'Handball', '2025-10-23 03:37:00', '2025-10-23 08:37:00', 'unconfirmed', 5),
(272, 28, 'Konzert', '2025-11-12 15:30:00', '2025-11-12 21:30:00', 'confirmed', 12),
(273, 28, 'Flohmarkt', '2025-11-06 16:59:00', '2025-11-06 22:59:00', 'cancelled', 1),
(274, 28, 'Messe', '2025-10-20 10:51:00', '2025-10-20 16:51:00', 'unconfirmed', 5),
(275, 30, 'Basketball', '2025-12-07 09:36:00', '2025-12-07 14:36:00', 'cancelled', 9),
(276, 22, 'Freundschaftsspiel', '2025-10-07 06:14:00', '2025-10-07 11:14:00', 'confirmed', 6),
(277, 30, 'Freundschaftsspiel', '2025-12-15 12:05:00', '2025-12-15 17:05:00', 'cancelled', 11),
(278, 29, 'Tanzkurs', '2025-10-06 12:41:00', '2025-10-06 18:41:00', 'cancelled', 4),
(279, 30, 'Sportkurs', '2025-10-04 08:17:00', '2025-10-04 13:17:00', 'cancelled', 11),
(280, 28, 'Messe', '2025-11-10 14:47:00', '2025-11-10 19:47:00', 'unconfirmed', 2),
(281, 30, 'Vereinsmeisterschaft', '2025-10-21 05:45:00', '2025-10-21 11:45:00', 'confirmed', 10),
(282, 28, 'Fußballtraining', '2025-12-12 00:27:00', '2025-12-12 05:27:00', 'cancelled', 5),
(283, 30, 'Flohmarkt', '2025-11-04 01:02:00', '2025-11-04 06:02:00', 'cancelled', 10),
(284, 30, 'Abschlussfeier', '2025-10-31 10:06:00', '2025-10-31 15:06:00', 'confirmed', 3),
(285, 29, 'Basketball', '2025-10-30 04:41:00', '2025-10-30 10:41:00', 'confirmed', 9),
(286, 22, 'Handball', '2025-12-06 14:21:00', '2025-12-06 19:21:00', 'confirmed', 12),
(287, 30, 'Basketball', '2025-11-30 03:57:00', '2025-11-30 09:57:00', 'cancelled', 11),
(288, 30, 'Sportkurs', '2025-11-25 11:36:00', '2025-11-25 17:36:00', 'confirmed', 12),
(289, 28, 'Sportkurs', '2025-10-13 15:55:00', '2025-10-13 20:55:00', 'unconfirmed', 11),
(290, 30, 'Vereinsmeisterschaft', '2025-10-16 01:47:00', '2025-10-16 06:47:00', 'cancelled', 12),
(291, 28, 'Turnier', '2025-12-27 17:36:00', '2025-12-27 23:36:00', 'cancelled', 7),
(292, 28, 'Volleyball', '2025-10-09 01:47:00', '2025-10-09 07:47:00', 'confirmed', 3),
(293, 28, 'Turnier', '2025-10-10 15:53:00', '2025-10-10 21:53:00', 'unconfirmed', 12),
(294, 30, 'Handball', '2025-10-26 05:41:00', '2025-10-26 11:41:00', 'confirmed', 2),
(295, 29, 'Freundschaftsspiel', '2025-11-06 11:05:00', '2025-11-06 17:05:00', 'unconfirmed', 9),
(296, 30, 'Konzert', '2025-11-13 08:13:00', '2025-11-13 13:13:00', 'cancelled', 9),
(297, 28, 'Vereinsmeisterschaft', '2025-10-28 06:13:00', '2025-10-28 12:13:00', 'unconfirmed', 11),
(298, 30, 'Turnier', '2025-10-06 00:43:00', '2025-10-06 05:43:00', 'cancelled', 4),
(299, 29, 'Fußballtraining', '2025-10-15 13:30:00', '2025-10-15 18:30:00', 'unconfirmed', 13),
(300, 22, 'Freundschaftsspiel', '2025-12-16 08:28:00', '2025-12-16 14:28:00', 'unconfirmed', 9),
(301, 22, 'Abschlussfeier', '2025-10-12 12:17:00', '2025-10-12 17:17:00', 'unconfirmed', 5),
(302, 30, 'Training', '2025-12-25 07:37:00', '2025-12-25 13:37:00', 'confirmed', 10),
(303, 22, 'Messe', '2025-11-12 07:02:00', '2025-11-12 12:02:00', 'confirmed', 11),
(304, 30, 'Basketball', '2025-11-26 02:11:00', '2025-11-26 08:11:00', 'cancelled', 3),
(305, 28, 'Handball', '2025-10-18 17:09:00', '2025-10-18 23:09:00', 'unconfirmed', 3),
(306, 28, 'Flohmarkt', '2025-12-09 08:13:00', '2025-12-09 13:13:00', 'confirmed', 4),
(307, 28, 'Vereinsmeisterschaft', '2025-11-03 04:49:00', '2025-11-03 09:49:00', 'cancelled', 3),
(308, 28, 'Turnier', '2025-11-23 10:53:00', '2025-11-23 15:53:00', 'unconfirmed', 12),
(309, 30, 'Turnier', '2025-10-11 16:19:00', '2025-10-11 21:19:00', 'confirmed', 9),
(310, 29, 'Konzert', '2025-11-12 02:22:00', '2025-11-12 07:22:00', 'cancelled', 14),
(311, 29, 'Turnier', '2025-12-08 12:27:00', '2025-12-08 18:27:00', 'confirmed', 12),
(312, 30, 'Konzert', '2025-10-04 12:27:00', '2025-10-04 18:27:00', 'cancelled', 4),
(313, 28, 'Vereinsmeisterschaft', '2025-12-25 08:58:00', '2025-12-25 14:58:00', 'unconfirmed', 8),
(314, 28, 'Tanzkurs', '2025-10-18 02:46:00', '2025-10-18 08:46:00', 'unconfirmed', 8),
(315, 22, 'Vereinsmeisterschaft', '2025-12-03 15:17:00', '2025-12-03 21:17:00', 'cancelled', 12),
(316, 30, 'Freundschaftsspiel', '2025-09-30 01:50:00', '2025-09-30 07:50:00', 'confirmed', 7),
(317, 22, 'Konzert', '2025-12-22 00:28:00', '2025-12-22 06:28:00', 'unconfirmed', 12),
(318, 29, 'Flohmarkt', '2025-10-01 15:31:00', '2025-10-01 21:31:00', 'cancelled', 7),
(319, 30, 'Flohmarkt', '2025-10-15 16:06:00', '2025-10-15 21:06:00', 'unconfirmed', 14),
(321, 28, 'Tanzkurs', '2025-10-28 03:22:00', '2025-10-28 08:22:00', 'confirmed', 12),
(322, 29, 'Messe', '2025-10-12 04:25:00', '2025-10-12 10:25:00', 'unconfirmed', 10),
(323, 28, 'Konzert', '2025-12-31 17:43:00', '2025-12-31 22:43:00', 'unconfirmed', 8),
(324, 30, 'Volleyball', '2025-11-05 06:51:00', '2025-11-05 12:51:00', 'confirmed', 2),
(325, 30, 'Gemeindeversammlung', '2025-11-14 01:04:00', '2025-11-14 06:04:00', 'cancelled', 3),
(326, 28, 'Basketball', '2025-10-29 17:28:00', '2025-10-29 23:28:00', 'unconfirmed', 10),
(327, 28, 'Turnier', '2025-11-10 01:33:00', '2025-11-10 06:33:00', 'confirmed', 3),
(328, 30, 'Sportkurs', '2025-10-09 09:59:00', '2025-10-09 14:59:00', 'confirmed', 4),
(329, 28, 'Sportkurs', '2025-12-05 12:26:00', '2025-12-05 17:26:00', 'confirmed', 6),
(330, 30, 'Turnier', '2025-10-03 08:39:00', '2025-10-03 14:39:00', 'unconfirmed', 2),
(331, 29, 'Turnier', '2025-11-04 06:02:00', '2025-11-04 12:02:00', 'cancelled', 8),
(332, 30, 'Abschlussfeier', '2026-01-01 09:52:00', '2026-01-01 14:52:00', 'unconfirmed', 8),
(333, 22, 'Konzert', '2025-11-29 14:03:00', '2025-11-29 20:03:00', 'confirmed', 5),
(334, 28, 'Turnier', '2025-11-07 00:03:00', '2025-11-07 05:03:00', 'confirmed', 9),
(335, 30, 'Freundschaftsspiel', '2025-10-13 03:24:00', '2025-10-13 08:24:00', 'unconfirmed', 12),
(336, 22, 'Abschlussfeier', '2025-11-09 07:31:00', '2025-11-09 12:31:00', 'confirmed', 10),
(337, 30, 'Fußballtraining', '2025-10-24 02:16:00', '2025-10-24 07:16:00', 'unconfirmed', 10),
(338, 30, 'Messe', '2025-10-08 03:36:00', '2025-10-08 08:36:00', 'cancelled', 9),
(339, 22, 'Vereinsmeisterschaft', '2025-10-20 02:37:00', '2025-10-20 07:37:00', 'confirmed', 9),
(340, 22, 'Handball', '2025-12-26 06:17:00', '2025-12-26 12:17:00', 'confirmed', 4),
(341, 30, 'Sportkurs', '2025-11-15 06:30:00', '2025-11-15 12:30:00', 'unconfirmed', 3),
(342, 28, 'Tanzkurs', '2025-10-09 11:36:00', '2025-10-09 16:36:00', 'cancelled', 11),
(343, 28, 'Fußballtraining', '2025-10-26 00:45:00', '2025-10-26 06:45:00', 'cancelled', 13),
(344, 30, 'Messe', '2025-11-05 06:31:00', '2025-11-05 11:31:00', 'unconfirmed', 5),
(345, 28, 'Turnier', '2025-12-19 12:45:00', '2025-12-19 18:45:00', 'confirmed', 2),
(346, 30, 'Fußballtraining', '2025-12-27 02:06:00', '2025-12-27 07:06:00', 'cancelled', 2),
(347, 29, 'Basketball', '2025-12-08 11:00:00', '2025-12-08 16:00:00', 'cancelled', 4),
(348, 28, 'Sportkurs', '2025-11-12 13:10:00', '2025-11-12 18:10:00', 'unconfirmed', 4),
(349, 28, 'Volleyball', '2025-12-18 15:18:00', '2025-12-18 20:18:00', 'confirmed', 12),
(350, 29, 'Vereinsmeisterschaft', '2025-11-01 13:30:00', '2025-11-01 18:30:00', 'confirmed', 11),
(351, 30, 'Sportkurs', '2025-12-08 10:16:00', '2025-12-08 15:16:00', 'confirmed', 14),
(352, 29, 'Turnier', '2025-11-20 02:36:00', '2025-11-20 07:36:00', 'cancelled', 13),
(353, 30, 'Vereinsmeisterschaft', '2025-12-14 17:23:00', '2025-12-14 23:23:00', 'confirmed', 3),
(354, 29, 'Flohmarkt', '2025-11-29 12:39:00', '2025-11-29 18:39:00', 'confirmed', 7),
(355, 29, 'Tanzkurs', '2025-10-25 07:36:00', '2025-10-25 13:36:00', 'cancelled', 8),
(356, 28, 'Vereinsmeisterschaft', '2025-11-28 17:16:00', '2025-11-28 23:16:00', 'unconfirmed', 7),
(357, 29, 'Konzert', '2025-11-06 07:35:00', '2025-11-06 13:35:00', 'unconfirmed', 6),
(358, 28, 'Volleyball', '2025-11-23 04:29:00', '2025-11-23 10:29:00', 'confirmed', 10),
(359, 28, 'Vereinsmeisterschaft', '2025-10-12 03:46:00', '2025-10-12 08:46:00', 'unconfirmed', 1),
(360, 30, 'Tanzkurs', '2025-12-11 04:18:00', '2025-12-11 10:18:00', 'confirmed', 1),
(361, 29, 'Fußballtraining', '2025-10-08 02:32:00', '2025-10-08 07:32:00', 'cancelled', 6),
(362, 29, 'Messe', '2025-11-21 08:48:00', '2025-11-21 14:48:00', 'unconfirmed', 1),
(363, 28, 'Handball', '2025-12-10 08:58:00', '2025-12-10 13:58:00', 'confirmed', 7),
(364, 30, 'Fußballtraining', '2025-11-27 04:32:00', '2025-11-27 09:32:00', 'confirmed', 11),
(365, 30, 'Freundschaftsspiel', '2025-10-21 01:54:00', '2025-10-21 07:54:00', 'cancelled', 9),
(366, 28, 'Basketball', '2026-01-01 05:45:00', '2026-01-01 10:45:00', 'cancelled', 9),
(367, 22, 'Fußballtraining', '2025-11-09 09:54:00', '2025-11-09 14:54:00', 'unconfirmed', 7),
(368, 28, 'Basketball', '2025-10-01 14:37:00', '2025-10-01 20:37:00', 'unconfirmed', 2),
(369, 29, 'Volleyball', '2025-12-17 15:48:00', '2025-12-17 20:48:00', 'cancelled', 10),
(370, 30, 'Fußballtraining', '2025-12-22 08:54:00', '2025-12-22 13:54:00', 'cancelled', 7),
(371, 22, 'Messe', '2025-10-01 10:18:00', '2025-10-01 15:18:00', 'cancelled', 10),
(372, 28, 'Freundschaftsspiel', '2025-12-23 02:35:00', '2025-12-23 08:35:00', 'cancelled', 5),
(373, 28, 'Fußballtraining', '2025-12-28 06:33:00', '2025-12-28 12:33:00', 'cancelled', 8),
(374, 29, 'Basketball', '2025-09-30 06:02:00', '2025-09-30 11:02:00', 'confirmed', 5),
(375, 30, 'Basketball', '2025-11-26 07:03:00', '2025-11-26 12:03:00', 'unconfirmed', 12),
(376, 28, 'Basketball', '2025-10-06 15:19:00', '2025-10-06 20:19:00', 'confirmed', 11),
(377, 30, 'Fußballtraining', '2025-12-13 00:36:00', '2025-12-13 06:36:00', 'unconfirmed', 3),
(378, 29, 'Messe', '2025-10-06 10:45:00', '2025-10-06 15:45:00', 'unconfirmed', 8),
(379, 22, 'Messe', '2026-01-01 09:24:00', '2026-01-01 15:24:00', 'confirmed', 14),
(380, 28, 'Konzert', '2025-10-19 02:53:00', '2025-10-19 07:53:00', 'cancelled', 13),
(381, 29, 'Fußballtraining', '2025-10-27 03:37:00', '2025-10-27 09:37:00', 'confirmed', 8),
(382, 22, 'Sportkurs', '2025-10-09 02:00:00', '2025-10-09 07:00:00', 'cancelled', 2),
(383, 30, 'Gemeindeversammlung', '2025-12-04 04:33:00', '2025-12-04 10:33:00', 'cancelled', 5),
(384, 22, 'Vereinsmeisterschaft', '2025-11-05 02:09:00', '2025-11-05 07:09:00', 'cancelled', 4),
(385, 22, 'Messe', '2025-12-06 02:10:00', '2025-12-06 08:10:00', 'cancelled', 5),
(386, 30, 'Fußballtraining', '2025-12-12 13:22:00', '2025-12-12 18:22:00', 'confirmed', 13),
(387, 30, 'Volleyball', '2025-10-10 11:55:00', '2025-10-10 16:55:00', 'cancelled', 6),
(388, 30, 'Konzert', '2025-12-20 16:49:00', '2025-12-20 21:49:00', 'confirmed', 14),
(389, 30, 'Tanzkurs', '2025-11-27 12:29:00', '2025-11-27 17:29:00', 'cancelled', 4),
(390, 29, 'Flohmarkt', '2025-11-23 03:14:00', '2025-11-23 09:14:00', 'cancelled', 13),
(391, 22, 'Gemeindeversammlung', '2025-10-14 10:40:00', '2025-10-14 16:40:00', 'confirmed', 7),
(392, 29, 'Sportkurs', '2026-01-01 15:51:00', '2026-01-01 21:51:00', 'unconfirmed', 1),
(393, 28, 'Volleyball', '2025-10-31 06:36:00', '2025-10-31 11:36:00', 'unconfirmed', 2),
(394, 29, 'Turnier', '2025-10-13 11:44:00', '2025-10-13 17:44:00', 'confirmed', 8),
(395, 30, 'Gemeindeversammlung', '2025-10-14 07:38:00', '2025-10-14 12:38:00', 'confirmed', 6),
(396, 28, 'Flohmarkt', '2025-12-26 11:33:00', '2025-12-26 16:33:00', 'cancelled', 7),
(397, 28, 'Gemeindeversammlung', '2025-11-06 10:07:00', '2025-11-06 15:07:00', 'cancelled', 14),
(398, 28, 'Training', '2025-12-06 06:10:00', '2025-12-06 11:10:00', 'cancelled', 13),
(399, 28, 'Fußballtraining', '2025-12-24 07:01:00', '2025-12-24 12:01:00', 'cancelled', 4),
(400, 29, 'Tanzkurs', '2025-11-13 04:06:00', '2025-11-13 09:06:00', 'cancelled', 4),
(401, 28, 'Flohmarkt', '2025-12-21 04:34:00', '2025-12-21 10:34:00', 'cancelled', 14),
(402, 22, 'Turnier', '2025-12-28 12:25:00', '2025-12-28 18:25:00', 'cancelled', 9),
(403, 30, 'Sportkurs', '2025-10-21 01:01:00', '2025-10-21 06:01:00', 'cancelled', 1),
(404, 22, 'Flohmarkt', '2025-12-13 17:26:00', '2025-12-13 23:26:00', 'cancelled', 1),
(405, 22, 'Freundschaftsspiel', '2025-12-11 10:13:00', '2025-12-11 15:13:00', 'confirmed', 8),
(406, 22, 'Training', '2025-12-15 10:47:00', '2025-12-15 16:47:00', 'unconfirmed', 9),
(407, 29, 'Messe', '2025-12-19 16:12:00', '2025-12-19 22:12:00', 'unconfirmed', 8),
(408, 30, 'Handball', '2025-11-10 12:16:00', '2025-11-10 18:16:00', 'confirmed', 14),
(409, 29, 'Tanzkurs', '2025-12-11 14:09:00', '2025-12-11 19:09:00', 'unconfirmed', 11),
(410, 22, 'Vereinsmeisterschaft', '2025-12-13 07:42:00', '2025-12-13 12:42:00', 'unconfirmed', 13);

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
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `mieter`
--
ALTER TABLE `mieter`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `termin`
--
ALTER TABLE `termin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=411;

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
