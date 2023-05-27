-- phpMyAdmin SQL Dump
-- version 4.9.11
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: May 12, 2023 at 11:10 AM
-- Server version: 5.7.23-23
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `edgevied_edge_verified`
--

-- --------------------------------------------------------

--
-- Table structure for table `access`
--

CREATE TABLE `access` (
  `access_id` int(11) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `access_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `access`
--

INSERT INTO `access` (`access_id`, `titre`, `access_status`, `date_enregistrement`) VALUES
(1, 'enregistrer admin', 'actif', 0),
(2, 'definir acces admin', 'actif', 0),
(3, 'voir un client', 'actif', 0),
(4, 'enregistrer acte', 'actif', 0);

-- --------------------------------------------------------

--
-- Table structure for table `actifs`
--

CREATE TABLE `actifs` (
  `actif_id` int(11) NOT NULL,
  `titre` varchar(200) NOT NULL,
  `actif_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `actifs`
--

INSERT INTO `actifs` (`actif_id`, `titre`, `actif_status`, `date_enregistrement`) VALUES
(1, 'Entreprise', 'actif', 1660117950),
(2, 'Immobiliers', 'actif', 1660514810);

-- --------------------------------------------------------

--
-- Table structure for table `actif_details`
--

CREATE TABLE `actif_details` (
  `actif_detail_id` int(11) NOT NULL,
  `actif_id` int(11) NOT NULL,
  `detail` varchar(200) NOT NULL DEFAULT '',
  `reponse_type` varchar(50) NOT NULL DEFAULT 'texte' COMMENT 'text|file|date',
  `obligatoire` varchar(10) NOT NULL DEFAULT 'non',
  `actif_detail_status` varchar(50) NOT NULL DEFAULT 'actif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `actif_details`
--

INSERT INTO `actif_details` (`actif_detail_id`, `actif_id`, `detail`, `reponse_type`, `obligatoire`, `actif_detail_status`) VALUES
(1, 1, 'Forme Juridique', 'text', 'oui', 'actif'),
(2, 1, 'dénomination', 'text', 'oui', 'actif'),
(3, 1, 'Adresse', 'text', 'oui', 'actif'),
(4, 1, 'Date création', 'date', 'non', 'actif'),
(5, 1, 'RCCM', 'file', 'oui', 'actif'),
(6, 1, 'IDNAT', 'file', 'non', 'actif'),
(7, 2, 'Type de propriété(maison, appartement, bungalow..)', 'select', 'non', 'actif'),
(8, 2, 'Date d&amp;#39;achat', 'date', 'non', 'actif'),
(9, 2, 'Grandeur surface', 'text', 'non', 'actif'),
(10, 2, 'Valeur actuelle(USD)', 'text', 'non', 'actif'),
(11, 2, 'Adresse de la propriété', 'text', 'oui', 'actif'),
(12, 2, 'Si la propriété est saisie comme garantie pour un crédit , veuillez indiquez le montant du crédit(USD)', 'text', 'non', 'actif'),
(13, 2, 'Attestation parcellaire', 'file', 'non', 'actif'),
(14, 1, 'Nom des actionnaires', 'multiple', 'non', 'actif'),
(15, 1, 'L&amp;#39;entreprise est-elle opérationnelle', 'select', 'non', 'actif'),
(16, 1, 'Service de l\'entreprise', 'select', 'non', 'actif'),
(17, 2, 'Fiche Parcelaire', 'file', 'non', 'actif'),
(18, 2, 'Procès verbal de constat des lieux', 'file', 'non', 'actif'),
(20, 2, 'Certificat d&amp;#39;enregistrement parcelaire', 'file', 'non', 'actif');

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `nom` varchar(200) NOT NULL,
  `email` varchar(100) NOT NULL,
  `telephone` varchar(50) NOT NULL,
  `pass` longtext NOT NULL,
  `admin_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`admin_id`, `nom`, `email`, `telephone`, `pass`, `admin_status`, `date_enregistrement`) VALUES
(1, 'Chris Tenday', 'c@gmail.com', '0853010401', '12345', 'actif', 0),
(7, 'Gaston', 'gaston@gmail.com', '0813719944', '88289', 'actif', 0),
(8, 'Lionnel', 'lionnel@gmail.com', '08578899454', '68333', 'actif', 0),
(9, 'Jojo', 'jo@gmail.com', '0856633211', '95558', 'actif', 0),
(10, 'Flory', 'flory@gmail.com', '0999102246', '27682', 'actif', 0),
(11, 'Yvonne bapenda', 'yvonne@gmail.com', '0856633251', '68033', 'actif', 0),
(12, 'Isaac', 'isaac@gmail.com', '0812533562', '21047', 'actif', 0),
(13, 'beyda', 'beydamunkatu@gmail.com', '243999618704', '70361', 'actif', 0),
(14, 'Kambilo Valerie', 'vkambilo23@gmail.com', '818284202', '76598', 'actif', 0),
(15, 'birembano deborah', 'ngabodeborah9@gmail.com', '0995725289', '78282', 'actif', 0);

-- --------------------------------------------------------

--
-- Table structure for table `admin_access`
--

CREATE TABLE `admin_access` (
  `admin_access_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `access_id` int(11) NOT NULL,
  `admin_access_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_access`
--

INSERT INTO `admin_access` (`admin_access_id`, `admin_id`, `access_id`, `admin_access_status`, `date_enregistrement`) VALUES
(1, 1, 1, 'actif', 0);

-- --------------------------------------------------------

--
-- Table structure for table `attachments`
--

CREATE TABLE `attachments` (
  `attachment_id` int(11) NOT NULL,
  `titre` varchar(100) NOT NULL,
  `attachment_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `carte_transactions`
--

CREATE TABLE `carte_transactions` (
  `carte_transaction_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `carte_transactions`
--

INSERT INTO `carte_transactions` (`carte_transaction_id`, `transaction_id`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10),
(11, 11),
(12, 12),
(13, 13),
(14, 14),
(15, 15),
(16, 16),
(17, 17),
(18, 1);

-- --------------------------------------------------------

--
-- Table structure for table `certificats`
--

CREATE TABLE `certificats` (
  `certificat_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `reference` varchar(50) NOT NULL,
  `certificat_path` text NOT NULL,
  `certificat_status` varchar(50) NOT NULL DEFAULT 'actif',
  `admin_id` int(11) NOT NULL,
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `certificat_authentifications`
--

CREATE TABLE `certificat_authentifications` (
  `certificat_authentification_id` int(11) NOT NULL,
  `certificat_id` int(11) NOT NULL,
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `certificat_details`
--

CREATE TABLE `certificat_details` (
  `certificat_detail_id` int(11) NOT NULL,
  `certificat_section_id` int(11) NOT NULL,
  `diligence_questionnaire_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `certificat_sections`
--

CREATE TABLE `certificat_sections` (
  `certificat_section_id` int(11) NOT NULL,
  `section` varchar(50) NOT NULL,
  `certificat_section_status` varchar(50) NOT NULL DEFAULT 'actif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `certificat_sections`
--

INSERT INTO `certificat_sections` (`certificat_section_id`, `section`, `certificat_section_status`) VALUES
(1, 'Identite', 'actif'),
(2, 'Contacts', 'actif'),
(3, 'Informations Judiciaire', 'actif');

-- --------------------------------------------------------

--
-- Table structure for table `clients`
--

CREATE TABLE `clients` (
  `client_id` int(11) NOT NULL,
  `personnalite` varchar(100) NOT NULL DEFAULT 'physique' COMMENT 'physique ou morale',
  `nom` varchar(200) NOT NULL,
  `email` varchar(50) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `pass` longtext NOT NULL,
  `client_status` varchar(50) NOT NULL DEFAULT 'pending',
  `otp` varchar(50) NOT NULL,
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `clients`
--

INSERT INTO `clients` (`client_id`, `personnalite`, `nom`, `email`, `telephone`, `pass`, `client_status`, `otp`, `date_enregistrement`) VALUES
(1, 'physique', 'Chris Tenday', 'ctenday@gmail.com', '+243818792693', '91df087c256a32d1f95f015c5f636e99972cf3ab', 'actif', '148855', 1683905508);

-- --------------------------------------------------------

--
-- Table structure for table `client_autorisations`
--

CREATE TABLE `client_autorisations` (
  `client_autorisation_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `client_autorisation_status` varchar(50) NOT NULL DEFAULT 'actif',
  `media_id` int(11) NOT NULL,
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `credits`
--

CREATE TABLE `credits` (
  `credit_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `banque` varchar(200) NOT NULL,
  `motif` varchar(200) NOT NULL,
  `montant` int(11) NOT NULL,
  `devise` varchar(20) NOT NULL DEFAULT 'USD',
  `date_credit` bigint(20) NOT NULL,
  `duree_credit` varchar(200) NOT NULL,
  `echeance_remboursement` varchar(200) NOT NULL,
  `dernier_paiement_date` bigint(20) NOT NULL,
  `solde` int(11) NOT NULL,
  `credit_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diligences`
--

CREATE TABLE `diligences` (
  `diligence_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `diligence_type_id` int(11) NOT NULL,
  `objet` text NOT NULL,
  `diligence_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `diligences`
--

INSERT INTO `diligences` (`diligence_id`, `client_id`, `diligence_type_id`, `objet`, `diligence_status`, `date_enregistrement`) VALUES
(1, 12, 1, 'Basique', 'actif', 1683902994);

-- --------------------------------------------------------

--
-- Table structure for table `diligence_actes`
--

CREATE TABLE `diligence_actes` (
  `diligence_acte_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `acte` varchar(150) NOT NULL,
  `media_id` int(11) NOT NULL,
  `observation` text NOT NULL,
  `diligence_acte_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diligence_actifs`
--

CREATE TABLE `diligence_actifs` (
  `diligence_actif_id` int(11) NOT NULL,
  `actif_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `diligence_actif_status` varchar(20) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diligence_actif_details`
--

CREATE TABLE `diligence_actif_details` (
  `diligence_actif_detail_id` int(11) NOT NULL,
  `diligence_actif_id` int(11) NOT NULL,
  `actif_detail_id` int(11) NOT NULL,
  `detail` longtext NOT NULL,
  `diligence_actif_status` varchar(20) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `diligence_questionnaires`
--

CREATE TABLE `diligence_questionnaires` (
  `diligence_questionnaire_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `sous_question_id` int(11) NOT NULL COMMENT 'S''il s''agit d''une sous question',
  `reponse` longtext NOT NULL,
  `diligence_upload_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `diligence_questionnaire_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `diligence_questionnaires`
--

INSERT INTO `diligence_questionnaires` (`diligence_questionnaire_id`, `diligence_id`, `question_id`, `sous_question_id`, `reponse`, `diligence_upload_id`, `admin_id`, `diligence_questionnaire_status`, `date_enregistrement`) VALUES
(1, 1, 1, 0, 'Tenday', 0, 0, 'actif', 1683903006),
(2, 1, 2, 0, '', 0, 0, 'actif', 1683903628),
(3, 1, 3, 0, 'Chris', 0, 0, 'actif', 1683903013),
(4, 1, 4, 0, 'Masculin', 0, 0, 'actif', 1683903016),
(5, 1, 5, 0, '08-08-1959', 0, 0, 'actif', 1683903026),
(6, 1, 6, 0, 'Célibataire', 0, 0, 'actif', 1683903029),
(7, 1, 7, 0, '853010401', 0, 0, 'actif', 1683903044),
(8, 1, 7, 0, '818792693', 0, 0, 'deleted', 1683903044),
(9, 1, 8, 0, 'PROVINCE :  Bas-Uele | VILLE :  Buta |  COMMUNE :  com1 | QUARTIER :  qu1 | AVENUE :  av1 | NUMERO :  09 | REFERENCE :  tp', 0, 0, 'actif', 1683903117),
(10, 1, 8, 0, 'PROVINCE :  Kinshasa | VILLE :  Kinshasa |  COMMUNE :  kincom1 | QUARTIER :  kinqu1 | AVENUE :  kinav1 | NUMERO :  08 | REFERENCE :  undefined', 0, 0, 'deleted', 1683903117),
(11, 1, 9, 0, 'PROVINCE :  Kinshasa | VILLE :  Kinshasa |  COMMUNE :  kk | QUARTIER :  kk | AVENUE :  kk | NUMERO :  9 | REFERENCE :  kk', 0, 0, 'actif', 1683903135),
(12, 1, 10, 0, '', 1, 0, 'actif', 1683903150),
(13, 1, 705, 0, '', 2, 0, 'actif', 1683903167);

-- --------------------------------------------------------

--
-- Table structure for table `diligence_transactions`
--

CREATE TABLE `diligence_transactions` (
  `diligence_transaction_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `diligence_transactions`
--

INSERT INTO `diligence_transactions` (`diligence_transaction_id`, `transaction_id`, `client_id`, `diligence_id`) VALUES
(1, 1, 12, 1);

-- --------------------------------------------------------

--
-- Table structure for table `diligence_types`
--

CREATE TABLE `diligence_types` (
  `diligence_type_id` int(11) NOT NULL,
  `type` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `diligence_type_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `diligence_types`
--

INSERT INTO `diligence_types` (`diligence_type_id`, `type`, `description`, `diligence_type_status`, `date_enregistrement`) VALUES
(1, 'Diligence basique complète', 'La diligence de base consiste à obtenir des informations afin de confirmer votre identité, telles que votre nom, votre adresse et votre date de naissance.', 'actif', 0),
(2, 'Rapport diligence financière', 'L\'un des types les plus importants de due diligence est le rapport de diligence financière qui vise à vérifier l’exactitude de votre déclaration financière. La due diligence financière vise à fournir une compréhension approfondie de la situation financière d’une personne morale ou physique, comme les crédits obtenus et/ou les dettes en cours. Ces informations permettront à la personne de prendre une meilleure décision avant de s\'engager.', 'actif', 0),
(3, 'Antécédents juridique', 'L\'objectif d\'une vérification du casier judiciaire est de présenter un historique complet des antécédents criminels d\'une personne. Les casiers judiciaires peuvent être utilisés à de nombreuses fins, notamment pour vérifier les antécédents à des fins d\'emploi, d\'habilitation de sécurité, d\'adoption, d\'immigration dans un pays et d\'octroi de licences.', 'actif', 0),
(4, 'Diligence sur actifs', 'Un autre type de diligence raisonnable est la due diligence des actifs. Les rapports de diligence raisonnable sur les actifs comprennent généralement des informations détaillées sur les actifs détenus, leur valeur actuelle et la confirmation que les actifs appartiennent au propriétaire déclaré. Ces informations peuvent être communiquées à la banque, à un investisseur, etc.', 'actif', 0),
(5, 'Diligence complète', 'Cette due diligence complète comprend toutes les vérifications susmentionnées, couvrant à 360 degrés l\'identité, le casier judiciaire, les actifs et la responsabilité financière d\'une personne.', 'actif', 0),
(6, 'Vérification fournisseur', 'Le contrôle préalable des fournisseurs est le processus par lequel une entreprise ou une agence effectue des vérifications au nom d\'une entreprise pour s\'assurer que ses fournisseurs sont des organisations légitimes, crédibles et en conformité avec les autorités réglementaires locales.\r\nUn contrôle préalable approfondi des fournisseurs vous aide à déterminer si vous devez faire des affaires avec un fournisseur particulier. Ce processus implique la sélection, la vérification, l\'intégration et le suivi de vos partenaires et de leurs activités.\r\n', 'actif', 0);

-- --------------------------------------------------------

--
-- Table structure for table `diligence_uploads`
--

CREATE TABLE `diligence_uploads` (
  `diligence_upload_id` int(11) NOT NULL,
  `diligence_id` int(11) NOT NULL,
  `media_id` int(11) NOT NULL,
  `designation` varchar(100) NOT NULL COMMENT 'ex: carte d''identité, acte de naissancee..etc.',
  `diligence_upload_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `diligence_uploads`
--

INSERT INTO `diligence_uploads` (`diligence_upload_id`, `diligence_id`, `media_id`, `designation`, `diligence_upload_status`, `date_enregistrement`) VALUES
(1, 1, 1, 'Veuillez attacher votre pièce d&amp;#39;identité(Carte électeur, Passeport ou Permis de conduire)', 'actif', 1683903150),
(2, 1, 2, 'Photo', 'actif', 1683903167);

-- --------------------------------------------------------

--
-- Table structure for table `medias`
--

CREATE TABLE `medias` (
  `media_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL DEFAULT 'image',
  `media` longtext NOT NULL,
  `media_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `medias`
--

INSERT INTO `medias` (`media_id`, `type`, `media`, `media_status`, `date_enregistrement`) VALUES
(1, 'image', 'http://back-system.verifixs.com/uploads/2041081516.jpg', 'actif', 1683903150),
(2, 'image', 'http://back-system.verifixs.com/uploads/1377322687.png', 'actif', 1683903167);

-- --------------------------------------------------------

--
-- Table structure for table `mobile_transactions`
--

CREATE TABLE `mobile_transactions` (
  `mobile_transaction_id` int(11) NOT NULL,
  `transaction_id` int(11) NOT NULL,
  `telephone` varchar(20) NOT NULL,
  `channel` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `question_id` int(11) NOT NULL,
  `diligence_type_id` int(11) NOT NULL,
  `question` varchar(100) NOT NULL,
  `reponse_type` varchar(50) NOT NULL DEFAULT 'libre' COMMENT 'valeur: text|date|fixe|attachment|capture',
  `total_reponse` varchar(50) NOT NULL DEFAULT 'single' COMMENT 'single|multiple.\r\n-single pour une seule réponse.\r\n- multiple: pour plusieurs réponses.',
  `certificat_section_id` int(11) NOT NULL,
  `question_status` varchar(50) NOT NULL DEFAULT 'actif',
  `obligatoire` varchar(20) NOT NULL DEFAULT 'oui',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`question_id`, `diligence_type_id`, `question`, `reponse_type`, `total_reponse`, `certificat_section_id`, `question_status`, `obligatoire`, `date_enregistrement`) VALUES
(1, 0, 'Nom', 'text', 'single', 1, 'actif', 'oui', 1650817079),
(2, 0, 'Post-nom', 'text', 'single', 1, 'actif', 'non', 0),
(3, 0, 'Prénom', 'text', 'single', 1, 'actif', 'oui', 0),
(4, 0, 'Sexe', 'fixe', 'single', 1, 'actif', 'oui', 1650817130),
(5, 0, 'Date de naissance', 'date', 'single', 1, 'actif', 'oui', 1650817229),
(6, 0, 'Etat civil', 'fixe', 'single', 1, 'actif', 'oui', 1650817239),
(7, 0, 'Vos numéros de téléphone', 'telephone', 'multiple', 2, 'actif', 'oui', 1650817344),
(8, 0, 'Vos adresses personnelles', 'text', 'multiple', 2, 'actif', 'oui', 1650817375),
(9, 0, 'Vos adresses pour les 5 années précedentes', 'text', 'multiple', 2, 'actif', 'oui', 1650817414),
(10, 0, 'Veuillez attacher votre pièce d&amp;#39;identité(Carte électeur, Passeport ou Permis de conduire)', 'attachment', 'single', 0, 'actif', 'oui', 1652194678),
(704, 3, 'Avez-vous déjà été condamné en justice?', 'fixe', 'single', 3, 'actif', 'oui', 1652194857),
(705, 0, 'Photo', 'capture', 'single', 0, 'actif', 'oui', 0),
(7003, 5, 'Avez-vous déjà été condamné en justice?', 'fixe', 'single', 0, 'actif', 'oui', 1660561149),
(7004, 6, 'Position', 'fixe', 'single', 0, 'actif', 'oui', 1669727295),
(7005, 6, 'Dénomination entreprise', 'text', 'single', 0, 'actif', 'oui', 1669727539),
(7006, 6, 'adresse siège sociale', 'text', 'single', 0, 'actif', 'oui', 1669727572),
(7007, 6, 'Autres adresses', 'text', 'multiple', 0, 'actif', 'oui', 1669727689),
(7008, 6, 'Forme juridique', 'fixe', 'single', 0, 'actif', 'oui', 1676635159),
(7009, 6, 'Services/Produits', 'text', 'multiple', 0, 'actif', 'oui', 1669727815),
(7010, 6, 'Date création', 'date', 'single', 0, 'actif', 'oui', 1669727845),
(7014, 6, 'Noms associés', 'text', 'multiple', 0, 'actif', 'oui', 1669727762);

-- --------------------------------------------------------

--
-- Table structure for table `reponse_fixes`
--

CREATE TABLE `reponse_fixes` (
  `reponse_fixe_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `reponse` varchar(50) NOT NULL,
  `reponse_fixe_status` varchar(50) NOT NULL DEFAULT 'actif',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reponse_fixes`
--

INSERT INTO `reponse_fixes` (`reponse_fixe_id`, `question_id`, `reponse`, `reponse_fixe_status`, `date_enregistrement`) VALUES
(1, 4, 'Masculin', 'actif', 1650817130),
(2, 4, 'Féminin', 'actif', 1650817130),
(3, 704, 'Oui', 'actif', 1652194857),
(4, 704, 'Non', 'actif', 1652194857),
(5, 7000, 'Oui', 'actif', 1660513117),
(6, 7000, 'Non', 'actif', 1660513117),
(7, 7001, 'Oui', 'actif', 1660513300),
(8, 7001, 'Non', 'actif', 1660513300),
(9, 6, 'Célibataire', 'actif', 0),
(10, 6, 'Marié(e)', 'actif', 0),
(11, 6, 'Divorcé(e)', 'actif', 0),
(12, 6, 'Veuf(ve)', 'actif', 0),
(13, 7003, 'Oui', 'actif', 1660561149),
(14, 7003, 'Non', 'actif', 1660561149),
(15, 7004, 'Gérant', 'actif', 1669727295),
(16, 7004, 'Président du conseil d&amp;#39;administration', 'actif', 1669727295),
(17, 7008, 'Ets', 'actif', 1676635160),
(18, 7008, 'SARL', 'actif', 1676635160),
(19, 7008, 'SARLU', 'actif', 1676635160),
(20, 7008, 'SAS', 'actif', 1676635160),
(21, 7008, 'SA', 'actif', 1676635160),
(22, 7008, 'ONG', 'actif', 1676635160),
(23, 7008, 'ASBL', 'actif', 1676635160);

-- --------------------------------------------------------

--
-- Table structure for table `sous_questions`
--

CREATE TABLE `sous_questions` (
  `sous_question_id` int(11) NOT NULL,
  `reponse_fixe_id` int(11) NOT NULL,
  `sous_question` varchar(100) NOT NULL,
  `reponse_type` varchar(100) NOT NULL DEFAULT 'libre' COMMENT 'text|date|fixe|attachment|date',
  `total_reponse` varchar(50) NOT NULL DEFAULT 'single' COMMENT 'single|multiple',
  `sous_question_status` varchar(50) NOT NULL DEFAULT 'actif',
  `certificat_section_id` int(11) NOT NULL,
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sous_questions`
--

INSERT INTO `sous_questions` (`sous_question_id`, `reponse_fixe_id`, `sous_question`, `reponse_type`, `total_reponse`, `sous_question_status`, `certificat_section_id`, `date_enregistrement`) VALUES
(1, 3, 'La date de votre condamnation', 'date', 'single', 'actif', 3, 1652195001),
(2, 3, 'Motif de votre condamnation', 'text', 'single', 'actif', 3, 1652195044),
(3, 3, 'Juridiction de votre condamnation', 'text', 'single', 'actif', 3, 1652195063),
(5, 13, 'La date de votre condamnation', 'date', 'single', 'actif', 3, 1660561251),
(6, 13, 'Motif de votre condamnation', 'text', 'single', 'actif', 3, 1660561271),
(7, 13, 'Juridiction de votre condamnation', 'text', 'single', 'actif', 3, 1660561290),
(8, 17, 'RCCM', 'attachment', 'single', 'actif', 0, 1676635733),
(9, 17, 'Autorisation d&amp;#39;ouverture', 'attachment', 'single', 'actif', 0, 1676635750),
(10, 17, 'Patente', 'attachment', 'single', 'actif', 0, 1676635796),
(11, 18, 'RCCM', 'attachment', 'single', 'actif', 0, 1676635812),
(12, 18, 'Numéro Impôt', 'attachment', 'single', 'actif', 0, 1676635829),
(13, 18, 'IDNAT', 'attachment', 'single', 'actif', 0, 1676635838),
(14, 19, 'RCCM', 'attachment', 'single', 'actif', 0, 1676635862),
(15, 20, 'RCCM', 'attachment', 'single', 'actif', 0, 1676635874),
(16, 21, 'RCCM', 'attachment', 'single', 'actif', 0, 1676635884),
(17, 19, 'IDNAT', 'attachment', 'single', 'actif', 0, 1676635910),
(18, 20, 'IDNAT', 'attachment', 'single', 'actif', 0, 1676635919),
(19, 21, 'IDNAT', 'attachment', 'single', 'actif', 0, 1676635923),
(20, 19, 'Numéro Impôt', 'attachment', 'single', 'actif', 0, 1676635940),
(21, 20, 'Numéro Impôt', 'attachment', 'single', 'actif', 0, 1676635944),
(22, 21, 'Numéro Impôt', 'attachment', 'single', 'actif', 0, 1676635948);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `transaction_id` int(11) NOT NULL,
  `montant` int(11) NOT NULL,
  `devise` varchar(20) NOT NULL DEFAULT 'USD',
  `transaction_reference` varchar(200) NOT NULL,
  `orderNumber` varchar(200) NOT NULL,
  `transaction_status` varchar(50) NOT NULL DEFAULT 'pending',
  `date_enregistrement` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`transaction_id`, `montant`, `devise`, `transaction_reference`, `orderNumber`, `transaction_status`, `date_enregistrement`) VALUES
(1, 10, 'USD', 'A4fS98', 'A7tF34', 'pending', 1683903717);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `access`
--
ALTER TABLE `access`
  ADD PRIMARY KEY (`access_id`);

--
-- Indexes for table `actifs`
--
ALTER TABLE `actifs`
  ADD PRIMARY KEY (`actif_id`);

--
-- Indexes for table `actif_details`
--
ALTER TABLE `actif_details`
  ADD PRIMARY KEY (`actif_detail_id`);

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Indexes for table `admin_access`
--
ALTER TABLE `admin_access`
  ADD PRIMARY KEY (`admin_access_id`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`attachment_id`);

--
-- Indexes for table `carte_transactions`
--
ALTER TABLE `carte_transactions`
  ADD PRIMARY KEY (`carte_transaction_id`);

--
-- Indexes for table `certificats`
--
ALTER TABLE `certificats`
  ADD PRIMARY KEY (`certificat_id`);

--
-- Indexes for table `certificat_authentifications`
--
ALTER TABLE `certificat_authentifications`
  ADD PRIMARY KEY (`certificat_authentification_id`);

--
-- Indexes for table `certificat_details`
--
ALTER TABLE `certificat_details`
  ADD PRIMARY KEY (`certificat_detail_id`);

--
-- Indexes for table `certificat_sections`
--
ALTER TABLE `certificat_sections`
  ADD PRIMARY KEY (`certificat_section_id`);

--
-- Indexes for table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`client_id`);

--
-- Indexes for table `client_autorisations`
--
ALTER TABLE `client_autorisations`
  ADD PRIMARY KEY (`client_autorisation_id`);

--
-- Indexes for table `credits`
--
ALTER TABLE `credits`
  ADD PRIMARY KEY (`credit_id`);

--
-- Indexes for table `diligences`
--
ALTER TABLE `diligences`
  ADD PRIMARY KEY (`diligence_id`);

--
-- Indexes for table `diligence_actes`
--
ALTER TABLE `diligence_actes`
  ADD PRIMARY KEY (`diligence_acte_id`);

--
-- Indexes for table `diligence_actifs`
--
ALTER TABLE `diligence_actifs`
  ADD PRIMARY KEY (`diligence_actif_id`);

--
-- Indexes for table `diligence_actif_details`
--
ALTER TABLE `diligence_actif_details`
  ADD PRIMARY KEY (`diligence_actif_detail_id`);

--
-- Indexes for table `diligence_questionnaires`
--
ALTER TABLE `diligence_questionnaires`
  ADD PRIMARY KEY (`diligence_questionnaire_id`);

--
-- Indexes for table `diligence_transactions`
--
ALTER TABLE `diligence_transactions`
  ADD PRIMARY KEY (`diligence_transaction_id`);

--
-- Indexes for table `diligence_types`
--
ALTER TABLE `diligence_types`
  ADD PRIMARY KEY (`diligence_type_id`);

--
-- Indexes for table `diligence_uploads`
--
ALTER TABLE `diligence_uploads`
  ADD PRIMARY KEY (`diligence_upload_id`);

--
-- Indexes for table `medias`
--
ALTER TABLE `medias`
  ADD PRIMARY KEY (`media_id`);

--
-- Indexes for table `mobile_transactions`
--
ALTER TABLE `mobile_transactions`
  ADD PRIMARY KEY (`mobile_transaction_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `reponse_fixes`
--
ALTER TABLE `reponse_fixes`
  ADD PRIMARY KEY (`reponse_fixe_id`);

--
-- Indexes for table `sous_questions`
--
ALTER TABLE `sous_questions`
  ADD PRIMARY KEY (`sous_question_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`transaction_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `access`
--
ALTER TABLE `access`
  MODIFY `access_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `actifs`
--
ALTER TABLE `actifs`
  MODIFY `actif_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `actif_details`
--
ALTER TABLE `actif_details`
  MODIFY `actif_detail_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `admin_access`
--
ALTER TABLE `admin_access`
  MODIFY `admin_access_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `attachment_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carte_transactions`
--
ALTER TABLE `carte_transactions`
  MODIFY `carte_transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `certificats`
--
ALTER TABLE `certificats`
  MODIFY `certificat_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificat_authentifications`
--
ALTER TABLE `certificat_authentifications`
  MODIFY `certificat_authentification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificat_details`
--
ALTER TABLE `certificat_details`
  MODIFY `certificat_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `certificat_sections`
--
ALTER TABLE `certificat_sections`
  MODIFY `certificat_section_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `clients`
--
ALTER TABLE `clients`
  MODIFY `client_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `client_autorisations`
--
ALTER TABLE `client_autorisations`
  MODIFY `client_autorisation_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `credits`
--
ALTER TABLE `credits`
  MODIFY `credit_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diligences`
--
ALTER TABLE `diligences`
  MODIFY `diligence_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `diligence_actes`
--
ALTER TABLE `diligence_actes`
  MODIFY `diligence_acte_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diligence_actifs`
--
ALTER TABLE `diligence_actifs`
  MODIFY `diligence_actif_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diligence_actif_details`
--
ALTER TABLE `diligence_actif_details`
  MODIFY `diligence_actif_detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `diligence_questionnaires`
--
ALTER TABLE `diligence_questionnaires`
  MODIFY `diligence_questionnaire_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `diligence_transactions`
--
ALTER TABLE `diligence_transactions`
  MODIFY `diligence_transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `diligence_types`
--
ALTER TABLE `diligence_types`
  MODIFY `diligence_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `diligence_uploads`
--
ALTER TABLE `diligence_uploads`
  MODIFY `diligence_upload_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `medias`
--
ALTER TABLE `medias`
  MODIFY `media_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `mobile_transactions`
--
ALTER TABLE `mobile_transactions`
  MODIFY `mobile_transaction_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7015;

--
-- AUTO_INCREMENT for table `reponse_fixes`
--
ALTER TABLE `reponse_fixes`
  MODIFY `reponse_fixe_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `sous_questions`
--
ALTER TABLE `sous_questions`
  MODIFY `sous_question_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `transaction_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
