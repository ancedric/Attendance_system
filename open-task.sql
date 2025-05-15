-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 14 mai 2025 à 17:15
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
-- Base de données : `open-task`
--

-- --------------------------------------------------------

--
-- Structure de la table `assignment`
--

CREATE TABLE `assignment` (
  `assRef` varchar(255) NOT NULL,
  `userRef` varchar(255) NOT NULL,
  `taskRef` varchar(255) NOT NULL,
  `dateAssigned` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `assignment`
--

INSERT INTO `assignment` (`assRef`, `userRef`, `taskRef`, `dateAssigned`) VALUES
('ASSIGN_48653', 'USER_266', 'TASK_228728', '2025-04-30 17:19:33'),
('ASSIGN_51434', 'USER_266', 'TASK_228728', '2025-05-03 22:29:27'),
('ASSIGN_53708', 'USER_266', 'TASK_860761', '2025-04-30 19:09:39');

-- --------------------------------------------------------

--
-- Structure de la table `collaborator`
--

CREATE TABLE `collaborator` (
  `collabRef` varchar(255) NOT NULL,
  `userRef` varchar(255) NOT NULL,
  `teamRef` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `collaborator`
--

INSERT INTO `collaborator` (`collabRef`, `userRef`, `teamRef`, `role`) VALUES
('COLLAB-544942', 'USER_266', 'TEAM-473582', 'Project Manager'),
('COLLAB-76547', 'USER_266', 'TEAM-91524', 'Project Manager');

-- --------------------------------------------------------

--
-- Structure de la table `email`
--

CREATE TABLE `email` (
  `emailRef` varchar(20) NOT NULL,
  `sender` varchar(30) NOT NULL,
  `receiver` varchar(30) NOT NULL,
  `object` varchar(20) NOT NULL,
  `message` varchar(500) NOT NULL,
  `date` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `file`
--

CREATE TABLE `file` (
  `fileRef` varchar(255) NOT NULL,
  `projectRef` varchar(255) NOT NULL,
  `fileName` varchar(255) NOT NULL,
  `fileUrl` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `notification`
--

CREATE TABLE `notification` (
  `notifRef` varchar(30) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `userRef` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `createdAt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `project`
--

CREATE TABLE `project` (
  `projectRef` varchar(20) NOT NULL,
  `projectName` varchar(30) NOT NULL,
  `userRef` varchar(30) NOT NULL,
  `projectDesc` varchar(300) NOT NULL,
  `projectType` varchar(255) NOT NULL,
  `context` varchar(255) NOT NULL,
  `projectCible` varchar(30) NOT NULL,
  `functionalities` varchar(255) NOT NULL,
  `limitations` varchar(255) NOT NULL,
  `projectStart` varchar(20) NOT NULL,
  `projectEnd` varchar(20) NOT NULL,
  `duration` varchar(255) NOT NULL,
  `cost` varchar(255) NOT NULL,
  `production` varchar(255) NOT NULL,
  `staffing` varchar(255) NOT NULL,
  `createdAt` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `project`
--

INSERT INTO `project` (`projectRef`, `projectName`, `userRef`, `projectDesc`, `projectType`, `context`, `projectCible`, `functionalities`, `limitations`, `projectStart`, `projectEnd`, `duration`, `cost`, `production`, `staffing`, `createdAt`) VALUES
('PROJ-182122', 'attendance system', 'USER_266', 'Système de gestion de présences et d\'absence avec QR Code', 'Software', '', 'Créer un système permettant d\'', '', '', '2025-05-12', '', '', '', '', '', '25/04/2025 14:12:29'),
('PROJ-489533', 'voting system', 'USER_266', 'online voting system to help people vote everywhere', 'Software', '', 'manage votes\r\ncalculate voting', '', '', '2025-06-30', '', '', '', '', '', '2025-04-20T06:13:48.127Z'),
('PROJ-569550', 'attendance system', 'USER_266', 'Système de gestion de présences et d\'absence avec QR Code', 'Software', '', 'Créer un système permettant d\'', '', '', '2025-05-12', '', '', '', '', '', '25/04/2025 14:01:48'),
('PROJ-724545', 'attendance system', 'USER_266', 'Système de gestion de présences et d\'absence avec QR Code', 'Software', '', 'Créer un système permettant d\'', '', '', '2025-05-12', '', '', '', '', '', '25/04/2025 14:03:08');

-- --------------------------------------------------------

--
-- Structure de la table `task`
--

CREATE TABLE `task` (
  `taskRef` varchar(30) NOT NULL,
  `taskname` varchar(30) NOT NULL,
  `startDate` varchar(30) NOT NULL,
  `endDate` varchar(30) NOT NULL,
  `projectRef` varchar(30) NOT NULL,
  `status` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `task`
--

INSERT INTO `task` (`taskRef`, `taskname`, `startDate`, `endDate`, `projectRef`, `status`) VALUES
('TASK_114646', 'Project analysis', '2025-07-16', '2025-07-21', 'PROJ-489533', 'completed'),
('TASK_228728', 'Functionalities definition', '2025-05-10', '2025-05-14', 'PROJ-182122', 'completed'),
('TASK_350850', 'Project definition', '2025-05-05', '2025-05-09', 'PROJ-182122', 'ongoing'),
('TASK_43536', 'Définition du projet', '2025-05-10', '2025-05-14', 'PROJ-724545', 'pending'),
('TASK_4678', 'Cahier de charges', '2025-05-15', '2025-05-20', 'PROJ-724545', 'pending'),
('TASK_624869', 'Functionalities definition', '2025-05-10', '2025-05-14', 'PROJ-182122', 'ongoing'),
('TASK_860761', 'Project definition', '2025-05-05', '2025-05-09', 'PROJ-182122', 'ongoing'),
('TASK_86903', 'Project analysis', '2025-07-16', '2025-07-21', 'PROJ-489533', 'completed'),
('TASK_871743', 'Wireframe', '2025-07-16', '2025-07-21', 'PROJ-489533', 'ongoing'),
('TASK_871754', 'Project analysis', '2025-07-16', '2025-07-21', 'PROJ-489533', 'ongoing');

-- --------------------------------------------------------

--
-- Structure de la table `team`
--

CREATE TABLE `team` (
  `teamRef` varchar(255) NOT NULL,
  `projectRef` varchar(255) NOT NULL,
  `createdAt` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `team`
--

INSERT INTO `team` (`teamRef`, `projectRef`, `createdAt`) VALUES
('TEAM-251177', 'PROJ-569550', '25/04/2025 14:01:48'),
('TEAM-473582', 'PROJ-182122', '25/04/2025 14:12:29'),
('TEAM-91524', 'PROJ-724545', '25/04/2025 14:03:08');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `userRef` varchar(30) NOT NULL,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(50) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(30) NOT NULL,
  `country` varchar(20) NOT NULL,
  `city` varchar(20) NOT NULL,
  `profilePhotoUrl` varchar(30) NOT NULL,
  `privilege` varchar(10) NOT NULL,
  `createdAt` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`userRef`, `firstname`, `lastname`, `email`, `password`, `country`, `city`, `profilePhotoUrl`, `privilege`, `createdAt`) VALUES
('USER_266', 'Cédric', 'Ananga Ngoko', 'ancedric55@gmail.com', '13Aout1994', 'Cameroon', 'Douala', '/uploads/profiles/profile-1744', 'user', '2025-04-17 10:08:19');

-- --------------------------------------------------------

--
-- Structure de la table `user_sessions`
--

CREATE TABLE `user_sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`assRef`);

--
-- Index pour la table `collaborator`
--
ALTER TABLE `collaborator`
  ADD PRIMARY KEY (`collabRef`);

--
-- Index pour la table `email`
--
ALTER TABLE `email`
  ADD PRIMARY KEY (`emailRef`);

--
-- Index pour la table `file`
--
ALTER TABLE `file`
  ADD PRIMARY KEY (`fileRef`);

--
-- Index pour la table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notifRef`);

--
-- Index pour la table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`projectRef`);

--
-- Index pour la table `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`taskRef`);

--
-- Index pour la table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`teamRef`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userRef`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `user_sessions`
--
ALTER TABLE `user_sessions`
  ADD PRIMARY KEY (`session_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
