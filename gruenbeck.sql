-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Erstellungszeit: 27. Jan 2017 um 00:34
-- Server-Version: 5.7.17-0ubuntu0.16.04.1
-- PHP-Version: 7.0.8-0ubuntu0.16.04.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `smarthome`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `gruenbeck`
--

CREATE TABLE `gruenbeck` (
  `updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `current_flow` double NOT NULL,
  `capacity_remain` double NOT NULL,
  `regeneration_percent` int(11) NOT NULL,
  `regeneration_step` int(11) NOT NULL,
  `water_consumption` int(11) NOT NULL,
  `capacity_full` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `gruenbeck`
--
ALTER TABLE `gruenbeck`
  ADD PRIMARY KEY (`updated`),
  ADD UNIQUE KEY `updated` (`updated`),
  ADD UNIQUE KEY `updated_2` (`updated`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
