-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 16-Jul-2018 às 10:11
-- Versão do servidor: 5.5.44
-- versão do PHP: 5.4.41-0+deb7u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de Dados: `experimentolenita`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents`
--

CREATE TABLE IF NOT EXISTS `core_agents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `birthday` datetime DEFAULT NULL,
  `gender` varchar(1) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKktjutrgawejpe3sx56qomtw9d` (`user_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Extraindo dados da tabela `core_agents`
--

INSERT INTO `core_agents` (`id`, `birthday`, `gender`, `name`, `user_id`) VALUES
(1, '1990-08-30 00:00:00', 'F', 'Lenita Ambrosio', 1),
(3, NULL, 'M', 'Paulo Campos Martins', 4),
(4, NULL, 'F', 'Danieli Cabral da Silva', 3),
(5, NULL, 'M', 'Adolfo Pérez Fonseca', 2),
(6, NULL, 'F', 'Sandra Gesteira Coelho', 8),
(7, NULL, 'M', 'Luiz Gustavo Ribeiro Pereira', 9),
(8, NULL, 'M', 'Álan Maia Borges', 10),
(9, NULL, 'F', 'Mariana Magalhães Campos', 11),
(10, NULL, 'F', 'Juliana Aparecida Mello Lima', 12),
(11, NULL, 'F', 'Bruna Rios Coelho Alves', 13);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_developers`
--

CREATE TABLE IF NOT EXISTS `core_agents_developers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `photo` varchar(255) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKt3u84t7tbhdlqr96gfjv8hsfk` (`agent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_developers_institutions`
--

CREATE TABLE IF NOT EXISTS `core_agents_developers_institutions` (
  `developer_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  UNIQUE KEY `UK_i6dwtf4lnaf4oj9kl8e3fi738` (`institution_id`),
  KEY `FKhmayxudv5ag8pqn3028tscg1s` (`developer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `academic_status` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `kepler_id` varchar(255) DEFAULT NULL,
  `mendeley_id` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `agent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK71mh4922a0q3t7ebjdmviloap` (`agent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Extraindo dados da tabela `core_agents_researchers`
--

INSERT INTO `core_agents_researchers` (`id`, `academic_status`, `display_name`, `kepler_id`, `mendeley_id`, `photo`, `title`, `agent_id`) VALUES
(8, 'Mestre', 'Paulo Campos Martins', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4994709U4', 'M.e', 3),
(11, 'Doutora', 'Sandra Gesteira Coelho', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4785555Y6', 'D.ra', 6),
(12, 'Doutora', 'Mariana Magalhães Campos', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4711104J6', 'D.ra', 9),
(13, 'Doutora', 'Juliana Aparecida Mello Lima', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4465377T8', 'D.ra', 10),
(14, 'Mestre', 'Danieli Cabral da Silva', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K8156860H8', 'M.e', 4),
(15, 'Doutor', 'Luiz Gustavo Ribeiro Pereira', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4708057P9', 'D.r', 7),
(16, 'Mestre', 'Adolfo Pérez Fonseca', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4868005H6', 'M.e', 5),
(17, 'Doutora', 'Bruna Rios Coelho Alves', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4711889J5', 'D.ra', 11),
(18, 'Doutor', 'Álan Maia Borges', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4796232T6', 'D.r', 8),
(19, 'Student  > Master', 'Lenita Ambrosio', NULL, 'd2c04fe2-c362-3c0a-ab19-67615339f7ee', 'https://photos.mendeley.com/75/1e/751ed52587b409dd024e4dda51a32ed2bb8f007a.png', 'Masters Student', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_disciplines`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_disciplines` (
  `researcher_id` int(11) NOT NULL,
  `discipline_id` int(11) NOT NULL,
  KEY `FKaop4mqc7p60pj7ojdctcod69m` (`discipline_id`),
  KEY `FK3cljndx53oh3fhog3r3pcqlae` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `core_agents_researchers_disciplines`
--

INSERT INTO `core_agents_researchers_disciplines` (`researcher_id`, `discipline_id`) VALUES
(1, 7),
(8, 1),
(11, 1),
(12, 1),
(13, 1),
(13, 29),
(14, 29),
(14, 1),
(15, 29),
(15, 1),
(16, 29),
(16, 1),
(17, 1),
(17, 29),
(18, 29),
(18, 1),
(19, 7);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_institutions`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_institutions` (
  `researcher_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  KEY `FK4wlj79hpje54w1yhctjronm5t` (`institution_id`),
  KEY `FKnjibjwyfx0du85ecdpc8fbyql` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `core_agents_researchers_institutions`
--

INSERT INTO `core_agents_researchers_institutions` (`researcher_id`, `institution_id`) VALUES
(1, 1),
(8, 2),
(11, 2),
(12, 4),
(13, 2),
(14, 3),
(15, 4),
(16, 2),
(17, 4),
(18, 2),
(19, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_interests`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_interests` (
  `researcher_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  KEY `FKr2qbtbwm9j8ovy2ssgulkv1e2` (`interest_id`),
  KEY `FKnh6mjtvpkjbia7pheato1wreb` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `core_agents_researchers_interests`
--

INSERT INTO `core_agents_researchers_interests` (`researcher_id`, `interest_id`) VALUES
(1, 2),
(1, 1),
(8, 10),
(8, 9),
(8, 8),
(11, 11),
(11, 12),
(11, 13),
(12, 14),
(12, 15),
(12, 13),
(12, 9),
(12, 16),
(12, 17),
(13, 11),
(13, 9),
(14, 18),
(14, 9),
(14, 19),
(15, 17),
(15, 20),
(15, 21),
(15, 22),
(15, 24),
(15, 25),
(15, 26),
(15, 27),
(16, 12),
(16, 28),
(16, 29),
(17, 12),
(17, 8),
(17, 27),
(18, 12),
(18, 30),
(18, 31),
(19, 1),
(19, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_keywords`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_keywords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `year` varchar(255) DEFAULT NULL,
  `researcher_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbysyrmdwrxoud8bteeejyfyyp` (`researcher_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `core_agents_researchers_keywords`
--

INSERT INTO `core_agents_researchers_keywords` (`id`, `name`, `year`, `researcher_id`) VALUES
(1, 'complex network', '2017', 1),
(2, 'e-science', '2017', 1),
(3, 'provenance', '2017', 1),
(4, 'visualization', '2017', 1),
(5, 'ontology', '2017', 1),
(6, 'scientific experiment', '2017', 1),
(7, 'scientific workflow', '2017', 1),
(8, 'complex network', '2017', 1),
(9, 'e-science', '2017', 1),
(10, 'provenance', '2017', 1),
(11, 'visualization', '2017', 1),
(12, 'complex network', '2017', 1),
(13, 'e-science', '2017', 1),
(14, 'provenance', '2017', 1),
(15, 'visualization', '2017', 1),
(16, 'complex network', '2017', 1),
(17, 'e-science', '2017', 1),
(18, 'provenance', '2017', 1),
(19, 'visualization', '2017', 1),
(20, 'complex network', '2017', 1),
(21, 'e-science', '2017', 1),
(22, 'provenance', '2017', 1),
(23, 'visualization', '2017', 1),
(24, 'complex network', '2017', 19),
(25, 'e-science', '2017', 19),
(26, 'provenance', '2017', 19),
(27, 'visualization', '2017', 19);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_cities`
--

CREATE TABLE IF NOT EXISTS `core_cities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `state_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_6ivyhwdpu1fxm1m97g2qawr8o` (`name`),
  KEY `FKr4n74h5yvj373tnllfn8y777x` (`state_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Extraindo dados da tabela `core_cities`
--

INSERT INTO `core_cities` (`id`, `name`, `state_id`) VALUES
(1, 'Rio Branco', 1),
(2, 'Maceió', 2),
(3, 'Macapá', 3),
(4, 'Manaus', 4),
(5, 'Salvador', 5),
(6, 'Fortaleza', 6),
(7, 'Brasília', 7),
(8, 'Vitória', 8),
(9, 'Goiânia', 9),
(10, 'São Luís', 10),
(11, 'Cuiabá', 11),
(12, 'Campo Grande', 12),
(13, 'Belo Horizonte', 13),
(14, 'Belém', 14),
(15, 'João Pessoa', 15),
(16, 'Curitiba', 16),
(17, 'Recife', 17),
(18, 'Teresina', 18),
(19, 'Rio de Janeiro', 19),
(20, 'Natal', 20),
(21, 'Porto Alegre', 21),
(22, 'Porto Velho', 22),
(23, 'Boa Vista', 23),
(24, 'Florianópolis', 24),
(25, 'São Paulo', 25),
(26, 'Aracaju', 26),
(27, 'Palmas', 27),
(28, 'Juiz de Fora', 13),
(29, 'Itapetinga', 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_countries`
--

CREATE TABLE IF NOT EXISTS `core_countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_c6cc4ik7w6okhs21nt6f44650` (`code`),
  UNIQUE KEY `UK_pp4fmuelxg7uksfdfnkoofkog` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=248 ;

--
-- Extraindo dados da tabela `core_countries`
--

INSERT INTO `core_countries` (`id`, `code`, `name`) VALUES
(1, 'AF', 'Afghanistan'),
(2, 'AX', 'AlandIslands'),
(3, 'AL', 'Albania'),
(4, 'DZ', 'Algeria'),
(5, 'AS', 'AmericanSamoa'),
(6, 'AD', 'Andorra'),
(7, 'AO', 'Angola'),
(8, 'AI', 'Anguilla'),
(9, 'AQ', 'Antarctica'),
(10, 'AG', 'AntiguaandBarbuda'),
(11, 'AR', 'Argentina'),
(12, 'AM', 'Armenia'),
(13, 'AW', 'Aruba'),
(14, 'AU', 'Australia'),
(15, 'AT', 'Austria'),
(16, 'AZ', 'Azerbaijan'),
(17, 'BS', 'Bahamas'),
(18, 'BH', 'Bahrain'),
(19, 'BD', 'Bangladesh'),
(20, 'BB', 'Barbados'),
(21, 'BY', 'Belarus'),
(22, 'BE', 'Belgium'),
(23, 'BZ', 'Belize'),
(24, 'BJ', 'Benin'),
(25, 'BM', 'Bermuda'),
(26, 'BT', 'Bhutan'),
(27, 'BO', 'Bolivia'),
(28, 'BA', 'BosniaandHerzegovina'),
(29, 'BW', 'Botswana'),
(30, 'BV', 'BouvetIsland'),
(31, 'BR', 'Brazil'),
(32, 'VG', 'BritishVirginIslands'),
(33, 'IO', 'BritishIndianOceanTerritory'),
(34, 'BN', 'BruneiDarussalam'),
(35, 'BG', 'Bulgaria'),
(36, 'BF', 'BurkinaFaso'),
(37, 'BI', 'Burundi'),
(38, 'KH', 'Cambodia'),
(39, 'CM', 'Cameroon'),
(40, 'CA', 'Canada'),
(41, 'CV', 'CapeVerde'),
(42, 'KY', 'CaymanIslands'),
(43, 'CF', 'CentralAfricanRepublic'),
(44, 'TD', 'Chad'),
(45, 'CL', 'Chile'),
(46, 'CN', 'China'),
(47, 'HK', 'HongKong,SARChina'),
(48, 'MO', 'Macao,SARChina'),
(49, 'CX', 'ChristmasIsland'),
(50, 'CC', 'Cocos(Keeling)Islands'),
(51, 'CO', 'Colombia'),
(52, 'KM', 'Comoros'),
(53, 'CG', 'Congo (Brazzaville)'),
(54, 'CD', 'Congo,(Kinshasa)'),
(55, 'CK', 'CookIslands'),
(56, 'CR', 'CostaRica'),
(57, 'CI', 'Côted''Ivoire'),
(58, 'HR', 'Croatia'),
(59, 'CU', 'Cuba'),
(60, 'CY', 'Cyprus'),
(61, 'CZ', 'CzechRepublic'),
(62, 'DK', 'Denmark'),
(63, 'DJ', 'Djibouti'),
(64, 'DM', 'Dominica'),
(65, 'DO', 'DominicanRepublic'),
(66, 'EC', 'Ecuador'),
(67, 'EG', 'Egypt'),
(68, 'SV', 'ElSalvador'),
(69, 'GQ', 'EquatorialGuinea'),
(70, 'ER', 'Eritrea'),
(71, 'EE', 'Estonia'),
(72, 'ET', 'Ethiopia'),
(73, 'FK', 'FalklandIslands(Malvinas)'),
(74, 'FO', 'FaroeIslands'),
(75, 'FJ', 'Fiji'),
(76, 'FI', 'Finland'),
(77, 'FR', 'France'),
(78, 'GF', 'FrenchGuiana'),
(79, 'PF', 'FrenchPolynesia'),
(80, 'TF', 'FrenchSouthernTerritories'),
(81, 'GA', 'Gabon'),
(82, 'GM', 'Gambia'),
(83, 'GE', 'Georgia'),
(84, 'DE', 'Germany'),
(85, 'GH', 'Ghana'),
(86, 'GI', 'Gibraltar'),
(87, 'GR', 'Greece'),
(88, 'GL', 'Greenland'),
(89, 'GD', 'Grenada'),
(90, 'GP', 'Guadeloupe'),
(91, 'GU', 'Guam'),
(92, 'GT', 'Guatemala'),
(93, 'GG', 'Guernsey'),
(94, 'GN', 'Guinea'),
(95, 'GW', 'Guinea-Bissau'),
(96, 'GY', 'Guyana'),
(97, 'HT', 'Haiti'),
(98, 'HM', 'HeardandMcdonaldIslands'),
(99, 'VA', 'HolySee (VaticanCityState)'),
(100, 'HN', 'Honduras'),
(101, 'HU', 'Hungary'),
(102, 'IS', 'Iceland'),
(103, 'IN', 'India'),
(104, 'ID', 'Indonesia'),
(105, 'IR', 'Iran,IslamicRepublicof'),
(106, 'IQ', 'Iraq'),
(107, 'IE', 'Ireland'),
(108, 'IM', 'IsleofMan'),
(109, 'IL', 'Israel'),
(110, 'IT', 'Italy'),
(111, 'JM', 'Jamaica'),
(112, 'JP', 'Japan'),
(113, 'JE', 'Jersey'),
(114, 'JO', 'Jordan'),
(115, 'KZ', 'Kazakhstan'),
(116, 'KE', 'Kenya'),
(117, 'KI', 'Kiribati'),
(118, 'KP', 'Korea (North)'),
(119, 'KR', 'Korea (South)'),
(120, 'KW', 'Kuwait'),
(121, 'KG', 'Kyrgyzstan'),
(122, 'LA', 'LaoPDR'),
(123, 'LV', 'Latvia'),
(124, 'LB', 'Lebanon'),
(125, 'LS', 'Lesotho'),
(126, 'LR', 'Liberia'),
(127, 'LY', 'Libya'),
(128, 'LI', 'Liechtenstein'),
(129, 'LT', 'Lithuania'),
(130, 'LU', 'Luxembourg'),
(131, 'MK', 'Macedonia,Republicof'),
(132, 'MG', 'Madagascar'),
(133, 'MW', 'Malawi'),
(134, 'MY', 'Malaysia'),
(135, 'MV', 'Maldives'),
(136, 'ML', 'Mali'),
(137, 'MT', 'Malta'),
(138, 'MH', 'MarshallIslands'),
(139, 'MQ', 'Martinique'),
(140, 'MR', 'Mauritania'),
(141, 'MU', 'Mauritius'),
(142, 'YT', 'Mayotte'),
(143, 'MX', 'Mexico'),
(144, 'FM', 'Micronesia,FederatedStatesof'),
(145, 'MD', 'Moldova'),
(146, 'MC', 'Monaco'),
(147, 'MN', 'Mongolia'),
(148, 'ME', 'Montenegro'),
(149, 'MS', 'Montserrat'),
(150, 'MA', 'Morocco'),
(151, 'MZ', 'Mozambique'),
(152, 'MM', 'Myanmar'),
(153, 'NA', 'Namibia'),
(154, 'NR', 'Nauru'),
(155, 'NP', 'Nepal'),
(156, 'NL', 'Netherlands'),
(157, 'AN', 'NetherlandsAntilles'),
(158, 'NC', 'NewCaledonia'),
(159, 'NZ', 'NewZealand'),
(160, 'NI', 'Nicaragua'),
(161, 'NE', 'Niger'),
(162, 'NG', 'Nigeria'),
(163, 'NU', 'Niue'),
(164, 'NF', 'NorfolkIsland'),
(165, 'MP', 'NorthernMarianaIslands'),
(166, 'NO', 'Norway'),
(167, 'OM', 'Oman'),
(168, 'PK', 'Pakistan'),
(169, 'PW', 'Palau'),
(170, 'PS', 'PalestinianTerritory'),
(171, 'PA', 'Panama'),
(172, 'PG', 'PapuaNewGuinea'),
(173, 'PY', 'Paraguay'),
(174, 'PE', 'Peru'),
(175, 'PH', 'Philippines'),
(176, 'PN', 'Pitcairn'),
(177, 'PL', 'Poland'),
(178, 'PT', 'Portugal'),
(179, 'PR', 'PuertoRico'),
(180, 'QA', 'Qatar'),
(181, 'RE', 'Réunion'),
(182, 'RO', 'Romania'),
(183, 'RU', 'RussianFederation'),
(184, 'RW', 'Rwanda'),
(185, 'BL', 'Saint-Barthélemy'),
(186, 'SH', 'SaintHelena'),
(187, 'KN', 'SaintKittsandNevis'),
(188, 'LC', 'SaintLucia'),
(189, 'MF', 'Saint-Martin(Frenchpart)'),
(190, 'PM', 'SaintPierreandMiquelon'),
(191, 'VC', 'SaintVincentandGrenadines'),
(192, 'WS', 'Samoa'),
(193, 'SM', 'SanMarino'),
(194, 'ST', 'SaoTomeandPrincipe'),
(195, 'SA', 'SaudiArabia'),
(196, 'SN', 'Senegal'),
(197, 'RS', 'Serbia'),
(198, 'SC', 'Seychelles'),
(199, 'SL', 'SierraLeone'),
(200, 'SG', 'Singapore'),
(201, 'SK', 'Slovakia'),
(202, 'SI', 'Slovenia'),
(203, 'SB', 'SolomonIslands'),
(204, 'SO', 'Somalia'),
(205, 'ZA', 'SouthAfrica'),
(206, 'GS', 'SouthGeorgiaandtheSouthSandwichIslands'),
(207, 'SS', 'SouthSudan'),
(208, 'ES', 'Spain'),
(209, 'LK', 'SriLanka'),
(210, 'SD', 'Sudan'),
(211, 'SR', 'Suriname'),
(212, 'SJ', 'SvalbardandJanMayenIslands'),
(213, 'SZ', 'Swaziland'),
(214, 'SE', 'Sweden'),
(215, 'CH', 'Switzerland'),
(216, 'SY', 'SyrianArabRepublic (Syria)'),
(217, 'TW', 'Taiwan,RepublicofChina'),
(218, 'TJ', 'Tajikistan'),
(219, 'TZ', 'Tanzania,UnitedRepublicof'),
(220, 'TH', 'Thailand'),
(221, 'TL', 'Timor-Leste'),
(222, 'TG', 'Togo'),
(223, 'TK', 'Tokelau'),
(224, 'TO', 'Tonga'),
(225, 'TT', 'TrinidadandTobago'),
(226, 'TN', 'Tunisia'),
(227, 'TR', 'Turkey'),
(228, 'TM', 'Turkmenistan'),
(229, 'TC', 'TurksandCaicosIslands'),
(230, 'TV', 'Tuvalu'),
(231, 'UG', 'Uganda'),
(232, 'UA', 'Ukraine'),
(233, 'AE', 'UnitedArabEmirates'),
(234, 'GB', 'UnitedKingdom'),
(235, 'US', 'UnitedStatesofAmerica'),
(236, 'UM', 'USMinorOutlyingIslands'),
(237, 'UY', 'Uruguay'),
(238, 'UZ', 'Uzbekistan'),
(239, 'VU', 'Vanuatu'),
(240, 'VE', 'Venezuela (BolivarianRepublic)'),
(241, 'VN', 'VietNam'),
(242, 'VI', 'VirginIslands,US'),
(243, 'WF', 'WallisandFutunaIslands'),
(244, 'EH', 'WesternSahara'),
(245, 'YE', 'Yemen'),
(246, 'ZM', 'Zambia'),
(247, 'ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_disciplines`
--

CREATE TABLE IF NOT EXISTS `core_disciplines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKci04mmvbc7f2kf2rjr38xtodp` (`parent`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

--
-- Extraindo dados da tabela `core_disciplines`
--

INSERT INTO `core_disciplines` (`id`, `name`, `parent`) VALUES
(1, 'Agricultural and Biological Sciences', NULL),
(2, 'Arts and Humanities', NULL),
(3, 'Biochemistry, Genetics and Molecular Biology', NULL),
(4, 'Business, Management and Accounting', NULL),
(5, 'Chemical Engineering', NULL),
(6, 'Chemistry', NULL),
(7, 'Computer Science', NULL),
(8, 'Decision Sciences', NULL),
(9, 'Design', NULL),
(10, 'Earth and Planetary Sciences', NULL),
(11, 'Economics, Econometrics and Finance', NULL),
(12, 'Energy', NULL),
(13, 'Engineering', NULL),
(14, 'Environmental Science', NULL),
(15, 'Immunology and Microbiology', NULL),
(16, 'Linguistics', NULL),
(17, 'Materials Science', NULL),
(18, 'Mathematics', NULL),
(19, 'Medicine and Dentistry', NULL),
(20, 'Neuroscience', NULL),
(21, 'Nursing and Health Professions', NULL),
(22, 'Pharmacology, Toxicology and Pharmaceutical Science', NULL),
(23, 'Philosophy', NULL),
(24, 'Physics and Astronomy', NULL),
(25, 'Psychology', NULL),
(26, 'Social Sciences', NULL),
(27, 'Sports and Recreations', NULL),
(28, 'Unspecified', NULL),
(29, 'Veterinary Science and Veterinary Medicine', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_institutions`
--

CREATE TABLE IF NOT EXISTS `core_institutions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `city_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKm24ugeiqnr5535qfa9eta6c6y` (`city_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `core_institutions`
--

INSERT INTO `core_institutions` (`id`, `name`, `city_id`) VALUES
(1, 'Universidade Federal de Juiz de Fora', 28),
(2, 'Universidade Federal de  Minas Gerais', 13),
(3, 'Universidade Estadual do Sudoeste da Bahia', 29),
(4, 'Empresa Brasileira de Pesquisa Agropecuária - EMBRAPA', 28),
(5, 'Federal University of Juiz de Fora', 28);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_interests`
--

CREATE TABLE IF NOT EXISTS `core_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=32 ;

--
-- Extraindo dados da tabela `core_interests`
--

INSERT INTO `core_interests` (`id`, `name`) VALUES
(1, 'Context awareness'),
(2, 'Data provenance'),
(15, 'Laticínios'),
(14, 'Nutrição animal'),
(13, 'Produção de leite'),
(12, 'Reprodução animal'),
(11, 'Criação de bezerros'),
(8, 'Zootecnia'),
(9, 'Produção animal'),
(10, 'Bovinocultura'),
(16, 'Rúmen'),
(17, 'Nutrição de ruminantes'),
(18, 'Produção de ruminates'),
(19, 'Eficiência alimentar'),
(20, 'Avaliação de alimentos'),
(21, 'Conservação de forragens'),
(22, 'Bioenergética e Exigências Nutricionais de Bovinos Leiteiros'),
(23, 'Gases de Efeito Estufa na Pecuária'),
(24, 'Técnicas de digestibilidade para ruminantes'),
(25, 'Pastagens e forragicultura'),
(26, 'Avaliação de alimentos para ruminantes'),
(27, 'Nutrição e alimentação animal'),
(28, 'Inseminação Artificial Animal'),
(29, ' Fisiopatologia da Reprodução Animal'),
(30, 'Melhoramento Animal'),
(31, 'Manejo de rebanho');

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_research_groups`
--

CREATE TABLE IF NOT EXISTS `core_research_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `name` varchar(255) DEFAULT NULL,
  `web_page` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `core_research_groups`
--

INSERT INTO `core_research_groups` (`id`, `description`, `name`, `web_page`) VALUES
(1, 'Seu objetivo é contribuir para a construção articulada de saberes e práticas no campo da Zootecnia, produzindo, inovando, conservando e disseminando conhecimentos. Nos níveis de mestrado e doutorado, o programa visa a formação crítica de docentes e pesquisadores comprometidos com a ética, o trabalho e o desenvolvimento científico, preparados para a aplicação da ciência na interpretação e solução de problemas, com desdobramentos econômicos, ambientais, tecnológicos e sociais.', 'Programa de Pós-Graduação em Zootecnia da Escola de Veterinária da Universidade Federal de Minas Gerais', 'https://vet.ufmg.br/ensino_posgraduacao/posgraduacao/4_20100115105020'),
(2, 'A Embrapa Gado de Leite é uma das 42 Unidades Descentralizadas da Empresa Brasileira de Pesquisa Agropecuária (Embrapa), vinculada ao Ministério da Agricultura, Pecuária e Abastecimento (MAPA). O centro de pesquisa foi criado em 26 de outubro de 1974, no município de Coronel Pacheco (MG).\r\n\r\nHoje está sediado em Juiz de Fora (MG) e possui campos experimentais em Coronel Pacheco (MG) e Valença (RJ), além de quatro núcleos que apoiam as atividades de transferência de tecnologia em cada região do país.\r\n\r\nO corpo técnico é formado por 318 empregados, sendo 77 pesquisadores, 76 analistas, 39 técnicos e 126 assistentes. Entre os pesquisadores e analistas, 60% possuem doutorado ou pós-doutorado; 20% mestrado e 20% especialização ou graduação.\r\n\r\nA Unidade tem se consolidado como referência mundial em pesquisas para pecuária leiteira de clima tropical. Isso é resultado dos conhecimentos e tecnologias inovadoras para o setor produtivo, que se traduzem em ganhos para toda a sociedade.', 'EMBRAPA Gado de Leite', 'https://www.embrapa.br/gado-de-leite'),
(3, 'A Escola de Veterinária da UFMG, fundada em 1932, ocupa prédio próprio no campus Pampulha desde 1974. Atualmente, oferece dois cursos de graduação, Medicina Veterinária e Aquacultura. Na pós-graduação são oferecidos os cursos de mestrado e doutorado em Ciência Animal e Zootecnia, além da Residência em Medicina Veterinária.\r\n\r\nCom uma área de 7 hectares, a Escola se divide em quatro departamentos: Clínica e Cirurgia Veterinárias (DCCV), Medicina Veterinária Preventiva (DMVP), Tecnologia e Inspeção de Produtos de Origem Animal (DTIPOA) e Zootecnia (DZOO).\r\n\r\nA administração da Escola é realizada pela Diretoria e pelos órgãos colegiados da instituição, a saber a Congregação, as Câmaras Departamentais e os colegiados de graduação e pós-graduação. Além disso, tem estruturas de apoio, como Secretaria Geral, Assessoria Administrativa, Assessoria de RH, Gerência Ambiental e de Biossegurança, Seções de Pessoal, Compras, Contabilidade e Patrimônio, Serviços Gerais, Laboratório de Suporte e Manutenção de Computadores.\r\n\r\nA unidade conta ainda com uma assessoria de comunicação própria e uma editora, responsável pela publicação de diversos materiais, entre eles os Cadernos Técnicos de Medicina Veterinária e Zootecnia e o Arquivo Brasileiro de Medicina Veterinária e Zootecnia, um dos periódicos científicos, da área, mais importante no país.\r\n\r\nA Escola de Veterinária possui três órgãos complementares. O Hospital Veterinário se localiza na própria Escola e atende grandes e pequenos animais nas áreas de clínica e cirurgia, com competência em áreas de alta especialização, como dermatologia e ortopedia de animais de companhia. A Fazenda Experimental Prof. Hélio Barbosa, localizada no município de Igarapé, dá suporte ao ensino de graduação e pós-graduação, além de realizar atividades de pesquisa e extensão em áreas como a bovinocultura de leite, avicultura de postura e corte, coturnicultura (criação de codornas), cunicultura (criação de coelhos), forragicultura, equinocultura e suinocultura. E o Laqua - Laboratório de Aquacultura, que conta com cerca de 80 mil animais, entre peixes e camarões. ', 'Escola de Veterinária da UFMG', 'https://vet.ufmg.br/'),
(4, 'O Programa de Pós-Graduação em Zootecnia da Universidade Estadual do Sudoeste da Bahia oferece os cursos de Mestrado e Doutorado em Zootecnia com Área de Concentração em Produção de Ruminantes, dispondo vagas para o Mestrado e  Doutorado previstas conforme edital. O programa é destinado aos profissionais com diploma de Curso Superior em Zootecnia, Agronomia e Veterinária, para o Mestrado e diploma de Mestrado na área de Ciências Agrárias, para o Doutorado, tendo como objetivo formação de pessoal qualificado para o exercício de atividades de ensino, de pesquisa e de desenvolvimento na área Zootécnica.', 'Programa de Pós-Graduação em Zootecnia da Universidade Estadual do Sudoeste da Bahia', 'http://www2.uesb.br/ppg/ppz/');

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_research_group_researcher`
--

CREATE TABLE IF NOT EXISTS `core_research_group_researcher` (
  `research_group_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  KEY `FKmp014i6g70kmem7j7k0um55ge` (`researcher_id`),
  KEY `FKdwlqyjavrshab1xhd5wrgut5n` (`research_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `core_research_group_researcher`
--

INSERT INTO `core_research_group_researcher` (`research_group_id`, `researcher_id`) VALUES
(1, 8),
(3, 8),
(3, 11),
(2, 12),
(4, 14),
(2, 15);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_states`
--

CREATE TABLE IF NOT EXISTS `core_states` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `capital_id` int(11) DEFAULT NULL,
  `country_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_evs3m0995aphx73eacn09rh0j` (`code`),
  UNIQUE KEY `UK_3i9bpujt632hy8sgefetumy1o` (`name`),
  KEY `FKqvbfm1xx841ggoffqcevyxbgw` (`capital_id`),
  KEY `FKrxrh3rp1wy2qnr4feqp2ackxt` (`country_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `core_states`
--

INSERT INTO `core_states` (`id`, `code`, `name`, `capital_id`, `country_id`) VALUES
(1, 'AC', 'Acre', 1, 31),
(2, 'AL', 'Alagoas', 2, 31),
(3, 'AP', 'Amapá', 3, 31),
(4, 'AM', 'Amazonas', 4, 31),
(5, 'BA', 'Bahia', 5, 31),
(6, 'CE', 'Ceará', 6, 31),
(7, 'DF', 'Distrito Federal', 7, 31),
(8, 'ES', 'Espírito Santo', 8, 31),
(9, 'GO', 'Goiás', 9, 31),
(10, 'MA', 'Maranhão', 10, 31),
(11, 'MT', 'Mato Grosso', 11, 31),
(12, 'MS', 'Mato Grosso do Sul', 12, 31),
(13, 'MG', 'Minas Gerais', 13, 31),
(14, 'PA', 'Pará', 14, 31),
(15, 'PB', 'Paraíba', 15, 31),
(16, 'PR', 'Paraná', 16, 31),
(17, 'PE', 'Pernambuco', 17, 31),
(18, 'PI', 'Piauí', 18, 31),
(19, 'RJ', 'Rio de Janeiro', 19, 31),
(20, 'RN', 'Rio Grande do Norte', 20, 31),
(21, 'RS', 'Rio Grande do Sul', 21, 31),
(22, 'RO', 'Rondônia', 22, 31),
(23, 'RR', 'Roraima', 23, 31),
(24, 'SC', 'Santa Catarina', 24, 31),
(25, 'SP', 'São Paulo', 25, 31),
(26, 'SE', 'Sergipe', 26, 31),
(27, 'TO', 'Tocantins', 27, 31);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activities`
--

CREATE TABLE IF NOT EXISTS `exp_activities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `description` text,
  `name` varchar(255) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKknhvi932iavpyc4jvbgb860ij` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Extraindo dados da tabela `exp_activities`
--

INSERT INTO `exp_activities` (`id`, `date_created`, `description`, `name`, `author_id`) VALUES
(1, '2018-06-05', 'Escolher e preparar os animais para o experimento.', 'Seleção de animais', 8),
(2, '2018-06-05', 'Período de adaptação dos animais as instalações e dieta.', 'Adaptação dos animais', 8),
(3, '2018-06-05', 'Período em que os animais ficam confinados e os dados referentes a cada animal são medidos de acordo com a periodicidade determinada.', 'Coleta dos dados', 8),
(4, '2018-06-05', 'Cálculo  do consumo alimentar residual (CAR)', 'Cálculo CAR', 8),
(5, '2018-06-05', 'Cálculo do ganho de peso residual (GPR)', 'Cálculo GPR', 8),
(6, '2018-06-05', 'Classificação dos animais como mais eficientes e menos eficientes de acordo com o índice selecionado.', 'Classificação dos animais', 8),
(11, '2018-06-16', 'Cálculo do índice de consumo alimentar residual (CAR) dos animais.', 'Cálculo CAR', 14),
(12, '2018-06-16', 'Cálculo do índice de ganho de peso residual (GPR) dos animais.', 'Cálculo GPR', 14),
(13, '2018-06-16', 'Cálculo do índice de eficiência de conversão alimentar (ECA) dos animais.', 'Cálculo ECA', 14),
(14, '2018-06-16', 'Classificação dos animais de acordo com os resultados obtidos nos índices CAR, GPR e ECA.', 'Classificação dos animais', 14),
(15, '2018-06-16', 'Avaliar a relação entre a classificação fenotípica divergente para o CAR, GPR e ECA com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.', 'Análise dos resultados', 14),
(18, '2018-06-17', 'Cálculo do Consumo alimentar Residual (CAR) dos animais.', 'Cálculo do CAR', 16),
(19, '2018-06-17', 'Classificação dos animais em 3 grupos de CAR.', 'Classificação de acordo com CAR', 16),
(20, '2018-06-17', 'Analisar os dados coletados, e realizar comparações.', 'Avaliação dos resultados obtidos', 16),
(21, '2018-07-12', 'Análise e comparação dos valores de EA obtidos.', 'Análise dos resultados', 8);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activities_workflowservices`
--

CREATE TABLE IF NOT EXISTS `exp_activities_workflowservices` (
  `activity_id` int(11) NOT NULL,
  `workflowservice_id` int(11) NOT NULL,
  KEY `FKlfri0mlyljcchw69d0ww7lwva` (`workflowservice_id`),
  KEY `FKkt0tkhnlip2yrjog52hc55qqh` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_detail`
--

CREATE TABLE IF NOT EXISTS `exp_activity_detail` (
  `activity_id` int(11) NOT NULL,
  `detail_id` int(11) NOT NULL,
  UNIQUE KEY `UK_9p8nagsaqsb1polyd2kkorb1g` (`detail_id`),
  KEY `FKg94xk6vxyu4hlk4iy64nq14sx` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_executions`
--

CREATE TABLE IF NOT EXISTS `exp_activity_executions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `end_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `activity` int(11) NOT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKi6j19dn15qjhbgvvimgkuwbpw` (`activity`),
  KEY `FKqlj8imgp9b5848dule4ioqkvo` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Extraindo dados da tabela `exp_activity_executions`
--

INSERT INTO `exp_activity_executions` (`id`, `end_time`, `start_time`, `activity`, `author_id`) VALUES
(6, '2018-06-15 12:43:00', '2018-06-15 12:43:00', 3, 8),
(5, '2018-06-15 12:43:00', '2018-06-15 11:43:00', 2, 8),
(4, '2018-06-15 09:42:00', '2018-06-15 08:42:00', 1, 8),
(7, '2018-06-15 14:44:00', '2018-06-15 13:43:00', 4, 8),
(8, '2018-06-15 02:44:00', '2018-06-15 01:44:00', 5, 8),
(9, '2018-06-15 04:40:00', '2018-06-15 05:40:00', 6, 8),
(13, '2018-06-16 21:47:00', '2018-06-16 20:47:00', 11, 14),
(14, '2018-06-16 21:48:00', '2018-06-16 20:48:00', 12, 14),
(15, '2018-06-16 21:48:00', '2018-06-16 20:48:00', 13, 14),
(16, '2018-06-16 20:03:00', '2018-06-16 21:02:00', 14, 14),
(17, '2018-06-16 23:02:00', '2018-06-16 23:00:00', 15, 14),
(20, '2018-06-17 19:40:00', '2018-06-17 19:39:00', 18, 16),
(21, '2018-06-17 20:41:00', '2018-06-17 20:40:00', 19, 16),
(22, '2018-06-17 21:42:00', '2018-06-17 21:41:00', 20, 16);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_inputs`
--

CREATE TABLE IF NOT EXISTS `exp_activity_inputs` (
  `activity_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  KEY `FKlycvy5395xctc2cc8qjw7vwsl` (`port_id`),
  KEY `FK8iyfqt6yrvbp4ce285l8sa2v8` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_activity_inputs`
--

INSERT INTO `exp_activity_inputs` (`activity_id`, `port_id`) VALUES
(6, 4),
(7, 1),
(8, 1),
(9, 3),
(9, 2),
(13, 1),
(14, 1),
(15, 1),
(16, 10),
(16, 11),
(16, 12),
(17, 9),
(17, 13),
(17, 14),
(17, 15),
(20, 1),
(21, 19),
(22, 18),
(22, 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_outputs`
--

CREATE TABLE IF NOT EXISTS `exp_activity_outputs` (
  `activity_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  KEY `FK1t6g6i4xtt0150n2x7ropk0m1` (`port_id`),
  KEY `FKsxoc2ds8xl42dcdl52jdrxmwn` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_activity_outputs`
--

INSERT INTO `exp_activity_outputs` (`activity_id`, `port_id`) VALUES
(4, 4),
(6, 1),
(7, 2),
(8, 3),
(9, 6),
(9, 5),
(12, 1),
(13, 10),
(14, 11),
(15, 12),
(16, 13),
(16, 14),
(16, 15),
(19, 18),
(20, 19),
(21, 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_detail`
--

CREATE TABLE IF NOT EXISTS `exp_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=59 ;

--
-- Extraindo dados da tabela `exp_detail`
--

INSERT INTO `exp_detail` (`id`, `description`, `name`) VALUES
(1, '36', 'Número de animais'),
(4, 'Girolando F1', 'Raça'),
(12, '75:25, silagem de milho: concentrado, em base de MS', 'Dieta'),
(5, '± 28,2 dias', 'Idade inicial média'),
(6, '±21,7 kg', 'Peso vivo inicial'),
(7, '4', 'Numero de piquetes'),
(8, 'Homogênea de acordo com o peso corporal e idade', 'Distribuição'),
(9, 'Três alimentadores eletrônicos e um bebedouro eletrônico', 'Equipamentos por piquete'),
(10, '28 dias', 'Período de adaptação'),
(11, '113 dias', 'Período de teste'),
(13, 'diário', 'Período de medição da ingestão da dieta'),
(14, 'diário', 'Período de medição da ingestão da água'),
(15, 'semanal', 'Período de medição do peso vivo'),
(16, 'quinzenal', 'Período de medição da altura de cernelha e quadril (AQ), largura entre íleos, profundidade corporal (PC) e circunferência do tórax (CT)'),
(17, 'Consumo Alimentar Residual (CAR) e Ganho de Peso Residual (GPR)', 'Índices utilizados'),
(18, '2', 'Número de grupos para classificação'),
(32, '75:25, silagem de milho: concentrado, em base de MS', 'Dieta'),
(31, 'Girolando F1', 'Raça'),
(30, '35', 'Número de animais'),
(51, '3', 'Número de grupos para classificação'),
(36, 'Tie stall', 'Alojamento'),
(38, '10 dias', 'Período de adaptação'),
(39, '2 dias', 'Período coleta total de urina'),
(50, 'pós-desaleitamento (PD) e pós-puberdade (PP)', 'Fases utilizadas para cálculo do CAR'),
(41, 'Dois períodos de 24h', 'Período de medição das trocas respiratórias'),
(47, '35', 'Número de animais'),
(42, 'Consumo Alimentar Residual (CAR), Ganho de Peso Residual (GPR) e Eficiência de Conversão Alimentar (ECA)', 'Índices utilizados'),
(43, '2', 'Número de grupos para classificação'),
(44, '25 dias', 'Período de teste'),
(45, '5 dias', 'Período coleta total de fezes'),
(46, 'Piquetes', 'Alojamento'),
(48, 'Girolando F1', 'Raça'),
(49, 'Consumo Alimentar Residual (CAR)', 'Índices utilizados'),
(52, '± 30,49 dias a ± 30,2 dias', 'Idade pós-desaleitamento média'),
(53, '± 27,8 dias a ± 27,8 Dias', 'Idade pós-puberdade média'),
(54, 'semanal', 'Período das coletas de sangue'),
(55, 'a cada 14 dias', 'Período de avaliações ginecologias '),
(56, '75:25, silagem de milho: concentrado, em base de MS', 'Dieta'),
(57, 'diário', 'Período de medição da ingestão da dieta'),
(58, 'semanal', 'Período de medição do peso vivo');

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_entities`
--

CREATE TABLE IF NOT EXISTS `exp_entities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `author_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK699fd14d82vuqdi3jdb0i8ql1` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=41 ;

--
-- Extraindo dados da tabela `exp_entities`
--

INSERT INTO `exp_entities` (`id`, `name`, `author_id`) VALUES
(23, 'Dados Coletados', 8),
(24, 'Planilha CAR', 8),
(25, 'Planilha GPR', 8),
(26, 'Lista de animais selecionados', 8),
(27, 'Planilha classificação para CAR', 8),
(28, 'Planilha Classificação para GPR', 8),
(29, 'Dados coletados durante o ensaio', 14),
(30, 'Valores CAR', 14),
(31, 'Valores GPR', 14),
(32, 'Valores ECA', 14),
(33, 'Classificação para CAR', 14),
(34, 'Classificação para GPR', 14),
(35, 'Classificação para ECA', 14),
(38, 'Parâmetros coletados', 16),
(39, 'Valores Consumo Alimentar Residual CAR', 16),
(40, 'Classificação para CAR em 3 grupos', 16);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_entities_data`
--

CREATE TABLE IF NOT EXISTS `exp_entities_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `value` text,
  `entity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKj153csisgfpd3u6orjwt7dj2c` (`entity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_entities_documents`
--

CREATE TABLE IF NOT EXISTS `exp_entities_documents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `value` text,
  `entity_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6lchls351ad1dhnlqen5xu3c3` (`entity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=36 ;

--
-- Extraindo dados da tabela `exp_entities_documents`
--

INSERT INTO `exp_entities_documents` (`id`, `file`, `type`, `value`, `entity_id`) VALUES
(21, '/var/www/eseco/documents/author_8/CAR.xlsx', NULL, NULL, 24),
(22, '/var/www/eseco/documents/author_8/GPR.xlsx', NULL, NULL, 25),
(20, '/var/www/eseco/documents/author_8/Dados Coletados PAULO FINAL.xlsx', NULL, NULL, 23),
(23, '/var/www/eseco/documents/author_8/Animais do Experimento.xlsx', NULL, NULL, 26),
(24, '/var/www/eseco/documents/author_8/Classificao CAR.xlsx', NULL, NULL, 27),
(25, '/var/www/eseco/documents/author_8/Classificao GPR.xlsx', NULL, NULL, 28),
(26, '/var/www/eseco/documents/author_14/EXPERIMENTO DANIELI.xlsx', NULL, NULL, 29),
(27, '/var/www/eseco/documents/author_14/CAR.xlsx', NULL, NULL, 30),
(28, '/var/www/eseco/documents/author_14/GPR.xlsx', NULL, NULL, 31),
(29, '/var/www/eseco/documents/author_14/ECA.xlsx', NULL, NULL, 32),
(30, '/var/www/eseco/documents/author_14/Classifica??o CAR.xlsx', NULL, NULL, 33),
(31, '/var/www/eseco/documents/author_14/Classifica??o GPR.xlsx', NULL, NULL, 34),
(32, '/var/www/eseco/documents/author_14/Classifica??o ECA.xlsx', NULL, NULL, 35),
(33, '/var/www/eseco/documents/author_16/Par?metros coletados.xlsx', NULL, NULL, 38),
(34, '/var/www/eseco/documents/author_16/Valores CAR.xlsx', NULL, NULL, 39),
(35, '/var/www/eseco/documents/author_16/Classifica??o CAR 3 grupos.xlsx', NULL, NULL, 40);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiments`
--

CREATE TABLE IF NOT EXISTS `exp_experiments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `current_phase` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `date_ended` date DEFAULT NULL,
  `date_updated` date DEFAULT NULL,
  `description` text,
  `key_words` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8wdtrv2sj8xua9d7s9pmq2cf4` (`author_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `exp_experiments`
--

INSERT INTO `exp_experiments` (`id`, `current_phase`, `date_created`, `date_ended`, `date_updated`, `description`, `key_words`, `name`, `status`, `version`, `author_id`) VALUES
(1, 4, '2018-06-04', '2018-06-15', '2018-06-16', 'O objetivo deste estudo foi avaliar possíveis divergências no consumo alimentar residual (CAR) e ganho de peso residual (GPR) em novilhas F1 Girolando e a relação com parâmetros de comportamento alimentar, temperatura da superfície do corpo por termografia por infravermelho, características morfológicas e de desempenho.', 'consumo de água, consumo alimentar residual, ganho de peso residual, morfologia, temperatura corporal', 'Relação do consumo alimentar residual e ganho de peso residual com características morfológicas, desempenho, comportamento alimentar, termográfica de infravermelho de novilhas Girolando', 1, '1.0.0', 8),
(2, 4, '2018-06-04', '2018-06-17', '2018-06-17', 'Avaliaram-se os efeitos da divergência fenotípica para eficiência alimentar (consumo alimentar residual - CAR, ganho de peso residual - GPR e eficiência de conversão alimentar - ECA), na digestibilidade, emissão de metano entérico (CH4), partição energética, produção de calor (PC), parâmetros sanguíneos, metabolismo de nitrogênio e temperaturas de diferentes regiões corporais.', 'calorimetria, consumo alimentar residual, digestibilidade, parâmetros sanguíneos, metano, termografia infravermelha.', 'Metabolismo em novilhas Girolando com fenótipos divergentes para eficiência alimentar', 1, '1.0.0', 14),
(3, 4, '2018-06-04', '2018-06-17', '2018-06-17', 'O objetivo deste experimento é abordar os parâmetros reprodutivos em novilhas Girolando F1 desde a puberdade até a primeira concepção e correlacionar a eficiência nutricional com alguns desses parâmetros.', 'dinâmica ovariana, puberdade, reprodução, fertilidade, eficiência alimentar, gado de leite', 'Eficiência Alimentar Sobre A Puberdade E Características Ovarianas Em 11 Novilhas Girolando (F1 Holandês X Gir)', 1, '1.0.0', 16);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_detail`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_detail` (
  `experiment_id` int(11) NOT NULL,
  `detail_id` int(11) NOT NULL,
  UNIQUE KEY `UK_5qh9pd03h1yw4ypkv7fvkbpmr` (`detail_id`),
  KEY `FK7j63x9wgxt5a20myu4hfdfnnt` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_detail`
--

INSERT INTO `exp_experiment_detail` (`experiment_id`, `detail_id`) VALUES
(1, 18),
(1, 16),
(1, 15),
(1, 14),
(1, 13),
(1, 11),
(1, 10),
(1, 9),
(1, 8),
(1, 7),
(1, 6),
(1, 5),
(1, 1),
(1, 4),
(1, 12),
(1, 17),
(2, 44),
(2, 43),
(2, 42),
(2, 41),
(2, 39),
(2, 38),
(2, 36),
(2, 32),
(2, 31),
(2, 30),
(2, 45),
(1, 46),
(3, 55),
(3, 54),
(3, 51),
(3, 50),
(3, 47),
(3, 48),
(3, 49),
(3, 52),
(3, 53),
(3, 56),
(3, 57),
(3, 58);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_discipline`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_discipline` (
  `experiment_id` int(11) NOT NULL,
  `discipline_id` int(11) NOT NULL,
  KEY `FK6405qih7ujt75qdek5jdjilxh` (`discipline_id`),
  KEY `FKicvn8r1iufvhwgbjs46n832wg` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_discipline`
--

INSERT INTO `exp_experiment_discipline` (`experiment_id`, `discipline_id`) VALUES
(1, 1),
(2, 29),
(2, 1),
(3, 29),
(3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_institution`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_institution` (
  `experiment_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  KEY `FK30q79mt5qlny8appo6dleufhh` (`institution_id`),
  KEY `FKlyfd8lk44lvpi327gij49ejv` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_institution`
--

INSERT INTO `exp_experiment_institution` (`experiment_id`, `institution_id`) VALUES
(1, 2),
(2, 3),
(3, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_phase_reports`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_phase_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `current_phase` int(11) DEFAULT NULL,
  `date_created` date DEFAULT NULL,
  `description` text,
  `author_id` int(11) NOT NULL,
  `experiment_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKbyjnl6edgxdup59rbo11fq13u` (`author_id`),
  KEY `FK2ga5hmynaoplcs0465uvovke1` (`experiment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Extraindo dados da tabela `exp_experiment_phase_reports`
--

INSERT INTO `exp_experiment_phase_reports` (`id`, `current_phase`, `date_created`, `description`, `author_id`, `experiment_id`) VALUES
(1, 0, '2018-06-05', 'Após revisão da literatura, e investigação do problema, chegou-se ao seguinte objetivo para o experimento:\r\n\r\nEstudar divergências no consumo alimentar residual e ganho de peso residual em novilhas F1 Girolando e as relações com consumo, desempenho, comportamento alimentar e de ingestão de água, temperatura da superfície do corpo por termografia por infravermelho e características morfológicas.', 8, 1),
(2, 1, '2018-06-05', 'Detalhes do protótipo do experimento para análise da eficiênca alimentar de acordo com os índices CAR e GPR.', 8, 1),
(3, 2, '2018-06-15', 'Executado o workflow, obtivemos a classificação dos animais para CAR e GPR.', 19, 1),
(4, 3, '2018-06-15', 'Experimento publicado.', 19, 1),
(5, 0, '2018-06-17', 'Foram analisados trabalhos publicados anteriormente para o referencial teórico desta pesquisa.', 14, 2),
(6, 1, '2018-06-17', 'Analisando o problema de pesquisa proposto, decidiu-se por um processo de experimentação que começa com a escolha e adaptação dos animais, passa pelo cálculo dos índices de eficiência alimentar, medição dos parâmetros metabólicos, e termina com uma análise detalhada destes resultados.', 14, 2),
(7, 2, '2018-06-17', 'O processo de experimentação foi conduzido com sucesso.', 14, 2),
(8, 3, '2018-06-17', 'Os resultados obtidos fora apresentados na dissertação, e publicados em revistas específicas.', 14, 2),
(9, 0, '2018-06-17', 'Foram levantados trabalhos existentes na literatura, os quais foram utilizados como referencial teórico para este estudo.', 16, 3),
(10, 1, '2018-06-17', 'A partir da análise do problema apresentado, decidiu-se por realizar o experimento em duas etapas. 1) Características reprodutivas de novilhas Girolando da pré-puberdade à primeira gestação e 2) Características reprodutivas de novilhas leiteiras Girolando com o fenótipo divergente para consumo alimentar residual', 16, 3),
(11, 2, '2018-06-17', 'O experimento ocorreu conforme planejado.', 16, 3),
(12, 3, '2018-06-17', 'Os resultados foram analisados estatisticamente e publicados.', 16, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_researcher`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_researcher` (
  `experiment_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  KEY `FK39mgah2kmqt5mbre5lubvmbh4` (`researcher_id`),
  KEY `FK36kab23m9ujw80yr0k0uxismy` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_researcher`
--

INSERT INTO `exp_experiment_researcher` (`experiment_id`, `researcher_id`) VALUES
(1, 13),
(1, 12),
(1, 11),
(1, 8),
(2, 15),
(2, 14),
(2, 13),
(2, 12),
(3, 18),
(3, 17),
(3, 16),
(3, 12);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_research_group`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_research_group` (
  `experiment_id` int(11) NOT NULL,
  `research_group_id` int(11) NOT NULL,
  KEY `FKk0f62wi8ou8gy95afpvn31369` (`research_group_id`),
  KEY `FKp405w03fa0qljtm7q4gdxkyu4` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_research_group`
--

INSERT INTO `exp_experiment_research_group` (`experiment_id`, `research_group_id`) VALUES
(1, 1),
(3, 3),
(2, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_workflow`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_workflow` (
  `experiment_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  KEY `FKmq6ldbobb91incdsjidwq95p1` (`workflow_id`),
  KEY `FK72eci3bh650vx70nkt2lfccah` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_experiment_workflow`
--

INSERT INTO `exp_experiment_workflow` (`experiment_id`, `workflow_id`) VALUES
(1, 2),
(1, 1),
(2, 5),
(3, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_ports`
--

CREATE TABLE IF NOT EXISTS `exp_ports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK830q3jyptlpgcj45opi97hmw5` (`entity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Extraindo dados da tabela `exp_ports`
--

INSERT INTO `exp_ports` (`id`, `entity_id`) VALUES
(1, 23),
(2, 24),
(3, 25),
(4, 26),
(5, 27),
(6, 28),
(9, 29),
(10, 30),
(11, 31),
(12, 32),
(13, 33),
(14, 34),
(15, 35),
(18, 38),
(19, 39),
(20, 40);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_wfms`
--

CREATE TABLE IF NOT EXISTS `exp_wfms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `exp_wfms`
--

INSERT INTO `exp_wfms` (`id`, `link`, `name`) VALUES
(1, 'kepler-project.org', 'Kepler'),
(2, 'www.taverna.org.uk', 'Taverna'),
(3, 'www.vistrails.org', 'Vistrails'),
(4, 'Service', 'Other');

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflows`
--

CREATE TABLE IF NOT EXISTS `exp_workflows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` date DEFAULT NULL,
  `description` text,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `value` text,
  `version` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `wfms` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKqslqgl3bji8jfhnk39ho8x3cj` (`author_id`),
  KEY `FK1s70xnudcejtrpibci2oiyu0g` (`wfms`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Extraindo dados da tabela `exp_workflows`
--

INSERT INTO `exp_workflows` (`id`, `date_created`, `description`, `link`, `name`, `value`, `version`, `author_id`, `wfms`) VALUES
(1, '2018-06-05', 'Processo de avaliação e classificação de animais por CAR e GPR.', '', 'Classificação da eficiência dos animais', NULL, '1.0.0', 8, 4),
(5, '2018-06-16', 'Processo de avaliação e classificação de animais por CAR e GPR e ECA, e análise de acordo com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.', '', 'Análise do metabolismo em novilhas com fenótipos divergentes para EA', NULL, '1.0.0', 14, 4),
(6, '2018-06-17', 'Estudar e caracterizar os parâmetros reprodutivos até a primeira concepção, incluindo-se idade e peso à puberdade, comportamento de estro, dinâmica folicular, resposta a protocolos hormonais e fertilidade em novilhas Girolando. Relacionar a eficiência nutricional com idade e peso à puberdade e alguns parâmetros reprodutivos em novilhas Girolando.', '', 'Análise da EA sobre a puberdade e características ovarianas', NULL, '1.0.0', 16, 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_activity`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_activity` (
  `activity_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_exec` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKo8td603fqb6sv954o1fwwxpy9` (`workflow_id`),
  KEY `FK22ppdcl5uu8bj6at6eaqc2sv2` (`activity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Extraindo dados da tabela `exp_workflow_activity`
--

INSERT INTO `exp_workflow_activity` (`activity_id`, `workflow_id`, `id`, `order_exec`) VALUES
(5, 1, 1, 4),
(4, 1, 2, 4),
(3, 1, 3, 3),
(2, 1, 4, 2),
(1, 1, 5, 1),
(6, 1, 6, 5),
(19, 6, 19, 5),
(18, 6, 18, 4),
(3, 6, 17, 3),
(2, 6, 16, 2),
(1, 6, 15, 1),
(15, 5, 14, 6),
(14, 5, 13, 5),
(13, 5, 12, 4),
(12, 5, 11, 4),
(11, 5, 10, 4),
(3, 5, 9, 3),
(2, 5, 8, 2),
(1, 5, 7, 1),
(20, 6, 20, 6),
(21, 1, 21, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_executions`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_executions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `end_time` datetime DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `experiment_id` int(11) NOT NULL,
  `workflow` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKnjlmwsbt81c6q3bxjb2phr0g7` (`author_id`),
  KEY `FKebyw0g9ol47bdei6to92ithk7` (`experiment_id`),
  KEY `FKk4v7d9ofa6iq5xf2e57s0wx0g` (`workflow`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `exp_workflow_executions`
--

INSERT INTO `exp_workflow_executions` (`id`, `end_time`, `start_time`, `author_id`, `experiment_id`, `workflow`) VALUES
(1, '2018-06-15 04:25:00', '2018-06-15 04:25:00', 8, 1, 1),
(3, '2018-06-17 12:25:00', '2018-06-16 09:25:00', 14, 2, 5),
(4, '2018-06-17 22:42:00', '2018-06-17 16:42:00', 16, 3, 6);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_execution_activity_execution`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_execution_activity_execution` (
  `workflow_execution_id` int(11) NOT NULL,
  `activity_execution_id` int(11) NOT NULL,
  UNIQUE KEY `UK_93w0is4v17g1k0noldtw2m27r` (`activity_execution_id`),
  KEY `FKh8s3866jdht94q2rbhj72nfam` (`workflow_execution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_workflow_execution_activity_execution`
--

INSERT INTO `exp_workflow_execution_activity_execution` (`workflow_execution_id`, `activity_execution_id`) VALUES
(1, 8),
(1, 7),
(1, 4),
(1, 5),
(1, 6),
(1, 9),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(3, 16),
(3, 17),
(4, 18),
(4, 19),
(4, 20),
(4, 21),
(4, 22);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_inputs`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_inputs` (
  `workflow_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  KEY `FKgnujy2g8lck650r1rlerthyi9` (`port_id`),
  KEY `FKmjmnxve10uj2na4jw2et0mrvg` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_workflow_inputs`
--

INSERT INTO `exp_workflow_inputs` (`workflow_id`, `port_id`) VALUES
(1, 1),
(1, 1),
(1, 4),
(1, 2),
(1, 3),
(3, 1),
(3, 1),
(3, 1),
(3, 10),
(3, 11),
(3, 12),
(3, 9),
(3, 13),
(3, 14),
(3, 15),
(4, 1),
(4, 19),
(4, 18),
(4, 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_outputs`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_outputs` (
  `workflow_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  KEY `FKc1esrqi7mpm87s6lppkwueebm` (`port_id`),
  KEY `FKqrnhq7rsyaknym2y0fx9ds1wm` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_workflow_outputs`
--

INSERT INTO `exp_workflow_outputs` (`workflow_id`, `port_id`) VALUES
(1, 3),
(1, 2),
(1, 4),
(1, 1),
(1, 5),
(1, 6),
(3, 1),
(3, 10),
(3, 11),
(3, 12),
(3, 13),
(3, 14),
(3, 15),
(4, 18),
(4, 19),
(4, 20);

-- --------------------------------------------------------

--
-- Estrutura da tabela `hibernate_sequence`
--

CREATE TABLE IF NOT EXISTS `hibernate_sequence` (
  `next_val` bigint(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `hibernate_sequence`
--

INSERT INTO `hibernate_sequence` (`next_val`) VALUES
(21);

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_components`
--

CREATE TABLE IF NOT EXISTS `res_components` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `documentation_url` text,
  `name` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKfa2l3vre3kbnar6k9alu8q9fl` (`author_id`),
  KEY `FKgvn6qp9ggx1vjv0xuw9aa8w8w` (`type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_component_developers`
--

CREATE TABLE IF NOT EXISTS `res_component_developers` (
  `component_id` int(11) NOT NULL,
  `developer_id` int(11) NOT NULL,
  UNIQUE KEY `UK_h941jk5dpq11i0uiaqo2t7gby` (`developer_id`),
  KEY `FKeoykgm79uj440dfm89tkidhgb` (`component_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_component_types`
--

CREATE TABLE IF NOT EXISTS `res_component_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `res_component_types`
--

INSERT INTO `res_component_types` (`id`, `name`) VALUES
(1, 'Plugin'),
(2, 'Workflow Service');

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `internal_class` varchar(255) DEFAULT NULL,
  `nature` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `component_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_rqe4cpt8u2tqae6mff9ugshfl` (`internal_class`),
  KEY `FK4xgj81k1ipc821xx0f0scx770` (`component_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services_comments`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `date` datetime DEFAULT NULL,
  `rate_star_1` int(11) DEFAULT NULL,
  `rate_star_2` int(11) DEFAULT NULL,
  `rate_star_3` int(11) DEFAULT NULL,
  `rate_star_4` int(11) DEFAULT NULL,
  `rate_star_5` int(11) DEFAULT NULL,
  `commenter_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `workflowService_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2sb2migp57btlnwt2ysc2atu` (`commenter_id`),
  KEY `FK7n39gqun30il865diafefctoi` (`parent_id`),
  KEY `FKaq7r193c0ly8s681avret2nrr` (`workflowService_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services_ratings`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` bit(1) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reproved_text` text,
  `type` int(11) DEFAULT NULL,
  `value_disponibility` int(11) DEFAULT NULL,
  `value_documentation` int(11) DEFAULT NULL,
  `value_ease_of_use` int(11) DEFAULT NULL,
  `value_performance` int(11) DEFAULT NULL,
  `value_reliability` int(11) DEFAULT NULL,
  `rater_id` int(11) NOT NULL,
  `workflowService_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp7jehvgu7w02hpgqleahm7qg1` (`rater_id`),
  KEY `FK1wsug3y880h83wxsqag980oil` (`workflowService_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services_ratings_invitations`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services_ratings_invitations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `completed` bit(1) DEFAULT NULL,
  `date_chat` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `date_invited` datetime DEFAULT NULL,
  `participated_in_chat` bit(1) DEFAULT NULL,
  `asker_id` int(11) DEFAULT NULL,
  `rater_id` int(11) DEFAULT NULL,
  `workflowService_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK7t5m8q9o3pt01dwfsdceevtcp` (`asker_id`),
  KEY `FK85bfwpgps3rrcqr0psg9ceqnp` (`rater_id`),
  KEY `FKkppk4lffpqe7amg9jdasqcb2d` (`workflowService_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_animals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_experiments`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_experiments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_experiment_animals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_experiment_animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `diaryWeightGain` double DEFAULT NULL,
  `meanMetabolicWeight` double DEFAULT NULL,
  `animal_id` int(11) DEFAULT NULL,
  `experiment_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhf5f09cee0igvq5h7wi7mb50` (`animal_id`),
  KEY `FK4lrx4w8s2scm14x46x8btf072` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_experiment_animals_meals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_experiment_animals_meals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` double DEFAULT NULL,
  `experimentAnimal_id` int(11) DEFAULT NULL,
  `meal_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKlkrn2247cxcjkyt40k76gqooj` (`experimentAnimal_id`),
  KEY `FK79q9t27lq4nhetsbw8hp1hdw5` (`meal_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_meals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_meals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `uac_roles`
--

CREATE TABLE IF NOT EXISTS `uac_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `uac_roles`
--

INSERT INTO `uac_roles` (`id`, `name`) VALUES
(1, 'Admin'),
(2, 'Researcher'),
(3, 'Developer');

-- --------------------------------------------------------

--
-- Estrutura da tabela `uac_users`
--

CREATE TABLE IF NOT EXISTS `uac_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `activation_code` varchar(255) DEFAULT NULL,
  `activation_expire_date` datetime DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `login` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `redefinition_code` varchar(255) DEFAULT NULL,
  `redefinition_expire_date` datetime DEFAULT NULL,
  `register_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_4irsjvmmxr66a910owdqsvsl8` (`email`),
  UNIQUE KEY `UK_kl9p593rs2a8wjpsitrgh7i60` (`login`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Extraindo dados da tabela `uac_users`
--

INSERT INTO `uac_users` (`id`, `activation_code`, `activation_expire_date`, `active`, `email`, `login`, `password`, `redefinition_code`, `redefinition_expire_date`, `register_date`) VALUES
(1, NULL, NULL, b'1', 'lenita.ambrosio@gmail.com', 'lenita.ambrosio@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(2, NULL, NULL, b'1', 'adolfo.perez@experimentoembrapa.com', 'adolfo.perez@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(3, NULL, NULL, b'1', 'danieli.cabral@experimentoembrapa.com', 'danieli.cabral@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(4, NULL, NULL, b'1', 'paulo.campos@experimentoembrapa.com', 'paulo.campos@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(8, NULL, NULL, b'1', 'sandra.gesteira@experimentoembrapa.com', 'sandra.gesteira@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(9, NULL, NULL, b'1', 'luiz.gustavo@experimentoembrapa.com', 'luiz.gustavo@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(10, NULL, NULL, b'1', 'alan.maia@experimentoembrapa.com', 'alan.maia@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(11, NULL, NULL, b'1', 'mariana.magalhaes@experimentoembrapa.com', 'mariana.magalhaes@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(12, NULL, NULL, b'1', 'juliana.aparecida@experimentoembrapa.com', 'juliana.aparecida@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(13, NULL, NULL, b'1', 'bruna.r@experimentoembrapa.com', 'bruna.r@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07');

-- --------------------------------------------------------

--
-- Estrutura da tabela `uac_users_roles`
--

CREATE TABLE IF NOT EXISTS `uac_users_roles` (
  `id_user` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  KEY `FKmjqpx78dy0ermw3hvguqs8020` (`id_role`),
  KEY `FK7808thnb4yhr5rw92ikg2h59j` (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `uac_users_roles`
--

INSERT INTO `uac_users_roles` (`id_user`, `id_role`) VALUES
(1, 2),
(2, 2),
(3, 2),
(4, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
