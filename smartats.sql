-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 14 mai 2025 à 20:10
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `smartats`
--

-- --------------------------------------------------------

--
-- Structure de la table `administrator`
--

CREATE TABLE `administrator` (
  `adminRef` varchar(255) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Privilege` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `administrator`
--

INSERT INTO `administrator` (`adminRef`, `FirstName`, `LastName`, `Email`, `Password`, `Privilege`) VALUES
('ADMIN-1743180595337', 'Cedric', 'Ananga Ngoko', 'ancedric55@gmail.com', '13Aout1994', 'superadmin');

-- --------------------------------------------------------

--
-- Structure de la table `participants`
--

CREATE TABLE `participants` (
  `partRef` varchar(255) NOT NULL,
  `UserRef` varchar(255) NOT NULL,
  `SessionRef` varchar(255) NOT NULL,
  `ComingTime` varchar(255) NOT NULL,
  `QuitTime` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `schedule`
--

CREATE TABLE `schedule` (
  `schedRef` varchar(255) NOT NULL,
  `SessionRef` varchar(255) NOT NULL,
  `SesionName` varchar(255) NOT NULL,
  `SessionDate` varchar(255) NOT NULL,
  `SessionStart` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `sessionRef` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `startTime` varchar(255) NOT NULL,
  `endTime` varchar(255) NOT NULL,
  `sessionDate` varchar(255) NOT NULL,
  `nbParticipant` int(11) NOT NULL,
  `sessionState` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`sessionRef`, `name`, `startTime`, `endTime`, `sessionDate`, `nbParticipant`, `sessionState`) VALUES
('2025A03648', 'Seminary', '10', '', '03/avril/2025', 0, 'open'),
('2025A03670', 'Brainstorming', '11', '', '03/avril/2025', 0, 'open'),
('2025M14603', 'General Meeting', '10', '', '14/mai/2025', 0, 'open'),
('2025M14637', 'General Meeting', '10', '', '14/mai/2025', 0, 'open'),
('2025M14658', 'General Meeting', '10', '', '14/mai/2025', 0, 'open'),
('2025M14699', 'General Meeting', '11', '', '14/mai/2025', 0, 'open'),
('2025M14762', 'General Meeting', '12', '', '14/mai/2025', 0, 'open'),
('2025M14871', 'Brainstorming', '14', '', '14/mai/2025', 0, 'open');

-- --------------------------------------------------------

--
-- Structure de la table `sessiontype`
--

CREATE TABLE `sessiontype` (
  `typeRef` varchar(50) NOT NULL,
  `TypeName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `sessiontype`
--

INSERT INTO `sessiontype` (`typeRef`, `TypeName`) VALUES
('TYPE-001', 'General Meeting'),
('TYPE-002', 'Brainstorming'),
('TYPE-003', 'Seminary'),
('TYpe-004', 'Training Session');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `userRef` varchar(255) NOT NULL,
  `firstName` varchar(255) NOT NULL,
  `lastName` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`adminRef`);

--
-- Index pour la table `participants`
--
ALTER TABLE `participants`
  ADD PRIMARY KEY (`partRef`);

--
-- Index pour la table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedRef`);

--
-- Index pour la table `sessiontype`
--
ALTER TABLE `sessiontype`
  ADD PRIMARY KEY (`typeRef`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userRef`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
