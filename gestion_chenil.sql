-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : ven. 26 avr. 2024 à 11:38
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
-- Base de données : `gestion_chenil`
--

-- --------------------------------------------------------

--
-- Structure de la table `animal`
--

CREATE TABLE `animal` (
  `id_animal` int(11) NOT NULL,
  `category_id_animal_category` int(11) NOT NULL,
  `name_animal` varchar(45) NOT NULL,
  `arrival_animal` date NOT NULL,
  `departure_animal` date NOT NULL,
  `image` text NOT NULL,
  `client_id_client` int(11) NOT NULL,
  `box_id_box` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Structure de la table `booking`
--

CREATE TABLE `booking` (
  `id_booking` int(11) NOT NULL,
  `date_booking` datetime NOT NULL,
  `animal_id_animal` int(11) NOT NULL,
  `animal_category_id_animal_category` int(11) NOT NULL,
  `animal_client_id_client` int(11) NOT NULL,
  `animal_box_id_box` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

-- --------------------------------------------------------

--
-- Structure de la table `box`
--

CREATE TABLE `box` (
  `id_box` int(11) NOT NULL,
  `name_box` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Déchargement des données de la table `box`
--

INSERT INTO `box` (`id_box`, `name_box`) VALUES
(1, '1'),
(2, '2');

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

CREATE TABLE `category` (
  `id_animal_category` int(11) NOT NULL,
  `name_category` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id_animal_category`, `name_category`) VALUES
(1, 'cat'),
(2, 'dog');

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id_client` int(11) NOT NULL,
  `name_client` varchar(45) NOT NULL,
  `phone_client` int(12) NOT NULL,
  `adress_client` varchar(255) NOT NULL,
  `email_client` varchar(100) NOT NULL,
  `password_client` varchar(73) NOT NULL,
  `id_role` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id_client`, `name_client`, `phone_client`, `adress_client`, `email_client`, `password_client`, `id_role`) VALUES
(1, 'Jojo', 101010101, 'On s en moque', 'jojo@jojo.jojo', 'jojo', 1),
(2, 'jaja', 101010101, '22', 'jamy@jamy;ft', '$2b$10$8Zny74dQbi5/aGoMTF/ine0PhLDabsMMxiVGEM9CZxn6ZcrUuw6QC', 1),
(3, 'Matthieu', 1010101, 'kdsldqsdqs', 'mathieu@gmail.com', 'ldaz;lmd;lmdaz;lmdaz', 2);

-- --------------------------------------------------------

--
-- Structure de la table `role`
--

CREATE TABLE `role` (
  `id_role` int(11) NOT NULL,
  `name_role` varchar(75) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_czech_ci;

--
-- Déchargement des données de la table `role`
--

INSERT INTO `role` (`id_role`, `name_role`) VALUES
(1, 'admin'),
(2, 'user');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`id_animal`,`category_id_animal_category`,`client_id_client`,`box_id_box`),
  ADD KEY `fk_animal_category_idx` (`category_id_animal_category`),
  ADD KEY `fk_animal_client1_idx` (`client_id_client`),
  ADD KEY `fk_animal_box1_idx` (`box_id_box`);

--
-- Index pour la table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`id_booking`,`animal_id_animal`,`animal_category_id_animal_category`,`animal_client_id_client`,`animal_box_id_box`),
  ADD KEY `fk_booking_animal1_idx` (`animal_id_animal`,`animal_category_id_animal_category`,`animal_client_id_client`,`animal_box_id_box`);

--
-- Index pour la table `box`
--
ALTER TABLE `box`
  ADD PRIMARY KEY (`id_box`);

--
-- Index pour la table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id_animal_category`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id_client`),
  ADD KEY `fk_role_user` (`id_role`);

--
-- Index pour la table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id_role`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `animal`
--
ALTER TABLE `animal`
  MODIFY `id_animal` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `booking`
--
ALTER TABLE `booking`
  MODIFY `id_booking` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `box`
--
ALTER TABLE `box`
  MODIFY `id_box` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
  MODIFY `id_animal_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id_client` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `role`
--
ALTER TABLE `role`
  MODIFY `id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `animal`
--
ALTER TABLE `animal`
  ADD CONSTRAINT `fk_animal_box1` FOREIGN KEY (`box_id_box`) REFERENCES `box` (`id_box`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_animal_category` FOREIGN KEY (`category_id_animal_category`) REFERENCES `category` (`id_animal_category`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_animal_client1` FOREIGN KEY (`client_id_client`) REFERENCES `client` (`id_client`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_booking_animal1` FOREIGN KEY (`animal_id_animal`,`animal_category_id_animal_category`,`animal_client_id_client`,`animal_box_id_box`) REFERENCES `animal` (`id_animal`, `category_id_animal_category`, `client_id_client`, `box_id_box`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `client`
--
ALTER TABLE `client`
  ADD CONSTRAINT `fk_role_user` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
