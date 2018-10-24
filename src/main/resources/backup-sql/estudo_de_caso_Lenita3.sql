-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 24-Out-2018 às 14:30
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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

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
(11, NULL, 'F', 'Bruna Rios Coelho Alves', 13),
(12, '1990-08-30 00:00:00', 'M', 'Pesquisador', 14),
(14, '2018-08-07 00:00:00', 'F', 'Juliana Mergh Leão', 16),
(15, '2018-08-07 00:00:00', 'F', 'Raquel de Melo Costa', 17),
(16, '2018-08-07 00:00:00', 'F', 'Aloma Eiterer Leão', 18),
(17, '2018-08-07 00:00:00', 'F', 'Camila Flávia de Assis Lage', 19),
(18, '2018-08-07 00:00:00', 'F', 'Mayara Campos Lombardi', 20),
(20, '1992-01-08 00:00:00', 'F', 'Raiane Querino Coelho', 22);

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
  `lattes_id` varchar(255) DEFAULT NULL,
  `researchgate_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK71mh4922a0q3t7ebjdmviloap` (`agent_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Extraindo dados da tabela `core_agents_researchers`
--

INSERT INTO `core_agents_researchers` (`id`, `academic_status`, `display_name`, `kepler_id`, `mendeley_id`, `photo`, `title`, `agent_id`, `lattes_id`, `researchgate_id`) VALUES
(8, 'Mestre', 'Paulo Campos Martins', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4994709U4', 'M.e', 3, NULL, NULL),
(11, 'Doutora', 'Sandra Gesteira Coelho', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4785555Y6', 'D.ra', 6, NULL, NULL),
(12, 'Doutora', 'Mariana Magalhães Campos', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4711104J6', 'D.ra', 9, '', ''),
(13, 'Doutora', 'Juliana Aparecida Mello Lima', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4465377T8', 'D.ra', 10, NULL, NULL),
(14, 'Mestre', 'Danieli Cabral da Silva', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K8156860H8', 'M.e', 4, NULL, NULL),
(15, 'Doutor', 'Luiz Gustavo Ribeiro Pereira', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4708057P9', 'D.r', 7, NULL, NULL),
(16, 'Mestre', 'Adolfo Pérez Fonseca', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4868005H6', 'M.e', 5, NULL, NULL),
(17, 'Doutora', 'Bruna Rios Coelho Alves', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4711889J5', 'D.ra', 11, NULL, NULL),
(18, 'Doutor', 'Álan Maia Borges', NULL, NULL, 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4796232T6', 'D.r', 8, NULL, NULL),
(19, 'Bacharel', 'Lenita Ambrosio', '', 'd2c04fe2-c362-3c0a-ab19-67615339f7ee', 'https://photos.mendeley.com/75/1e/751ed52587b409dd024e4dda51a32ed2bb8f007a.png', 'B.S', 1, 'http://lattes.cnpq.br/6953318876015246', 'https://www.researchgate.net/profile/Lenita_Martins_Ambrosio'),
(20, '', 'Pesquisador', NULL, NULL, 'resources/images/agent-photo-blank.png', '', 12, NULL, NULL),
(21, 'Mestre', 'Juliana Mergh Leão', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4457399A6', 'M.e', 14, 'http://lattes.cnpq.br/1524714691260668', 'https://www.researchgate.net/scientific-contributions/2114436491_Juliana_Mergh_Leao'),
(23, 'Mestre', 'Raquel de Melo Costa', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4680986H0', 'M.e', 15, 'http://lattes.cnpq.br/1743453104000394', ''),
(24, 'Bacharel', 'Aloma Eiterer Leão', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K8562972Z5', 'BSc', 16, 'http://lattes.cnpq.br/3664682086826885', ''),
(25, 'Mestre', 'Camila Flávia de Assis Lage', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4339039J1', 'M.e', 17, 'http://lattes.cnpq.br/5660372683265184', ''),
(26, 'Bacharel', 'Mayara Campos Lombardi', '', '', 'http://servicosweb.cnpq.br/wspessoa/servletrecuperafoto?tipo=1&id=K4476118H1', 'B.S', 18, 'http://lattes.cnpq.br/7823431799604810', '');

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
(19, 7),
(21, 29),
(21, 1),
(23, 29),
(23, 1),
(24, 1),
(24, 29),
(25, 29),
(25, 1),
(26, 29),
(26, 1);

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
(19, 1),
(20, 1),
(21, 2),
(22, 2),
(23, 6),
(24, 7),
(25, 2),
(26, 2);

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
(12, 17),
(12, 16),
(12, 9),
(12, 13),
(12, 14),
(12, 15),
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
(21, 27),
(21, 10),
(21, 8),
(21, 11),
(21, 13),
(21, 14),
(23, 18),
(23, 17),
(23, 10),
(23, 8),
(24, 8),
(24, 9),
(25, 8),
(25, 13),
(25, 32),
(26, 18),
(26, 17),
(26, 9),
(26, 8),
(27, 27),
(27, 26);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

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
(27, 'visualization', '2017', 19),
(28, 'complex network', '2017', 19),
(29, 'e-science', '2017', 19),
(30, 'provenance', '2017', 19),
(31, 'visualization', '2017', 19),
(32, 'complex network', '2017', 19),
(33, 'e-science', '2017', 19),
(34, 'provenance', '2017', 19),
(35, 'visualization', '2017', 19),
(36, 'contextual elements', '2018', 19),
(37, 'e-science', '2018', 19),
(38, 'provenance', '2018', 19),
(39, 'scientific experiments', '2018', 19);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

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
(29, 'Itapetinga', 5),
(30, 'Montes Claros', 13),
(31, 'Viçosa', 13),
(32, 'Ilhéus', 5);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `core_institutions`
--

INSERT INTO `core_institutions` (`id`, `name`, `city_id`) VALUES
(1, 'Universidade Federal de Juiz de Fora', 28),
(2, 'Universidade Federal de  Minas Gerais', 13),
(3, 'Universidade Estadual do Sudoeste da Bahia', 29),
(4, 'Empresa Brasileira de Pesquisa Agropecuária - EMBRAPA', 28),
(5, 'Federal University of Juiz de Fora', 28),
(6, 'Universidade Estadual de Montes Claros', 30),
(7, 'Universidade Federal de Viçosa', 31),
(8, 'Universidade Estadual de Santa Cruz', 32);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_interests`
--

CREATE TABLE IF NOT EXISTS `core_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=33 ;

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
(31, 'Manejo de rebanho'),
(32, 'Qualidade do Leite');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=42 ;

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
(11, '2018-06-16', 'Escolha dos Animais para o experimento', 'Seleção dos animais', 14),
(12, '2018-06-16', 'Adaptação dos animais as novas instalações e dieta.', 'Adaptação', 14),
(13, '2018-06-16', 'Coleta de informações adicionais como: consumo, digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos etermografia infravermelha.', 'Coleta de dados', 14),
(15, '2018-06-16', 'Avaliar a relação entre a classificação fenotípica divergente para o CAR, GPR e ECA com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.', 'Análise dos resultados', 14),
(18, '2018-06-17', 'Escolhas dos animais para o experimento.', 'Seleção dos animais', 16),
(19, '2018-06-17', 'Período de adaptação dos animais.', 'Adaptação', 16),
(20, '2018-06-17', 'Analisar os dados coletados, e realizar comparações.', 'Avaliação dos resultados obtidos', 16),
(21, '2018-07-12', 'Análise e comparação dos valores de EA obtidos.', 'Análise dos resultados', 8),
(22, '2018-08-06', 'Período de experimentação para coleta de parâmetros reprodutivos ', 'Coleta de dados', 16),
(23, '2018-08-15', '', 'Nascimento dos animais', 25),
(24, '2018-08-15', '', 'Cuidados inciais', 25),
(25, '2018-08-15', '', 'Coleta de dados', 25),
(26, '2018-08-15', '', 'Cálculo dos dados de eficiência alimentar', 25),
(27, '2018-08-15', '', 'Análise dos resultados obtidos', 25),
(28, '2018-08-16', 'Preparação dos animais após o nascimento.', 'Preparação dos animais', 21),
(29, '2018-08-16', 'Período de teste de EA, com coleta dos dados.', 'Ensaio', 21),
(30, '2018-08-16', 'Classificação dos animais.', 'Classificação para CAR e GPR', 21),
(31, '2018-08-16', 'Análise da divergência fenotípica para a EA e sua correlação com produção de calor (PC) e com a temperatura superficial da pele.', 'Análise dos índices de EA com relação a produção de calor e termografia', 21),
(32, '2018-08-16', 'Examinar a relação entre a eficiência alimentar e as variáveis metabólicas do sangue e do rúmen e medidas morfológicas em bezerras', 'Análise dos efeitos da EA nas medidas corporais, variáveis sanguíneas e metabólitos ruminais', 21),
(33, '2018-08-16', 'Escolha e preparação dos animais para ensaio a pasto.', 'Seleção para ensaio a pasto', 23),
(34, '2018-08-16', 'Adaptação dos animais para o ensaio.', 'Adaptação ensaio a pasto', 23),
(35, '2018-08-16', 'Período de coleta de dados dos animais.', 'Experimento a pasto', 23),
(36, '2018-08-16', 'Classificação em dois grupos de EA de acordo com os índices: consumo alimentar residual (CAR); ganho de peso residual (GPR); consumo e ganho residual (CGR); eficiência de conversão alimentar (ECA).', 'Classificação dos animais do ensaio a pasto', 23),
(37, '2018-08-16', 'Comparação do consumo de matéria seca, o desempenho, as trocas gasosas e a emissão de CH4 entérico, a temperatura da superfície do corpo, características morfométricas e o consumo individual de água de novilhas divergentes fenotipicamente para os índices de EA.', 'Análise dos dados dos animais criados a pasto', 23),
(38, '2018-08-16', 'Preparação dos animais para experimento em confinamento.', 'Seleção para ensaio em confinamento', 23),
(39, '2018-08-16', 'Coleta de dados para o experimento.', 'Ensaio em confinamento', 23),
(40, '2018-08-16', 'Cálculo dos índices de EA e classificação dos animais em dois grupos: Alta eficiência e Baixa eficiência.', 'Classificação da EA (ensaio em confinamento)', 23),
(41, '2018-08-16', 'comparação dos índices de EA com o consumo de matéria seca, o desempenho, as trocas gasosas e a emissão de CH4 entérico, a temperatura da superfície do corpo obtida por termografia infravermelha, características morfométricas, o perfil metabólico  e o consumo de água.', 'Análise dos resultados em confinamento', 23);

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

--
-- Extraindo dados da tabela `exp_activity_detail`
--

INSERT INTO `exp_activity_detail` (`activity_id`, `detail_id`) VALUES
(3, 61),
(3, 60),
(3, 59),
(3, 62),
(28, 90),
(28, 91),
(29, 97),
(29, 92),
(29, 93),
(29, 94),
(29, 95),
(29, 96),
(29, 98),
(29, 99),
(29, 100),
(29, 101),
(33, 104),
(33, 105),
(33, 106),
(35, 110),
(35, 111),
(34, 107),
(35, 112),
(35, 113),
(36, 114),
(38, 115),
(38, 116),
(38, 117),
(38, 118),
(39, 123),
(39, 122),
(39, 120),
(39, 119),
(39, 121),
(39, 124),
(39, 125),
(39, 126),
(40, 127);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=44 ;

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
(13, '2018-06-16 09:47:00', '2018-06-16 08:47:00', 11, 14),
(14, '2018-06-16 21:48:00', '2018-06-16 20:48:00', 12, 14),
(15, '2018-06-16 09:48:00', '2018-06-16 08:48:00', 13, 14),
(17, '2018-06-16 11:02:00', '2018-06-16 11:00:00', 15, 14),
(20, '2018-06-17 07:40:00', '2018-06-17 07:39:00', 18, 16),
(21, '2018-06-17 08:41:00', '2018-06-17 08:40:00', 19, 16),
(22, '2018-06-17 09:42:00', '2018-06-17 09:41:00', 20, 16),
(23, '2018-08-07 16:15:00', '2018-08-06 16:15:00', 22, 16),
(24, '2018-08-07 16:21:00', '2018-08-13 16:21:00', 21, 8),
(25, '2018-08-16 10:31:00', '2018-08-16 10:31:00', 29, 21),
(26, '2018-08-16 10:33:00', '2018-08-16 10:33:00', 30, 21),
(27, '2018-08-15 10:33:00', '2018-08-15 10:33:00', 28, 21),
(28, '2018-08-17 10:34:00', '2018-08-17 10:34:00', 31, 21),
(29, '2018-08-18 10:34:00', '2018-08-18 10:34:00', 32, 21),
(30, '2018-08-02 12:21:00', '2018-08-01 12:21:00', 23, 25),
(31, '2018-08-03 12:21:00', '2018-08-02 12:21:00', 24, 25),
(32, '2018-08-05 12:22:00', '2018-08-04 12:22:00', 25, 25),
(33, '2018-08-09 12:22:00', '2018-08-07 12:22:00', 26, 25),
(34, '2018-08-11 12:23:00', '2018-08-10 12:23:00', 27, 25),
(35, '2018-08-02 16:37:00', '2018-08-01 16:37:00', 33, 23),
(36, '2018-08-03 16:38:00', '2018-08-02 16:38:00', 34, 23),
(37, '2018-08-04 16:38:00', '2018-08-03 16:38:00', 35, 23),
(38, '2018-08-06 16:38:00', '2018-08-05 16:38:00', 36, 23),
(39, '2018-08-07 16:38:00', '2018-08-06 16:38:00', 37, 23),
(40, '2018-08-13 16:39:00', '2018-08-12 16:39:00', 38, 23),
(41, '2018-08-14 16:39:00', '2018-08-14 16:39:00', 39, 23),
(42, '2018-08-16 16:39:00', '2018-08-15 16:39:00', 40, 23),
(43, '2018-08-17 16:40:00', '2018-08-16 16:40:00', 41, 23);

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
(16, 10),
(16, 11),
(16, 12),
(22, 18),
(22, 5),
(17, 2),
(17, 3),
(17, 9),
(24, 5),
(24, 6),
(26, 25),
(26, 26),
(26, 27),
(26, 28),
(26, 29),
(26, 30),
(26, 31),
(28, 27),
(28, 29),
(28, 32),
(29, 28),
(29, 32),
(33, 23),
(33, 24),
(34, 23),
(34, 24),
(34, 33);

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
(16, 13),
(16, 14),
(16, 15),
(19, 18),
(15, 9),
(23, 18),
(25, 25),
(25, 26),
(25, 27),
(25, 28),
(25, 29),
(25, 30),
(25, 31),
(26, 32),
(32, 24),
(32, 23),
(32, 33);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_detail`
--

CREATE TABLE IF NOT EXISTS `exp_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=128 ;

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
(58, 'semanal', 'Período de medição do peso vivo'),
(59, 'semanal', 'Período de medição do peso vivo'),
(60, 'diário', 'Período de medição da ingestão da água '),
(61, 'diário', 'Período de medição da ingestão da dieta'),
(62, 'quinzenal', 'Período de medição da altura de cernelha e quadril (AQ), largura entre íleos, profundidade corporal (PC) e circunferência do tórax (CT)'),
(63, '42% do peso metabólico ao nascimento em litros de leite integral e A dieta sólida foi composta de 92% de concentrado (Soymax Rumen pré-inicial, 18% Flocculado, Total Alimentos, Três Corações, Minas Gerais, Brasil) e 8% de feno de tifton 85 picado em 5 cm de comprimento ', 'Dieta'),
(64, 'Gir', 'Raça'),
(65, '6 litros de leite divididos em duas refeições as 7h e 14h, 95 % concentrado comercial (Soylac Rumen 20% Flocculated, Total Alimentos, Três Corações, Minas Gerais, Brasil) and 5% feno de Tifton 85. ', 'Dieta'),
(66, '36', 'Número de Animais'),
(67, '56 dias de observações, da quarta a décima segunda semana de vida', 'Período mínimo de 70 dias de prova'),
(68, 'F1 Holandês-Gir', 'Raça'),
(81, '42% do peso metabólico ao nascimento em leite integral e dieta sólida composta por 92% de concentrado e 8% de feno picado', 'Dieta'),
(82, '38', 'Número de Animais'),
(83, '90', 'Período mínimo de 70 dias de prova'),
(84, 'Gir', 'Raça'),
(85, 'leite integral (6 L / d), dieta sólida (95% de concentrado e 5% de feno Tifton 85 cortado) e água à vontade.', 'Dieta'),
(86, '36', 'Número de Animais'),
(87, 'aleitamento', 'Fase estudada'),
(88, 'Holandês x Gir', 'Raça'),
(89, 'CAR e GPR', 'Índices de EA'),
(90, '32,4 ± 6,6 kg, média ± DP', 'PN ao nascimento'),
(91, 'Primavera (Outubro e Dezembro)', 'Período de nascimento'),
(92, 'Baias individuais (1,25 x 1,75 m, amarradas com correntes de 1,2 m de comprimento)', 'Alojamento'),
(93, 'Os bezerros foram alimentados com 6 L de leite / dia durante todo o período pré-desmame, divididos em 2 refeições iguais oferecidas às 07:00 e 14:00 h. Os bezerros foram alimentados com leite de transição até os 3 dias de idade e leite integral a partir dos 4 dias de idade até o desmame. Água e ração sólida foram oferecidos em baldes para ingestão ad libitum (10% de alimentação sólida) durante todo o período experimental. A ração sólida à base de alimento foi composta por 95% de ração iniciadora (Soylac Rumen 20% floculada, Total Alimentos, Três Corações, Minas Gerais, Brasil) e 5% de feno de Tifton 85 picado (Tabela 1).', 'Dieta'),
(94, 'semanal', 'Período de medição do crescimento'),
(95, 'diário', 'Período de medição do consumo (leite e dieta sólida)'),
(96, '82 dias de vida (abruptamente)', 'Desmame'),
(97, '56 dias', 'Período de teste'),
(98, '45 ± 5 dias de idade (máscara facial)', 'Medição das trocas de gasosas'),
(99, '62 ± 7 dias de idade (termografia infravermelha)', 'Medição da temperatura superficial'),
(100, '12ª semana de idade', 'Amostra de sangue'),
(101, '12ª semana de idade', 'Amostras ruminais'),
(102, '35', 'Número de Animais'),
(103, 'Girolando F1', 'Raça'),
(104, '36', 'Número de animais'),
(105, '300±21,7', 'Peso vivo inicial'),
(106, '485±28,2 dias', 'Idade inicial'),
(107, '22 dias', 'Período de adaptação'),
(108, 'sistema de pastejo rotativo em 6 hectares (ha) de pasto Cynodon spp', 'Manejo'),
(109, '7.840 kg MS/ha por piquete ', 'Massa de forragem'),
(110, '2 kg de concentrado composto de milho grão moído e mistura de minerais', 'Dieta'),
(111, 'Sistema de pastejo rotativo em 6 hectares (ha) de pasto Cynodon spp', 'Manejo'),
(112, '7.840 kg MS/ha por piquete', 'Massa de forragem'),
(113, '60 dias', 'Duração'),
(114, 'CAR, GPR, CGR e ECA', 'Índices utilizados'),
(115, '35', 'Número de animais'),
(116, 'Girolando F1', 'Raça'),
(117, '450±30 dias', 'Idade inicial'),
(118, '348±50 kg ', 'Peso vivo inicial'),
(119, 'Área total de aproximadamente 0,2 ha equipadas com 14 cochos eletrônicos e 2 bebedouros eletrônicos ', 'Alojamento'),
(120, '75% de silagem de milho e 25% de concentrado (MS), este constituído de farelo de soja (96%) e mistura de minerais (4%) disponibilizada à vontade para os animais e ajustada diariamente para garantir aproximadamente 10% de sobras', 'Dieta'),
(121, 'semanal', 'Análises químico-bromatológicas'),
(122, 'duração da visita e o número de visitas aos cochos de alimentação e água, ingestão de alimentação fresca e de água feito pelo sistema Intergado.', 'Medição do consumo'),
(123, 'duas vezes ao dia (8:30h e 15:30h)', 'Fornecimento da dieta'),
(124, 'a cada 15 dias', 'Termografia infravermelha'),
(125, 'três coletas, a cada 20 dias durante o ensaio', 'Amostras de sangue'),
(126, 'ao final da prova de EA', 'Mensurações com a máscara facial'),
(127, 'CAR, GPR, CGR e ECA', 'índices utilizados');

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_detail_group`
--

CREATE TABLE IF NOT EXISTS `exp_detail_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `details` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `exp_detail_group`
--

INSERT INTO `exp_detail_group` (`id`, `details`, `name`) VALUES
(1, 'Raça,\r\nDieta,\r\nNúmero de Animais,\r\nPeríodo de prova (mínimo de 70 dias )', 'Eficiência Alimentar');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

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
(38, 'Parâmetros coletados', 16),
(43, 'dados parte 1', 25),
(44, 'dados parte 2', 25),
(45, 'Morfometria', 21),
(46, 'Peso inicial e final', 21),
(47, 'BHBA NNH3 PH CAR56 e CAR80', 21),
(48, 'Glicose Indulina CAR56 CAR80', 21),
(49, 'Dados Máscara', 21),
(50, 'Consumo diário de água', 21),
(51, 'Consumo diário de concentrado', 21),
(52, 'Eficiência Alimentar', 21),
(53, 'Dados diários consumo e desempenho bezerras Gir', 25);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=49 ;

--
-- Extraindo dados da tabela `exp_entities_documents`
--

INSERT INTO `exp_entities_documents` (`id`, `file`, `type`, `value`, `entity_id`) VALUES
(21, '/var/www/eseco/documents/author_8/CAR.xlsx', NULL, NULL, 24),
(22, '/var/www/eseco/documents/author_8/GPR.xlsx', NULL, NULL, 25),
(20, '/var/www/eseco/documents/author_8/Dados Coletados PAULO FINAL.xlsx', NULL, NULL, 23),
(23, '/var/www/eseco/documents/author_8/Animais do Experimento.xlsx', NULL, NULL, 26),
(24, '/var/www/eseco/documents/author_8/Classificacao CAR.xlsx', NULL, NULL, 27),
(25, '/var/www/eseco/documents/author_8/Classificacao GPR.xlsx', NULL, NULL, 28),
(26, '/var/www/eseco/documents/author_14/EXPERIMENTO DANIELI.xlsx', NULL, NULL, 29),
(33, '/var/www/eseco/documents/author_16/Parametros coletados.xlsx', NULL, NULL, 38),
(38, '/var/www/eseco/documents/author_25/dados parte 1.xlsx', NULL, NULL, 43),
(39, '/var/www/eseco/documents/author_25/dados parte 2.xlsx', NULL, NULL, 44),
(40, '/var/www/eseco/documents/author_21/1.MORFOMETRIA 0.5DP_1x2_grupos   planilha base.xls', NULL, NULL, 45),
(41, '/var/www/eseco/documents/author_21/2.PESO GERAL ,PI e PF.xls', NULL, NULL, 46),
(42, '/var/www/eseco/documents/author_21/3.BHBA NNH3 PH CAR56 e CAR80.xls', NULL, NULL, 47),
(43, '/var/www/eseco/documents/author_21/4.GLICOSE INSULINA CAR56 CAR80.xls', NULL, NULL, 48),
(44, '/var/www/eseco/documents/author_21/5.DADOS MASCARA.xls', NULL, NULL, 49),
(45, '/var/www/eseco/documents/author_21/6.Consumo diario de gua.xls', NULL, NULL, 50),
(46, '/var/www/eseco/documents/author_21/8.Consumo diario de concentrado.xls', NULL, NULL, 51),
(47, '/var/www/eseco/documents/author_21/9.Efici__ncia Alimentar.xls', NULL, NULL, 52),
(48, '/var/www/eseco/documents/author_25/Dados diarios consumo e desempenho bezerras Gir.xlsx', NULL, NULL, 53);

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
  `detail_group` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK8wdtrv2sj8xua9d7s9pmq2cf4` (`author_id`),
  KEY `FK3y6i7ghj28e3kd4gnxh1i40kv` (`detail_group`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

--
-- Extraindo dados da tabela `exp_experiments`
--

INSERT INTO `exp_experiments` (`id`, `current_phase`, `date_created`, `date_ended`, `date_updated`, `description`, `key_words`, `name`, `status`, `version`, `author_id`, `detail_group`) VALUES
(2, 4, '2018-06-04', '2018-06-17', '2018-06-17', 'Avaliaram-se os efeitos da divergência fenotípica para eficiência alimentar (consumo alimentar residual - CAR, ganho de peso residual - GPR e eficiência de conversão alimentar - ECA), na digestibilidade, emissão de metano entérico (CH4), partição energética, produção de calor (PC), parâmetros sanguíneos, metabolismo de nitrogênio e temperaturas de diferentes regiões corporais.', 'calorimetria, consumo alimentar residual, digestibilidade, parâmetros sanguíneos, metano, termografia infravermelha.', 'Metabolismo em novilhas Girolando com fenótipos divergentes para eficiência alimentar', 1, '1.0.0', 14, NULL),
(3, 4, '2018-06-04', '2018-06-17', '2018-06-17', 'O objetivo deste experimento é abordar os parâmetros reprodutivos em novilhas Girolando F1 desde a puberdade até a primeira concepção e correlacionar a eficiência nutricional com alguns desses parâmetros.', 'dinâmica ovariana, puberdade, reprodução, fertilidade, eficiência alimentar, gado de leite', 'Eficiência Alimentar Sobre A Puberdade E Características Ovarianas Em 11 Novilhas Girolando (F1 Holandês X Gir)', 1, '1.0.0', 16, NULL),
(1, 4, '2018-06-04', '2018-06-15', '2018-08-15', 'O objetivo deste estudo foi avaliar possíveis divergências no consumo alimentar residual (CAR) e ganho de peso residual (GPR) em novilhas F1 Girolando e a relação com parâmetros de comportamento alimentar, temperatura da superfície do corpo por termografia por infravermelho, características morfológicas e de desempenho.', 'consumo de água, consumo alimentar residual, ganho de peso residual, morfologia, temperatura corporal', 'Relação do consumo alimentar residual e ganho de peso residual com características morfológicas, desempenho, comportamento alimentar, termográfica de infravermelho de novilhas Girolando', 1, '1.0.0', 8, NULL),
(10, 4, '2018-10-15', '2018-08-15', '2018-08-15', 'Avaliaram-se os efeitos da divergência fenotípica para eficiência alimenta (Consumo alimentar residual (CAR) e consumo e ganho de peso residual (CGR) no consumo, desempenho, medidas corporais, parâmetros ruminais e sanguineos, digestibilidade, partição de energia, trocas gasosas, eficiência do uso do nitrogênio e temperatura de superfície avaliada por termografia', 'metabólitos, digestibilidade, produção de calor', 'Eficiência alimentar e parâmetros produtivos em bezerras Gir', 1, '1.0.0', 25, 1),
(11, 4, '2018-08-16', '2018-08-16', '2018-08-16', 'Os objetivos deste estudo foram avaliar se há divergência fenotípica para a eficiência alimentar (EA) durante a fase de aleitamento e se a EA tem correlação com produção de calor (PC) medida pelo método da máscara facial ou pela temperatura superficial da pele pelo método da termografia infravermelha (TIV) e se estes métodos são aplicáveis em animais em aleitamento, também foram avaliados índices de eficiência alimentar e seus efeitos nas medidas corporais, variáveis sanguíneas e metabólitos ruminais.', 'variáveis sanguíneas e ruminais, calorimetria, consumo alimentar residual, ganho de peso residual, termografia.', 'Eficiência alimentar e parâmetros produtivos em bezerras F1 Holandês x Gir', 1, '1.0.0', 21, 1),
(12, 4, '2018-08-16', '2018-08-16', '2018-08-16', 'Objetivo: comparar os efeitos da divergência fenotípica para diferentes índices de eficiência alimentar (EA), o consumo alimentar residual (CAR), ganho de peso residual (GPR), Consumo e ganho residual (CGR) eficiência de conversão alimentar (ECA) e consumo residual de água (CRA) no consumo de matéria seca, desempenho, medidas morfológicas,  emissão de metano entérico (CH4), parâmetros sanguíneos, temperaturas de diferentes regiões corporais, comportamento de consumo de dieta e água e consumo de água.', 'consumo alimentar residual, eficiência alimentar, ganho de peso residual, Girolando, metano, termografia infravermelha', 'Relação De Diferentes Índices De Eficiência Alimentar Com Fenótipos Divergentes  De Novilhas F1 Girolando', 1, '1.0.0', 23, 1),
(13, 2, '2018-09-13', NULL, '2018-09-13', 'Ensaio de EA na fase de recria e cálculo dos índices CAR e GPR', 'CAR, GPR', 'Cálculo da EA na fase de recria', 0, '1.0.0', 19, NULL);

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
(3, 58),
(1, 4),
(1, 12),
(1, 17),
(1, 18),
(1, 1),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 13),
(1, 14),
(1, 15),
(1, 16),
(1, 46),
(10, 84),
(10, 83),
(10, 82),
(10, 81),
(11, 89),
(11, 88),
(11, 87),
(11, 86),
(11, 85),
(12, 102),
(12, 103);

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
(2, 29),
(2, 1),
(3, 29),
(3, 1),
(1, 1),
(10, 1),
(11, 29),
(11, 1),
(12, 1),
(13, 1);

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
(2, 3),
(3, 2),
(1, 2),
(11, 2),
(12, 3),
(13, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

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
(12, 3, '2018-06-17', 'Os resultados foram analisados estatisticamente e publicados.', 16, 3),
(13, 0, '2018-08-15', '-Existe diferença na eficiência alimentar entre animais durante a fase de aleitamento.\r\n-Bezerros mais eficientes terão igual desenvolvimento, mudanças em parâmetros fisiológicos, função ruminal, digestibilidade dos nutrientes, utilização do nitrogênio, produção de calor e emissão de metano que justifiquem o menor consumo alimentar residual\r\n', 25, 1),
(14, 1, '2018-08-15', 'Fase concluída com sucesso', 25, 1),
(15, 2, '2018-08-15', 'Fase concluída com sucesso', 25, 1),
(16, 3, '2018-08-15', 'Fase em andamento', 25, 1),
(17, 0, '2018-08-15', 'Fase concluida com sucesso', 25, 10),
(18, 1, '2018-08-15', 'Fase concluída com sucesso', 25, 10),
(19, 2, '2018-08-15', 'Fase concluída com sucesso', 25, 10),
(20, 3, '2018-08-15', 'Fase em andamento', 25, 10),
(21, 0, '2018-08-16', 'Investigação do problema realizada com sucesso.', 21, 11),
(22, 1, '2018-08-16', 'Prototipação realizada com sucesso.', 21, 11),
(23, 2, '2018-08-16', 'Execução realizada com sucesso.', 21, 11),
(24, 3, '2018-08-16', 'Publicação dos resultados realizada com sucesso.', 21, 11),
(25, 0, '2018-08-16', 'Investigação do problema concluído com sucesso.', 23, 12),
(26, 1, '2018-08-16', 'Prototipação  concluída com sucesso.', 23, 12),
(27, 2, '2018-08-16', ' Execução concluída com sucesso.', 23, 12),
(28, 3, '2018-08-16', 'Resultados publicados com sucesso.', 23, 12),
(29, 0, '2018-09-13', 'Experimento EA', 19, 13),
(30, 1, '2018-09-13', 'Experimento EA', 19, 13);

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
(2, 15),
(2, 14),
(2, 13),
(2, 12),
(3, 18),
(3, 17),
(3, 16),
(3, 12),
(1, 8),
(1, 11),
(1, 12),
(1, 13),
(10, 12),
(10, 25),
(11, 21),
(11, 12),
(11, 11),
(12, 23),
(12, 12),
(12, 15);

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
(3, 3),
(2, 4),
(1, 4),
(11, 1),
(12, 4),
(13, 2);

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
(2, 5),
(3, 6),
(1, 1),
(10, 11),
(11, 12),
(11, 13),
(12, 14),
(12, 15),
(13, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_ports`
--

CREATE TABLE IF NOT EXISTS `exp_ports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entity_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK830q3jyptlpgcj45opi97hmw5` (`entity_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

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
(18, 38),
(23, 43),
(24, 44),
(25, 45),
(26, 46),
(27, 47),
(28, 48),
(29, 49),
(30, 50),
(31, 51),
(32, 52),
(33, 53);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_wfms`
--

CREATE TABLE IF NOT EXISTS `exp_wfms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `exp_wfms`
--

INSERT INTO `exp_wfms` (`id`, `link`, `name`) VALUES
(1, 'kepler-project.org', 'Kepler'),
(2, 'www.taverna.org.uk', 'Taverna'),
(3, 'www.vistrails.org', 'Vistrails'),
(4, 'Service', 'Other'),
(5, '-', 'None');

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Extraindo dados da tabela `exp_workflows`
--

INSERT INTO `exp_workflows` (`id`, `date_created`, `description`, `link`, `name`, `value`, `version`, `author_id`, `wfms`) VALUES
(1, '2018-06-05', 'Processo de avaliação e classificação de animais por CAR e GPR.', '', 'Classificação da eficiência dos animais', NULL, '1.0.0', 8, 5),
(5, '2018-06-16', 'Processo de avaliação e classificação de animais por CAR e GPR e ECA, e análise de acordo com o consumo, a digestibilidade, partição energética, emissões de CH4 entérico, balanço de nitrogênio, metabólitos sanguíneos e termografia infravermelha.', '', 'Análise do metabolismo em novilhas com fenótipos divergentes para EA', NULL, '1.0.0', 14, 4),
(6, '2018-06-17', 'Estudar e caracterizar os parâmetros reprodutivos até a primeira concepção, incluindo-se idade e peso à puberdade, comportamento de estro, dinâmica folicular, resposta a protocolos hormonais e fertilidade em novilhas Girolando. Relacionar a eficiência nutricional com idade e peso à puberdade e alguns parâmetros reprodutivos em novilhas Girolando.', '', 'Análise da EA sobre a puberdade e características ovarianas', NULL, '1.0.0', 16, 4),
(11, '2018-08-15', 'Concluida', '', 'Eficiência alimentar e parâmetros produtivos em bezerras Gir', NULL, '1.0.0', 25, 3),
(12, '2018-08-16', 'Objetivo: avaliar se existe divergência para o consumo alimentar residual e ganho de peso residual na fase de aleitamento, e se a produção de calor estimada pelo método da máscara facial e de temperatura superficial pelo método da termografia infravermelha em bezerras F1 podem ser aplicadas na seleção de animais mais eficientes durante a fase de aleitamento e se essas técnicas têm correlação com os índices de eficiência alimentar.', '', 'Eficiência alimentar (CAR e GPR) e suas correlações com produção de calor e termografia', NULL, '1.0.0', 21, 5),
(13, '2018-08-16', 'Objetivos: examinar a relação entre a eficiência alimentar e as variáveis metabólicas do sangue e do rúmen e medidas morfológicas em bezerras classificadas para alta e baixa eficiência para CAR e GPR. E determinar se as variáveis do sangue e do rúmen podem ser usadas como indicadores de eficiência da utilização de alimentos e se podem ser aplicadas na seleção de bezerras de alta eficiência durante a fase de aleitamento', '', 'Eficiência alimentar (CAR e GPR) e seus efeitos nas medidas corporais, sangue e metabólitos ruminais em bezerras', NULL, '1.0.0', 21, 5),
(14, '2018-08-16', 'Classificação de novilhas F1 Girolando manejadas em pastagens tropicais de acordo com diferentes índices de eficiência alimentar e seus efeitos no consumo, desempenho, emissões de metano, comportamento, temperatura superficial de corpo, medidas morfológicas e consumo de água. ', '', 'Ensaio em sistemas à pasto ', NULL, '1.0.0', 23, 5),
(15, '2018-08-16', 'Objetivo: comparar o consumo de matéria seca, o desempenho, as trocas gasosas e a emissão de CH4 entérico, a temperatura da superfície do corpo obtida por termografia infravermelha, características morfométricas, o perfil metabólico  e o consumo de água de novilhas Girolando F1 de grupos fenotipicamente divergentes para os índices de eficiência alimentar .', '', 'Ensaio em sistema de confinamento', NULL, '1.0.0', 23, 5);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_activity`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_activity` (
  `order_exec` int(11) DEFAULT NULL,
  `activity_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  PRIMARY KEY (`activity_id`,`workflow_id`),
  KEY `FKo8td603fqb6sv954o1fwwxpy9` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `exp_workflow_activity`
--

INSERT INTO `exp_workflow_activity` (`order_exec`, `activity_id`, `workflow_id`) VALUES
(4, 5, 1),
(4, 4, 1),
(3, 3, 1),
(2, 2, 1),
(1, 1, 1),
(5, 6, 1),
(1, 18, 6),
(4, 20, 6),
(3, 22, 6),
(3, 6, 6),
(3, 13, 5),
(2, 12, 5),
(3, 6, 5),
(1, 11, 5),
(2, 19, 6),
(6, 21, 1),
(4, 15, 5),
(1, 23, 11),
(2, 24, 11),
(3, 25, 11),
(4, 26, 11),
(5, 27, 11),
(1, 28, 12),
(2, 29, 12),
(3, 30, 12),
(4, 31, 12),
(1, 29, 13),
(2, 32, 13),
(1, 33, 14),
(2, 34, 14),
(3, 35, 14),
(4, 36, 14),
(5, 37, 14),
(1, 38, 15),
(2, 39, 15),
(3, 40, 15),
(4, 41, 15);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Extraindo dados da tabela `exp_workflow_executions`
--

INSERT INTO `exp_workflow_executions` (`id`, `end_time`, `start_time`, `author_id`, `experiment_id`, `workflow`) VALUES
(1, '2018-06-15 04:25:00', '2018-06-15 04:25:00', 8, 1, 1),
(3, '2018-06-17 12:25:00', '2018-06-16 09:25:00', 14, 2, 5),
(4, '2018-06-17 10:42:00', '2018-06-17 04:42:00', 16, 3, 6),
(5, '2018-08-17 10:35:00', '2018-08-14 10:35:00', 21, 11, 12),
(6, '2018-08-18 10:35:00', '2018-08-14 10:35:00', 21, 11, 13),
(8, '2018-08-12 12:25:00', '2018-08-01 12:25:00', 25, 10, 11),
(9, '2018-08-07 16:40:00', '2018-08-01 16:40:00', 23, 12, 14),
(10, '2018-08-17 16:41:00', '2018-08-12 16:41:00', 23, 12, 15);

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
(4, 20),
(4, 21),
(4, 22),
(4, 23),
(5, 27),
(5, 25),
(5, 26),
(5, 28),
(6, 29),
(8, 30),
(8, 31),
(8, 32),
(8, 33),
(8, 34),
(9, 35),
(9, 36),
(9, 37),
(9, 38),
(9, 39),
(10, 40),
(10, 41),
(10, 42),
(10, 43);

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
(4, 18),
(4, 5),
(5, 25),
(5, 26),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(5, 31),
(8, 23),
(8, 24),
(8, 23),
(8, 24),
(8, 33);

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
(5, 25),
(5, 26),
(5, 27),
(5, 28),
(5, 29),
(5, 30),
(5, 31),
(5, 32),
(8, 24),
(8, 23),
(8, 33);

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
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

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
(13, NULL, NULL, b'1', 'bruna.r@experimentoembrapa.com', 'bruna.r@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-05-30 09:16:07'),
(14, NULL, NULL, b'1', 'pesquisador@estudodecaso.com.br', 'pesquisador@estudodecaso.com.br', '7c4a8d09ca3762af61e59520943dc26494f8941b', NULL, NULL, '2018-08-01 16:18:18'),
(16, NULL, NULL, b'1', 'juliana.leao@experimentoembrapa.com', 'juliana.leao@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-08-07 22:28:09'),
(17, NULL, NULL, b'1', 'raquel.costa@experimentoembrapa.com', 'raquel.costa@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-08-07 22:38:41'),
(18, NULL, NULL, b'1', 'aloma.leao@experimentoembrapa.com', 'aloma.leao@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-08-07 23:04:58'),
(19, NULL, NULL, b'1', 'camila.lage@experimentoembrapa.com', 'camila.lage@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-08-07 23:09:37'),
(20, NULL, NULL, b'1', 'mayara.lombardi@experimentoembrapa.com', 'mayara.lombardi@experimentoembrapa.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-08-07 23:13:25'),
(22, NULL, NULL, b'1', 'raianeqc@gmail.com', 'raianeqc@gmail.com', 'e1a666241c83c0e916572639002d711b615c985b', NULL, NULL, '2018-10-23 17:20:07');

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
(13, 2),
(14, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(22, 2),
(22, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
