-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 16-Jul-2018 às 10:13
-- Versão do servidor: 5.5.44
-- versão do PHP: 5.4.41-0+deb7u1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de Dados: `eseco`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Extraindo dados da tabela `core_agents`
--

INSERT INTO `core_agents` (`id`, `birthday`, `gender`, `name`, `user_id`) VALUES
(1, '1986-12-01 00:00:00', 'M', 'Leonardo de Aguiar', 1),
(2, '1980-01-01 00:00:00', 'M', 'Aroldo de Alcântara', 2),
(3, '1980-01-01 00:00:00', 'F', 'Beatriz Salvador', 3),
(4, '1980-01-01 00:00:00', 'M', 'Carlos Bibiano', 4),
(5, '1980-01-01 00:00:00', 'M', 'Demétrio Xavier', 5),
(6, '1980-01-01 00:00:00', 'F', 'Ester de Paula', 6),
(7, '1980-01-01 00:00:00', 'F', 'Fabiana Gonzaga', 7),
(8, '1980-01-01 00:00:00', 'F', 'Gumercinda Pascoal', 8),
(9, '1980-01-01 00:00:00', 'M', 'Heitor Cipriano', 9),
(10, '1980-01-01 00:00:00', 'F', 'Isabela Serafim', 10),
(11, '1980-01-01 00:00:00', 'M', 'José Bragança', 11),
(12, '1980-01-01 00:00:00', 'M', 'Felipe Magalhães Martins', 12),
(13, '1980-01-01 00:00:00', 'F', 'Olívia Magalhães Jardim', 13),
(14, '1980-01-01 00:00:00', 'F', 'Julia Brito Ito', 14),
(15, '1980-01-01 00:00:00', 'F', 'Virgínia Damasceno Nunes', 15),
(16, '1980-01-01 00:00:00', 'M', 'Marcos Maia Furtado', 16),
(17, '1980-01-01 00:00:00', 'F', 'Valquíria Esteves Shinoda', 17),
(18, '1980-01-01 00:00:00', 'F', 'Bruna Serra Bastos', 18),
(19, '1980-01-01 00:00:00', 'F', 'Débora Castilho Teixeira', 19),
(20, '1980-01-01 00:00:00', 'F', 'Raquel Pimentel Salgado', 20),
(21, '1980-01-01 00:00:00', 'F', 'Yolanda Ribeiro de Matos', 21),
(22, '1980-01-01 00:00:00', 'F', 'Beatriz Martins de Souza', 22),
(23, '1980-01-01 00:00:00', 'M', 'Vítor Martins Araújo', 23),
(24, '1980-01-01 00:00:00', 'M', 'Dionísio Louro', 24),
(25, '1980-01-01 00:00:00', 'M', 'Phillipe Marques', 25),
(26, '1980-01-01 00:00:00', 'F', 'Lenita Ambrosio', 26),
(27, '1980-01-01 00:00:00', 'M', 'Heitor Magaldi', 27),
(28, '1980-01-01 00:00:00', 'M', 'Pedro Ivo Lancellotta', 28),
(29, NULL, NULL, 'Luiz Eduardo', 29),
(30, NULL, NULL, 'jade', 30),
(31, NULL, NULL, 'josedavid', 31),
(32, NULL, NULL, 'Jose Maria David', 32),
(34, '2018-06-14 00:00:00', 'M', 'Nenc', 34);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `core_agents_developers`
--

INSERT INTO `core_agents_developers` (`id`, `photo`, `agent_id`) VALUES
(1, NULL, 1),
(2, NULL, 2),
(3, NULL, 3),
(4, NULL, 24),
(5, 'http://nenc.ufjf.br:8080/eseco/resources/upload/profiles/d9d73fef0bcc178e76a8c6cd6f2e636cf60f7962.jpg', 27);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_developers_institutions`
--

CREATE TABLE IF NOT EXISTS `core_agents_developers_institutions` (
  `developer_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  UNIQUE KEY `UK_i6dwtf4lnaf4oj9kl8e3fi738` (`institution_id`),
  KEY `FKhmayxudv5ag8pqn3028tscg1s` (`developer_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

--
-- Extraindo dados da tabela `core_agents_researchers`
--

INSERT INTO `core_agents_researchers` (`id`, `academic_status`, `display_name`, `kepler_id`, `mendeley_id`, `photo`, `title`, `agent_id`) VALUES
(1, 'Student  > Master', 'Leonardo de Aguiar Pereira', NULL, 'd2250d6e-7b67-357a-801f-bf0c4ca431ae', '', '', 1),
(2, 'Professor > Associate Professor', 'José Maria David', NULL, 'dea4a020-6fca-3a6f-9ec9-4b6a308344cc', 'https://photos.mendeley.com/20/b0/20b0ad970257dbea1dd7c16fb3f5fa3097ab51f1.png', 'DSc.', 5),
(3, 'Professor > Associate Professor', 'Victor Stroele', NULL, '231db8d7-5fbb-33e8-b373-3145dd5254c3', '', '', 6),
(4, 'Professor > Associate Professor', 'Regina Braga', NULL, '478fdccb-c490-368a-8b57-afc086894890', '', '', 7),
(5, 'Professor > Associate Professor', 'Marco Araújo', NULL, NULL, '', '', 8),
(6, 'Professor > Associate Professor', 'Fernanda Campos', NULL, NULL, '', '', 9),
(7, '', 'Isabela Serafim', NULL, NULL, '', '', 10),
(8, '', 'José Bragança', NULL, NULL, '', '', 11),
(9, '', 'Carlos Bibiano', NULL, NULL, '', '', 4),
(10, '', 'Felipe MagalhÃ£es Martins', NULL, NULL, '', '', 12),
(11, '', 'OlÃ­via MagalhÃ£es Jardim', NULL, NULL, '', '', 13),
(12, '', 'Julia Brito Ito', NULL, NULL, '', '', 14),
(13, '', 'VirgÃ­nia Damasceno Nunes', NULL, NULL, '', '', 15),
(14, '', 'Marcos Maia Furtado', NULL, NULL, '', '', 16),
(15, '', 'ValquÃ­ria Esteves Shinoda', NULL, NULL, '', '', 17),
(16, '', 'DÃ©bora Castilho Teixeira', NULL, NULL, '', '', 19),
(17, '', 'Bruna Serra Bastos', NULL, NULL, '', '', 18),
(18, '', 'Raquel Pimentel Salgado', NULL, NULL, '', '', 20),
(19, '', 'Yolanda Ribeiro de Matos', NULL, NULL, '', '', 21),
(20, '', 'Beatriz Martins de Souza', NULL, NULL, '', '', 22),
(21, '', 'VÃ­tor Martins AraÃºjo', NULL, NULL, '', '', 23),
(22, '', 'Phillipe Marques', NULL, NULL, 'http://nenc.ufjf.br:8080/eseco/resources/upload/profiles/549aa462bd3a99539b3b040aadbe2b7970ad35b0.jpg', '', 25),
(23, '', 'Lenita Ambrosio', NULL, NULL, 'http://nenc.ufjf.br:8080/eseco/resources/upload/profiles/f49f80e7abddb225ab5eb276bffbbc751b929b16.jpg', '', 26),
(24, '', 'Pedro Ivo Lancellotta', NULL, NULL, 'http://nenc.ufjf.br:8080/eseco/resources/upload/profiles/dddb2f0bb1488c5c429c45f3bc95413f90ba349a.jpg', '', 28);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_disciplines`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_disciplines` (
  `researcher_id` int(11) NOT NULL,
  `discipline_id` int(11) NOT NULL,
  KEY `FKaop4mqc7p60pj7ojdctcod69m` (`discipline_id`),
  KEY `FK3cljndx53oh3fhog3r3pcqlae` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `core_agents_researchers_disciplines`
--

INSERT INTO `core_agents_researchers_disciplines` (`researcher_id`, `discipline_id`) VALUES
(1, 7),
(2, 28),
(3, 2),
(4, 7),
(8, 5),
(10, 31),
(10, 32),
(10, 33),
(10, 34),
(11, 1),
(11, 2),
(11, 9),
(13, 10),
(13, 11),
(13, 17),
(22, 31),
(22, 34),
(22, 36),
(23, 31),
(23, 32),
(23, 34),
(23, 35),
(23, 36),
(10, 35),
(10, 36),
(24, 31),
(24, 32);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_institutions`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_institutions` (
  `researcher_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  KEY `FK4wlj79hpje54w1yhctjronm5t` (`institution_id`),
  KEY `FKnjibjwyfx0du85ecdpc8fbyql` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `core_agents_researchers_institutions`
--

INSERT INTO `core_agents_researchers_institutions` (`researcher_id`, `institution_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_agents_researchers_interests`
--

CREATE TABLE IF NOT EXISTS `core_agents_researchers_interests` (
  `researcher_id` int(11) NOT NULL,
  `interest_id` int(11) NOT NULL,
  KEY `FKr2qbtbwm9j8ovy2ssgulkv1e2` (`interest_id`),
  KEY `FKnh6mjtvpkjbia7pheato1wreb` (`researcher_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `core_agents_researchers_interests`
--

INSERT INTO `core_agents_researchers_interests` (`researcher_id`, `interest_id`) VALUES
(2, 2),
(3, 2),
(3, 3),
(3, 4),
(10, 2),
(11, 2),
(13, 2),
(22, 3),
(23, 3),
(24, 3);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=356 ;

--
-- Extraindo dados da tabela `core_agents_researchers_keywords`
--

INSERT INTO `core_agents_researchers_keywords` (`id`, `name`, `year`, `researcher_id`) VALUES
(1, 'Biology', '2002', 2),
(2, 'cscw', '2009', 2),
(3, 'Biological', '2009', 2),
(4, 'Agricultural', '2009', 2),
(5, 'service-oriented', '2009', 2),
(6, 'cscw framework, groupware toolkit, web-based deve', '2004', 2),
(7, 'Genetics', '2007', 2),
(8, 'groupware', '2007', 2),
(9, 'middleware', '2007', 2),
(10, 'service-oriented', '2007', 2),
(11, 'soa', '2011', 2),
(12, 'context', '2011', 2),
(13, 'interoperability', '2011', 2),
(14, 'middleware services', '2011', 2),
(15, 'ontology', '2011', 2),
(16, 'collaboration', '2016', 2),
(17, 'collaborative systems', '2016', 2),
(18, 'groupware', '2016', 2),
(19, 'interoperability', '2016', 2),
(20, 'pragmatic interoperability', '2016', 2),
(21, 'e-science', '2015', 2),
(22, 'ontology', '2015', 2),
(23, 'peer-to-peer', '2015', 2),
(24, 'semantic web', '2015', 2),
(25, 'service composition', '2015', 2),
(26, 'feature model', '2015', 2),
(27, 'scientific workflow', '2015', 2),
(28, 'sequence alignment', '2015', 2),
(29, 'software product line', '2015', 2),
(30, 'awareness', '2006', 2),
(31, 'context', '2006', 2),
(32, 'pre-meeting', '2006', 2),
(33, 'collaborative systems', '2014', 2),
(34, 'groupware', '2014', 2),
(35, 'mda', '2014', 2),
(36, 'mdd', '2014', 2),
(37, 'profile', '2014', 2),
(38, 'software product lines', '2014', 2),
(39, 'e-science', '2014', 2),
(40, 'opm', '2014', 2),
(41, 'ontology', '2014', 2),
(42, 'provenance', '2014', 2),
(43, 'semantic web', '2014', 2),
(44, 'web service', '2014', 2),
(45, 'domain engineering', '2012', 2),
(46, 'feature model', '2012', 2),
(47, 'feature models', '2012', 2),
(48, 'information systems', '2012', 2),
(49, 'modelling techniques', '2012', 2),
(50, 'ontology', '2012', 2),
(51, 'product line', '2012', 2),
(52, 'product-lines', '2012', 2),
(53, 'semantics', '2012', 2),
(54, 'software product line', '2012', 2),
(55, 'software design', '2012', 2),
(56, 'software product lines', '2012', 2),
(57, 'collaborative software maintenance, metrics, repu', '2016', 2),
(58, 'developing framework', '2014', 2),
(59, 'information visualization tools', '2014', 2),
(60, 'multiple views interactive environments', '2014', 2),
(61, 'awareness', '2014', 2),
(62, 'context', '2014', 2),
(63, 'scientific workflow', '2014', 2),
(64, 'software product line', '2014', 2),
(65, 'interoperability', '2013', 2),
(66, 'middleware services', '2013', 2),
(67, 'ontology', '2013', 2),
(68, 'thesaurus', '2013', 2),
(69, 'collaboration; collaborative projects; intelligent', '2010', 2),
(70, 'environmental management; groupware; life cycle;', '2010', 2),
(71, 'risk analysis', '2010', 2),
(72, 'awareness, context, context-awareness, cscw, grou', '2008', 2),
(73, 'peer-to-peer', '2013', 2),
(74, 'semantic web', '2013', 2),
(75, 'service composition', '2013', 2),
(76, 'collaborative development, pragmatic interoperabi', '2015', 2),
(77, 'groupware', '2010', 2),
(78, 'mda', '2010', 2),
(79, 'middleware services', '2010', 2),
(80, 'soa', '2010', 2),
(81, 'educational resource', '2014', 2),
(82, 'recommendation system', '2014', 2),
(83, 'social network', '2014', 2),
(84, 'virtual learning environment', '2014', 2),
(85, 'feature model', '2013', 2),
(86, 'product line', '2013', 2),
(87, 'scientific workflows', '2013', 2),
(88, 'sequence alignment', '2013', 2),
(89, 'model driven architecture, model driven engineeri', '2011', 2),
(90, 'soa', '2014', 2),
(91, 'middleware services', '2014', 2),
(92, 'semantic interoperability', '2014', 2),
(93, 'ontology rules', '2015', 2),
(94, 'open provenance model', '2015', 2),
(95, 'provenance metadata', '2015', 2),
(96, 'scientific experiment', '2015', 2),
(97, 'soa', '2009', 2),
(98, 'aspect-oriented programming', '2009', 2),
(99, 'awareness', '2009', 2),
(100, 'middleware services', '2009', 2),
(101, 'aspect-oriented programming', '2008', 2),
(102, 'awareness', '2008', 2),
(103, 'groupware', '2008', 2),
(104, 'middleware services', '2008', 2),
(105, 'soa', '2008', 2),
(106, 'middleware', '2010', 2),
(107, 'pre-meeting development', '2010', 2),
(108, 'clustering', '2017', 2),
(109, 'educational resources', '2017', 2),
(110, 'recommender systems', '2017', 2),
(111, 'software ecosystem', '2017', 2),
(112, 'architecture', '2017', 2),
(113, 'ontology', '2017', 2),
(114, 'quality', '2017', 2),
(115, 'seco health', '2017', 2),
(116, 'e-science', '2017', 2),
(117, 'provenance', '2017', 2),
(118, 'scientific experiment', '2017', 2),
(119, 'scientific workflow', '2017', 2),
(120, 'complex network', '2017', 2),
(121, 'visualization', '2017', 2),
(122, 'data provenance', '2017', 2),
(123, 'scientific experiment management', '2017', 2),
(124, 'workflow maintenance and evolution', '2017', 2),
(125, 'continuous integration', '2017', 2),
(126, 'continuous testing', '2017', 2),
(127, 'ontological inferences', '2017', 2),
(128, 'process improvement', '2017', 2),
(129, 'android', '2016', 3),
(130, 'context-aware computing', '2016', 3),
(131, 'data mining', '2016', 3),
(132, 'mobile applications', '2016', 3),
(133, 'self-learning', '2016', 3),
(134, 'user experience', '2016', 3),
(135, 'educational resource', '2014', 3),
(136, 'recommendation system', '2014', 3),
(137, 'social network', '2014', 3),
(138, 'virtual learning environment', '2014', 3),
(139, 'ontology', '2016', 3),
(140, 'peer-to-peer', '2016', 3),
(141, 'semantic web', '2016', 3),
(142, 'service composition', '2016', 3),
(143, 'e-science', '2016', 3),
(144, 'group detection', '2011', 3),
(145, 'scientific collaboration', '2011', 3),
(146, 'scientific social networks analysis', '2011', 3),
(147, 'clustering', '2017', 3),
(148, 'educational resources', '2017', 3),
(149, 'recommender systems', '2017', 3),
(150, 'software ecosystem', '2017', 3),
(151, 'e-science', '2017', 3),
(152, 'ontology', '2017', 3),
(153, 'provenance', '2017', 3),
(154, 'scientific experiment', '2017', 3),
(155, 'scientific workflow', '2017', 3),
(156, 'complex network', '2017', 3),
(157, 'visualization', '2017', 3),
(158, 'data provenance', '2017', 3),
(159, 'scientific experiment management', '2017', 3),
(160, 'workflow maintenance and evolution', '2017', 3),
(161, 'ontologies', '2012', 4),
(162, 'semantic web', '2012', 4),
(163, 'web service', '2012', 4),
(164, 'workflow composition', '2012', 4),
(165, 'semantic annotation', '2009', 4),
(166, 'semantic web', '2009', 4),
(167, 'web service', '2009', 4),
(168, 'workflows', '2009', 4),
(169, 'ontology rules', '2015', 4),
(170, 'open provenance model', '2015', 4),
(171, 'provenance metadata', '2015', 4),
(172, 'scientific experiment', '2015', 4),
(173, 'scientific workflow', '2015', 4),
(174, 'semantic web', '2015', 4),
(175, 'ontology', '2013', 4),
(176, 'peer-to-peer', '2013', 4),
(177, 'semantic web', '2013', 4),
(178, 'service composition', '2013', 4),
(179, 'biological models', '2010', 4),
(180, 'model composition', '2010', 4),
(181, 'ontology', '2010', 4),
(182, 'reuse', '2010', 4),
(183, 'semantic web services', '2010', 4),
(184, 'e-science', '2010', 4),
(185, 'component based engineering', '2001', 4),
(186, 'component repositories', '2001', 4),
(187, 'domain engineering', '2001', 4),
(188, 'software classification and identification', '2001', 4),
(189, 'multi-agent systems', '2011', 4),
(190, 'ontologies', '2011', 4),
(191, 'semantic web services', '2011', 4),
(192, 'model-driven development', '2013', 4),
(193, 'openehr', '2013', 4),
(194, 'e-science', '2014', 4),
(195, 'opm', '2014', 4),
(196, 'ontology', '2014', 4),
(197, 'provenance', '2014', 4),
(198, 'semantic web', '2014', 4),
(199, 'web service', '2014', 4),
(200, 'e-science', '2009', 4),
(201, 'ontology', '2009', 4),
(202, 'soa', '2009', 4),
(203, 'semantic web services', '2009', 4),
(204, 'collaborative software development', '2003', 4),
(205, 'component-based software engineering', '2003', 4),
(206, 'reuse-oriented development', '2003', 4),
(207, 'software development environment', '2003', 4),
(208, 'awareness', '2014', 4),
(209, 'context', '2014', 4),
(210, 'scientific workflow', '2014', 4),
(211, 'software product line', '2014', 4),
(212, 'agents', '2006', 4),
(213, 'cbd', '2006', 4),
(214, 'informational retrieval', '2006', 4),
(215, 'reuse', '2006', 4),
(216, 'e-science', '2011', 4),
(217, 'ontology', '2011', 4),
(218, 'domain engineering', '2012', 4),
(219, 'feature model', '2012', 4),
(220, 'feature models', '2012', 4),
(221, 'information systems', '2012', 4),
(222, 'modelling techniques', '2012', 4),
(223, 'ontology', '2012', 4),
(224, 'bird', '2012', 4),
(225, 'degenerative', '2012', 4),
(226, 'cell', '2012', 4),
(227, 'software product line', '2012', 4),
(228, 'software design', '2012', 4),
(229, 'software product lines', '2012', 4),
(230, 'agents', '2009', 4),
(231, 'agents', '2011', 4),
(232, 'domain ontology', '2011', 4),
(233, 'e-learning', '2011', 4),
(234, 'learning objects', '2011', 4),
(235, 'metadata', '2011', 4),
(236, 'metadata provenance', '2011', 4),
(237, 'open provenance model', '2011', 4),
(238, 'scientific workflow', '2011', 4),
(239, 'semantic web', '2011', 4),
(240, 'multi-agent systems', '2010', 4),
(241, 'soa', '2010', 4),
(242, 'component based development', '2002', 4),
(243, 'component retrieval', '2002', 4),
(244, 'domain engineering', '2002', 4),
(245, 'feature model', '2013', 4),
(246, 'product line', '2013', 4),
(247, 'scientific workflows', '2013', 4),
(248, 'sequence alignment', '2013', 4),
(249, 'educational resource', '2014', 4),
(250, 'recommendation system', '2014', 4),
(251, 'social network', '2014', 4),
(252, 'virtual learning environment', '2014', 4),
(253, 'development preocess', '2010', 4),
(254, 'quality', '2010', 4),
(255, 'soa', '2014', 4),
(256, 'collaborative systems', '2014', 4),
(257, 'middleware services', '2014', 4),
(258, 'semantic interoperability', '2014', 4),
(259, 'scientific workflow', '2010', 4),
(260, 'semantic', '2010', 4),
(261, 'microwave circuits;', '2004', 4),
(262, 'health information system', '2014', 4),
(263, 'model transformation component', '2014', 4),
(264, 'model-driven software development', '2014', 4),
(265, 'openehr', '2014', 4),
(266, 'feature model', '2015', 4),
(267, 'ontology', '2015', 4),
(268, 'sequence alignment', '2015', 4),
(269, 'software product line', '2015', 4),
(270, 'clustering', '2017', 4),
(271, 'educational resources', '2017', 4),
(272, 'recommender systems', '2017', 4),
(273, 'software ecosystem', '2017', 4),
(274, 'architecture', '2017', 4),
(275, 'ontology', '2017', 4),
(276, 'quality', '2017', 4),
(277, 'seco health', '2017', 4),
(278, 'e-science', '2017', 4),
(279, 'provenance', '2017', 4),
(280, 'scientific experiment', '2017', 4),
(281, 'scientific workflow', '2017', 4),
(282, 'complex network', '2017', 4),
(283, 'visualization', '2017', 4),
(284, 'data provenance', '2017', 4),
(285, 'scientific experiment management', '2017', 4),
(286, 'workflow maintenance and evolution', '2017', 4),
(287, 'continuous integration', '2017', 4),
(288, 'continuous testing', '2017', 4),
(289, 'ontological inferences', '2017', 4),
(290, 'process improvement', '2017', 4),
(291, 'scientific workflows', '2017', 4),
(292, 'software architecture', '2017', 4),
(293, 'workflow interchange', '2017', 4),
(294, 'workflow patterns', '2017', 4),
(295, 'model transformations', '2015', 4),
(296, 'scientific workflows', '2015', 4),
(297, 'workflow patterns', '2015', 4),
(298, 'data provenance', '2016', 4),
(299, 'ontology', '2016', 4),
(300, 'software process', '2016', 4),
(301, 'e-science', '2015', 4),
(302, 'peer-to-peer', '2015', 4),
(303, 'service composition', '2015', 4),
(304, 'application software', '2000', 4),
(305, 'artificial intelligence', '2000', 4),
(306, 'computer science', '2000', 4),
(307, 'costs', '2000', 4),
(308, 'information filtering', '2000', 4),
(309, 'information retrieval', '2000', 4),
(310, 'internet', '2000', 4),
(311, 'ontologies', '2000', 4),
(312, 'search engines', '2000', 4),
(313, 'terminology', '2000', 4),
(314, 'collaboration', '2016', 4),
(315, 'collaborative systems', '2016', 4),
(316, 'groupware', '2016', 4),
(317, 'interoperability', '2016', 4),
(318, 'pragmatic interoperability', '2016', 4),
(319, 'interoperability model', '2016', 4),
(320, 'collaborative work', '2017', 4),
(321, 'peer-to-peer network', '2017', 4),
(322, 'e-science infrastructure', '2017', 4),
(323, 'e-seco', '2016', 4),
(324, 'workflow evolution', '2016', 4),
(325, 'workflow maintenance', '2016', 4),
(326, 'peer-to-peer', '2016', 4),
(327, 'semantic web', '2016', 4),
(328, 'service composition', '2016', 4),
(329, 'e-science', '2016', 4),
(330, 'Genetics', '2017', 6),
(331, 'Biochemistry', '2017', 6),
(332, 'Pharmacology', '2016', 6),
(333, 'biology', '2017', 6),
(334, 'degenerative', '2016', 3),
(335, 'biochemistry', '2017', 3),
(336, 'pharmacology', '2017', 3),
(337, 'reproduction', '2017', 3),
(338, 'Agriculture', '2017', 22),
(339, 'Dry Matter', '2017', 22),
(340, 'Food Efficiency', '2017', 22),
(341, 'Agriculture', '2017', 23),
(342, 'Dry Matter', '2017', 23),
(343, 'Food Efficiency', '2017', 23),
(344, 'Bovine', '2017', 23),
(345, 'Weight Gain', '2017', 23),
(346, 'Agriculture', '2017', 10),
(347, 'Bovine', '2017', 10),
(348, 'Meal', '2017', 10),
(349, 'Dry Matter', '2017', 10),
(350, 'Weight Gain', '2017', 10),
(351, 'Food Efficiency', '2017', 10),
(352, 'Agriculture', '2018', 24),
(353, 'Bovine', '2018', 24),
(354, 'Cow', '2018', 24),
(355, 'Milk', '2018', 24);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

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
(28, 'Juiz de Fora', 13);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=248 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Extraindo dados da tabela `core_disciplines`
--

INSERT INTO `core_disciplines` (`id`, `name`, `parent`) VALUES
(1, 'Biology', NULL),
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
(29, 'Veterinary Science and Veterinary Medicine', NULL),
(31, 'Agriculture', NULL),
(32, 'Bovine', NULL),
(33, 'Meal', NULL),
(34, 'Dry Matter', NULL),
(35, 'Weight Gain', NULL),
(36, 'Food Efficiency', NULL);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `core_institutions`
--

INSERT INTO `core_institutions` (`id`, `name`, `city_id`) VALUES
(1, 'Federal University of Juiz de Fora', 28);

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_interests`
--

CREATE TABLE IF NOT EXISTS `core_interests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Extraindo dados da tabela `core_interests`
--

INSERT INTO `core_interests` (`id`, `name`) VALUES
(1, 'Collaborative Systems'),
(2, 'Global Software Development'),
(3, 'e-Science'),
(4, 'Software Visualization'),
(5, 'Context awareness'),
(6, 'Data provenance');

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `core_research_group_researcher`
--

CREATE TABLE IF NOT EXISTS `core_research_group_researcher` (
  `research_group_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  KEY `FKmp014i6g70kmem7j7k0um55ge` (`researcher_id`),
  KEY `FKdwlqyjavrshab1xhd5wrgut5n` (`research_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Extraindo dados da tabela `exp_activities`
--

INSERT INTO `exp_activities` (`id`, `date_created`, `description`, `name`, `author_id`) VALUES
(1, '2012-01-15', '', 'Activity 01', 10),
(2, '2012-01-15', '', 'Activity 02', 10),
(3, '2012-01-15', '', 'Activity 03', 10),
(4, '2012-02-05', '', 'Activity 04', 11),
(5, '2012-02-05', '', 'Activity 05', 11),
(6, '2012-02-05', '', 'Activity 06', 11),
(7, '2013-09-08', '', 'Activity 07', 12),
(8, '2013-09-08', '', 'Activity 08', 12),
(9, '2013-09-08', '', 'Activity 09', 12),
(10, '2013-04-12', '', 'Activity 10', 13),
(11, '2013-04-12', '', 'Activity 11', 13),
(12, '2013-04-12', '', 'Activity 12', 13),
(13, '2014-04-25', '', 'Activity 13', 14),
(14, '2014-04-25', '', 'Activity 14', 14),
(15, '2014-04-25', '', 'Activity 15', 14),
(16, '2014-06-22', '', 'Activity 16', 15),
(17, '2014-06-22', '', 'Activity 17', 15),
(18, '2014-06-22', '', 'Activity 18', 15),
(19, '2015-11-14', '', 'Activity 19', 16),
(20, '2015-11-14', '', 'Activity 20', 16),
(21, '2015-11-14', '', 'Activity 21', 16),
(22, '2015-04-15', '', 'Activity 22', 17),
(23, '2015-04-15', '', 'Activity 23', 17),
(24, '2015-04-15', '', 'Activity 24', 17),
(25, '2016-09-27', '', 'Activity 25', 18),
(26, '2016-09-27', '', 'Activity 26', 18),
(27, '2016-09-27', '', 'Activity 27', 18),
(28, '2016-10-09', '', 'Activity 28', 19),
(29, '2016-10-09', '', 'Activity 29', 19),
(30, '2016-10-09', '', 'Activity 30', 19),
(31, '2017-10-11', '', 'Activity 31', 20),
(32, '2017-10-11', '', 'Activity 32', 20),
(33, '2017-10-11', '', 'Activity 33', 20),
(34, '2017-11-08', '', 'Activity 34', 21),
(35, '2017-11-08', '', 'Activity 35', 21),
(36, '2017-11-08', '', 'Activity 36', 21);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activities_workflowservices`
--

CREATE TABLE IF NOT EXISTS `exp_activities_workflowservices` (
  `activity_id` int(11) NOT NULL,
  `workflowservice_id` int(11) NOT NULL,
  KEY `FKlfri0mlyljcchw69d0ww7lwva` (`workflowservice_id`),
  KEY `FKkt0tkhnlip2yrjog52hc55qqh` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_activities_workflowservices`
--

INSERT INTO `exp_activities_workflowservices` (`activity_id`, `workflowservice_id`) VALUES
(6, 7),
(7, 7),
(8, 7),
(9, 7),
(10, 7),
(11, 7),
(12, 8),
(12, 9),
(12, 8),
(12, 9),
(12, 8),
(12, 9),
(13, 7),
(14, 7),
(15, 7),
(16, 7),
(17, 7),
(18, 7),
(18, 8),
(18, 9),
(18, 7),
(18, 8),
(18, 9),
(18, 7),
(18, 8),
(18, 9),
(19, 7),
(20, 7),
(21, 7),
(22, 7),
(23, 7),
(24, 7),
(26, 7),
(27, 7),
(29, 7),
(30, 7),
(31, 7),
(32, 10),
(32, 8),
(32, 9),
(33, 10),
(33, 8),
(33, 9),
(34, 7),
(35, 7),
(1, 11),
(2, 12),
(3, 13);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `exp_activity_executions`
--

INSERT INTO `exp_activity_executions` (`id`, `end_time`, `start_time`, `activity`, `author_id`) VALUES
(1, '2017-11-14 16:08:25', '2017-11-14 16:03:22', 1, 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_inputs`
--

CREATE TABLE IF NOT EXISTS `exp_activity_inputs` (
  `activity_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  UNIQUE KEY `UK_b0yevq9ij0tuf6f04r0bd7wtc` (`port_id`),
  KEY `FK8iyfqt6yrvbp4ce285l8sa2v8` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_activity_outputs`
--

CREATE TABLE IF NOT EXISTS `exp_activity_outputs` (
  `activity_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  UNIQUE KEY `UK_fyp6ekgqyvy8ve5q803w5cd4u` (`port_id`),
  KEY `FKsxoc2ds8xl42dcdl52jdrxmwn` (`activity_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Extraindo dados da tabela `exp_experiments`
--

INSERT INTO `exp_experiments` (`id`, `current_phase`, `date_created`, `date_ended`, `date_updated`, `description`, `key_words`, `name`, `status`, `version`, `author_id`) VALUES
(1, 2, '2012-01-15', NULL, '2018-01-29', 'This experiment studies how the degenerative cells of birds act', 'biology, bird, degenerative, cell', 'Birds degenerative cells experiment ', 0, '1', 10),
(2, 2, '2012-02-05', NULL, NULL, '', 'analysis, DNA, grid, moteur, sequence', 'DNA sequence analysis', 0, '1', 11),
(3, 2, '2013-09-08', NULL, NULL, '', 'g-language, analysis, genome', 'G-language Genome Analysis Environment', 0, '1', 12),
(4, 2, '2013-04-12', NULL, NULL, '', 'information, nssnp, nucleotide, OMIM, pathway, snp, structure', 'DataBiNS with Kegg ID', 0, '1', 13),
(5, 2, '2014-04-25', NULL, NULL, '', 'alignment, analysis, sequence, services, soaplab', 'Biomart and EMBOSS analysis', 0, '1', 14),
(6, 2, '2014-06-22', NULL, NULL, '', 'acids, analysis, biovel, data, diversity, ecological, metagenomics, nucleotide, pca, plots', 'Microbial Metagenomic Trait Statistical Analysis', 0, '1', 15),
(7, 2, '2015-11-14', NULL, NULL, '', 'galaxy, metagenomics', 'AmrPlusPlus Paired', 0, '1', 16),
(8, 2, '2015-04-15', NULL, NULL, '', 'biome-bgc, biovel, database, ecosystem functioning, ecosystem modeling, ecosystem', 'Biome-BGC ESI', 0, '1', 17),
(9, 2, '2016-09-27', NULL, NULL, '', 'affymetrix, dml, enrichment analyis, gene ontology', 'Gene set enrichment analysis', 0, '1', 18),
(10, 2, '2016-10-09', NULL, NULL, '', 'bioinformatics, cdk, cdk-taverna, chemoinformatics, compound, curation, drug, ebi', 'Scoring small molecules for metabolite likeness', 0, '1', 19),
(11, 2, '2017-10-11', NULL, NULL, '', 'analytics, classification, descriptor, image', 'Texture classification: Knime Image Analytics', 0, '1', 20),
(12, 2, '2017-11-08', NULL, NULL, '', 'angiogenesis, image feature extraction, image mining', 'Angiogenesis Feature Extraction', 0, '1', 21),
(13, 2, '2017-11-15', NULL, NULL, '', 'agriculture, bovine, meal, dry matter, weight gain, food efficiency', 'Bovine Food Efficiency ', 0, '1', 10);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_discipline`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_discipline` (
  `experiment_id` int(11) NOT NULL,
  `discipline_id` int(11) NOT NULL,
  KEY `FK6405qih7ujt75qdek5jdjilxh` (`discipline_id`),
  KEY `FKicvn8r1iufvhwgbjs46n832wg` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_experiment_discipline`
--

INSERT INTO `exp_experiment_discipline` (`experiment_id`, `discipline_id`) VALUES
(1, 22),
(1, 3),
(1, 1),
(2, 1),
(2, 3),
(2, 1),
(2, 3),
(2, 22),
(2, 1),
(2, 3),
(3, 1),
(3, 3),
(3, 22),
(3, 1),
(3, 3),
(4, 1),
(4, 3),
(4, 22),
(4, 1),
(4, 3),
(5, 1),
(5, 3),
(5, 22),
(5, 1),
(5, 3),
(6, 1),
(6, 3),
(6, 22),
(6, 1),
(6, 3),
(7, 1),
(7, 3),
(7, 22),
(7, 1),
(7, 3),
(8, 1),
(8, 3),
(8, 22),
(8, 1),
(8, 3),
(9, 1),
(9, 3),
(9, 22),
(9, 1),
(9, 3),
(10, 1),
(10, 3),
(10, 22),
(10, 1),
(10, 3),
(11, 1),
(11, 3),
(11, 22),
(11, 1),
(11, 3),
(12, 1),
(12, 3),
(12, 22),
(12, 1),
(12, 3),
(13, 31),
(13, 32),
(13, 33),
(13, 34),
(13, 35),
(13, 36);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_institution`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_institution` (
  `experiment_id` int(11) NOT NULL,
  `institution_id` int(11) NOT NULL,
  KEY `FK30q79mt5qlny8appo6dleufhh` (`institution_id`),
  KEY `FKlyfd8lk44lvpi327gij49ejv` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_researcher`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_researcher` (
  `experiment_id` int(11) NOT NULL,
  `researcher_id` int(11) NOT NULL,
  KEY `FK39mgah2kmqt5mbre5lubvmbh4` (`researcher_id`),
  KEY `FK36kab23m9ujw80yr0k0uxismy` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_experiment_researcher`
--

INSERT INTO `exp_experiment_researcher` (`experiment_id`, `researcher_id`) VALUES
(1, 10),
(2, 11),
(3, 12),
(3, 10),
(4, 13),
(4, 11),
(4, 12),
(5, 14),
(5, 13),
(5, 10),
(6, 15),
(7, 16),
(7, 13),
(8, 17),
(9, 18),
(10, 19),
(10, 16),
(10, 17),
(11, 20),
(11, 18),
(11, 19),
(12, 21),
(12, 20),
(13, 10),
(13, 22);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_research_group`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_research_group` (
  `experiment_id` int(11) NOT NULL,
  `research_group_id` int(11) NOT NULL,
  KEY `FKk0f62wi8ou8gy95afpvn31369` (`research_group_id`),
  KEY `FKp405w03fa0qljtm7q4gdxkyu4` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_experiment_workflow`
--

CREATE TABLE IF NOT EXISTS `exp_experiment_workflow` (
  `experiment_id` int(11) NOT NULL,
  `workflow_id` int(11) NOT NULL,
  KEY `FKmq6ldbobb91incdsjidwq95p1` (`workflow_id`),
  KEY `FK72eci3bh650vx70nkt2lfccah` (`experiment_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_experiment_workflow`
--

INSERT INTO `exp_experiment_workflow` (`experiment_id`, `workflow_id`) VALUES
(1, 2),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 4),
(10, 5),
(11, 6),
(12, 7),
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
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_wfms`
--

CREATE TABLE IF NOT EXISTS `exp_wfms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `exp_wfms`
--

INSERT INTO `exp_wfms` (`id`, `link`, `name`) VALUES
(1, NULL, 'Taverna'),
(2, NULL, 'Kepler');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `exp_workflows`
--

INSERT INTO `exp_workflows` (`id`, `date_created`, `description`, `link`, `name`, `value`, `version`, `author_id`, `wfms`) VALUES
(1, '2017-11-11', '', NULL, 'Bovine Workflow for Food Efficiency Measurement', NULL, '1', 10, 2),
(2, '2013-09-08', '', NULL, 'Workflow 02', NULL, '1', 12, 2),
(3, '2013-04-12', '', NULL, 'Workflow 03', NULL, '1', 13, 2),
(4, '2014-06-22', '', NULL, 'Workflow 04', NULL, '1', 15, 2),
(5, '2016-09-27', '', NULL, 'Workflow 05', NULL, '1', 18, 2),
(6, '2016-10-09', '', NULL, 'Workflow 06', NULL, '1', 19, 2),
(7, '2017-10-11', '', NULL, 'Workflow 07', NULL, '1', 20, 2),
(8, '2017-11-08', '', NULL, 'Workflow 08', NULL, '1', 21, 2);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_activity`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_activity` (
  `workflow_id` int(11) NOT NULL,
  `activity_id` int(11) NOT NULL,
  UNIQUE KEY `UK_5uphwfpbygyt65yo2ckkfw6yh` (`activity_id`),
  KEY `FKo8td603fqb6sv954o1fwwxpy9` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_workflow_activity`
--

INSERT INTO `exp_workflow_activity` (`workflow_id`, `activity_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 6),
(2, 7),
(2, 8),
(2, 9),
(2, 10),
(3, 11),
(3, 12),
(3, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(4, 18),
(4, 19),
(5, 20),
(5, 21),
(5, 22),
(5, 23),
(5, 24),
(6, 25),
(6, 26),
(6, 27),
(6, 28),
(6, 29),
(7, 30),
(7, 31),
(7, 32),
(7, 33),
(7, 34),
(8, 35),
(8, 36);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `exp_workflow_executions`
--

INSERT INTO `exp_workflow_executions` (`id`, `end_time`, `start_time`, `author_id`, `experiment_id`, `workflow`) VALUES
(1, '2017-11-14 16:22:25', '2017-11-14 16:00:01', 10, 13, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_execution_activity_execution`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_execution_activity_execution` (
  `workflow_execution_id` int(11) NOT NULL,
  `activity_execution_id` int(11) NOT NULL,
  UNIQUE KEY `UK_93w0is4v17g1k0noldtw2m27r` (`activity_execution_id`),
  KEY `FKh8s3866jdht94q2rbhj72nfam` (`workflow_execution_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `exp_workflow_execution_activity_execution`
--

INSERT INTO `exp_workflow_execution_activity_execution` (`workflow_execution_id`, `activity_execution_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_inputs`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_inputs` (
  `workflow_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  UNIQUE KEY `UK_k6bt60b7wggy083oo1ny3bn1d` (`port_id`),
  KEY `FKmjmnxve10uj2na4jw2et0mrvg` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `exp_workflow_outputs`
--

CREATE TABLE IF NOT EXISTS `exp_workflow_outputs` (
  `workflow_id` int(11) NOT NULL,
  `port_id` int(11) NOT NULL,
  UNIQUE KEY `UK_mwe4e6995dn4dbqrrc3a2hq08` (`port_id`),
  KEY `FKqrnhq7rsyaknym2y0fx9ds1wm` (`workflow_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_components`
--

CREATE TABLE IF NOT EXISTS `res_components` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date_created` datetime DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `author_id` int(11) NOT NULL,
  `type_id` int(11) NOT NULL,
  `documentation_url` text,
  PRIMARY KEY (`id`),
  KEY `FKfa2l3vre3kbnar6k9alu8q9fl` (`author_id`),
  KEY `FKgvn6qp9ggx1vjv0xuw9aa8w8w` (`type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=164 ;

--
-- Extraindo dados da tabela `res_components`
--

INSERT INTO `res_components` (`id`, `date_created`, `date_updated`, `name`, `author_id`, `type_id`, `documentation_url`) VALUES
(1, '2011-10-25 00:00:00', NULL, 'Phenotype Translation Primitive Type', 3, 2, NULL),
(2, '2011-10-25 00:00:00', NULL, 'Phenotype Translation', 3, 2, NULL),
(3, '2011-10-25 00:00:00', NULL, 'Matrix Combination Phenotypes Primitive Types', 2, 2, NULL),
(4, '2011-10-25 00:00:00', NULL, 'Matrix Combination Phenotypes', 2, 2, NULL),
(5, '2011-10-25 00:00:00', NULL, 'Blood Type Probability', 2, 2, NULL),
(6, '2011-10-25 00:00:00', NULL, 'Blood Type Probability Primitive Type', 2, 2, NULL),
(13, '2012-07-23 00:00:00', NULL, 'Find Scientific Names', 2, 2, NULL),
(45, '2015-08-20 00:00:00', '2017-10-17 12:28:07', 'Fetch Bar Code', 3, 2, NULL),
(46, '2015-08-20 00:00:00', '2017-08-22 12:52:45', 'Specimen Information Search', 3, 2, NULL),
(158, '2016-08-20 00:00:00', NULL, 'Biological Specimen Scientific Name Retriever', 3, 2, NULL),
(159, '2018-01-26 16:21:35', NULL, 'Mean Experiment Diary Weight Gain', 2, 2, NULL),
(160, '2018-01-26 17:26:07', NULL, 'Mean Experiment Mean Metabolic Weight', 2, 2, NULL),
(161, '2018-01-26 17:26:35', NULL, 'Food Dry Matter Percentage', 2, 2, NULL),
(162, '2018-01-29 19:35:50', NULL, 'Dry Matter Ingestion Index', 4, 2, 'http://nenc.ufjf.br:8080/eseco/resources/docs/components/doc-dry-matter-ingestion-index.pdf'),
(163, '2018-01-31 20:16:49', NULL, 'CAR INDEX', 5, 2, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_component_developers`
--

CREATE TABLE IF NOT EXISTS `res_component_developers` (
  `component_id` int(11) NOT NULL,
  `developer_id` int(11) NOT NULL,
  UNIQUE KEY `UK_h941jk5dpq11i0uiaqo2t7gby` (`developer_id`),
  KEY `FKeoykgm79uj440dfm89tkidhgb` (`component_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_component_types`
--

CREATE TABLE IF NOT EXISTS `res_component_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

--
-- Extraindo dados da tabela `res_workflow_services`
--

INSERT INTO `res_workflow_services` (`id`, `description`, `internal_class`, `nature`, `type`, `url`, `component_id`) VALUES
(1, 'Phenotype Translation Primitive Type', 'br.ufjf.pgcc.eseco.services.biology.PhenotypeTranslationPrimitiveType', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/phenotype-translation-primitive-type', 1),
(2, 'Phenotype Translation', 'br.ufjf.pgcc.eseco.services.biology.PhenotypeTranslation', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/phenotype-translation', 2),
(3, 'Matrix Combination Phenotypes Primitive Types', 'br.ufjf.pgcc.eseco.services.biology.MatrixCombinationPhenotypesPrimitiveTypes', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/matrix-combination-phenotypes-primitive-types', 3),
(4, 'Matrix Combination Phenotypes', 'br.ufjf.pgcc.eseco.services.biology.MatrixCombinationPhenotypes', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/matrix-combination-phenotypes', 4),
(5, 'Blood Type Probability', 'br.ufjf.pgcc.eseco.services.biology.BloodTypeProbability', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/bloodtype-probability', 5),
(6, 'Blood Type Probability Primitive Type', 'br.ufjf.pgcc.eseco.services.biology.BloodTypeProbabilityPrimitiveType', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/bloodtype-probability-primitive-type', 6),
(7, 'Find animal specimen scientific names by their common names', 'br.ufjf.pgcc.eseco.services.biology.FindScientificNames', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/find-scientific-names', 13),
(8, 'Obtain the unique barcode identification of a specimen through its scientific name', 'br.ufjf.pgcc.eseco.services.biology.FetchBarCode', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/bar-code-by-scientific-name', 45),
(9, 'Get specimen informations by providing an barcode identifier', 'br.ufjf.pgcc.eseco.services.biology.SpecimenInformationSearch', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/specimen-information-by-bar-code', 46),
(10, 'Retrieve the Scientific Name of a biological specimen by providing an common english specimen name', 'br.ufjf.pgcc.eseco.services.biology.BiologicalSpecimenScientificNameRetriever', '', 'REST', 'http://nenc.ufjf.br:8080/eseco/api/biology/specimen-scientific-name-by-common-name', 158),
(11, 'Obtain the average of the daily weight gains of the set of all animals from an experiment', 'br.ufjf.pgcc.eseco.services.agriculture.MeanExperimentDiaryWeightGain', NULL, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/agriculture/mean-experiment-diary-weight-gain', 159),
(12, 'Obtain the mean of the mean metabolic weights of the set of all animals from an experiment', 'br.ufjf.pgcc.eseco.services.agriculture.MeanExperimentMeanMetabolicWeight', NULL, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/agriculture/mean-experiment-mean-metabolic-weight', 160),
(13, 'Obtain the percentage of dry matter for a given food', 'br.ufjf.pgcc.eseco.services.agriculture.FoodDryMatterPercentage', NULL, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/agriculture/food-dry-matter-percentage', 161),
(14, 'Obter o índice de ingestão de matéria seca referente ao conjunto de todos os animais de um experimento. Consulte a documentação para maiores detalhes.', 'br.ufjf.pgcc.eseco.services.agriculture.DryMatterIngestionIndex', NULL, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/agriculture/dry-matter-ingestion-index', 162),
(15, 'Obter o Ã­ndice de ingestÃ£o de eficiÃªncia alimentar dos animais de um\r\nexperimento.', 'br.ufjf.pgcc.eseco.services.agriculture.CARIndex', NULL, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/agriculture/carindex', 163);

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services_comments`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services_comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text,
  `date` datetime DEFAULT NULL,
  `commenter_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `workflowService_id` int(11) DEFAULT NULL,
  `rate_star_1` int(11) DEFAULT NULL,
  `rate_star_2` int(11) DEFAULT NULL,
  `rate_star_3` int(11) DEFAULT NULL,
  `rate_star_4` int(11) DEFAULT NULL,
  `rate_star_5` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK2sb2migp57btlnwt2ysc2atu` (`commenter_id`),
  KEY `FK7n39gqun30il865diafefctoi` (`parent_id`),
  KEY `FKaq7r193c0ly8s681avret2nrr` (`workflowService_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Extraindo dados da tabela `res_workflow_services_comments`
--

INSERT INTO `res_workflow_services_comments` (`id`, `content`, `date`, `commenter_id`, `parent_id`, `workflowService_id`, `rate_star_1`, `rate_star_2`, `rate_star_3`, `rate_star_4`, `rate_star_5`) VALUES
(1, 'This service returns a large string (from 600 to more than 1000 characters). Pay special attention to this while storing it. See the documentation for further information.', '2015-11-23 12:32:52', 3, NULL, 8, 0, 0, 4, 18, 3),
(2, 'Updated the service, now it returns more data, some other data has changed their names, see the full list of chances in the docs', '2016-11-05 13:01:45', 3, NULL, 9, 0, 0, 9, 4, 0),
(3, 'Updated the service, even more data are returned now. Older data didn''t changed.', '2017-08-22 13:02:28', 3, NULL, 9, 0, 0, 0, 16, 0),
(4, 'NÃ£o foi possÃ­vel identificar o que o serviÃ§o faz, por ausÃªncia da descriÃ§Ã£o. ', '2018-01-29 20:45:41', 25, NULL, 14, 0, 0, 0, 0, 0),
(6, 'A ausÃªncia de descriÃ§Ã£o dificultou a anÃ¡lise do serviÃ§o. O desenvolvedor poderia informar uma descriÃ§Ã£o sobre a utilizaÃ§Ã£o do serviÃ§o e, se possÃ­vel, apresentar um pequeno exemplo de utilizaÃ§Ã£o. Assim seria possÃ­vel identificar se o valor retornado estÃ¡ correto, de acordo com o valor de entrada informado.', '2018-01-29 21:16:57', 25, NULL, 14, 0, 0, 0, 0, 0),
(7, 'The service is working, but due to lack of description, it is difficult to evaluate if the operation is correct. For p=1, the getByExperimentId method returned the value "index": 101.25. If it is the expected value, then the service is correct. \r\n\r\nI am waiting for the developer to fill in the Description and Parameters fields to finalize the evaluation.', '2018-01-29 21:20:41', 26, NULL, 14, 0, 0, 0, 0, 0),
(15, 'Phillipe, atualizei o serviÃ§o para colocar a descriÃ§Ã£o e a documentaÃ§Ã£o com o exemplo de utilizaÃ§Ã£o.', '2018-01-30 16:24:42', 24, 6, 14, 0, 0, 0, 0, 1),
(16, 'According to the description and documentation presented and based on the tests performed, the service seems to work correctly. So I approve the service.', '2018-01-30 16:49:24', 26, NULL, 14, 0, 0, 0, 0, 0),
(17, 'Muito interessante! Funcionou perfeitamente', '2018-01-31 21:26:43', 25, NULL, 15, 0, 0, 0, 0, 1),
(18, 'Muito bom. Gostei das visualizaÃ§Ãµes que apoiam o entendimento das dependÃªncias do serviÃ§o. Funcionou corretamente.', '2018-01-31 21:41:24', 28, NULL, 15, 0, 0, 0, 0, 0),
(19, 'O serviÃ§o Ã© de grande utilidade para pesquisadores da Ã¡rea de agrotech. Obter o Ã­ndice CAR Ã© uma tarefa importante para a anÃ¡lise da eficiÃªncia alimentar dos bovinos. AlÃ©m disso, o serviÃ§o funcionou corretamente durante os testes executados, por isso avaliei positivamente. ', '2018-01-31 21:45:29', 26, NULL, 15, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `res_workflow_services_ratings`
--

CREATE TABLE IF NOT EXISTS `res_workflow_services_ratings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` bit(1) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `reproved_text` text,
  `value_disponibility` int(11) DEFAULT NULL,
  `value_documentation` int(11) DEFAULT NULL,
  `value_ease_of_use` int(11) DEFAULT NULL,
  `value_performance` int(11) DEFAULT NULL,
  `value_reliability` int(11) DEFAULT NULL,
  `rater_id` int(11) NOT NULL,
  `workflowService_id` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKp7jehvgu7w02hpgqleahm7qg1` (`rater_id`),
  KEY `FK1wsug3y880h83wxsqag980oil` (`workflowService_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;

--
-- Extraindo dados da tabela `res_workflow_services_ratings`
--

INSERT INTO `res_workflow_services_ratings` (`id`, `approved`, `date`, `reproved_text`, `value_disponibility`, `value_documentation`, `value_ease_of_use`, `value_performance`, `value_reliability`, `rater_id`, `workflowService_id`, `type`) VALUES
(1, b'1', '2012-07-23 00:00:00', NULL, 0, 0, 0, 0, 0, 10, 7, 2),
(2, b'1', '2012-07-23 00:00:00', NULL, 0, 0, 0, 0, 0, 11, 7, 2),
(3, b'1', '2012-07-23 00:00:00', NULL, 0, 0, 0, 0, 0, 12, 7, 2),
(4, b'1', '2012-07-24 00:00:00', NULL, 0, 0, 0, 0, 0, 13, 7, 2),
(5, b'1', '2012-07-24 00:00:00', NULL, 0, 0, 0, 0, 0, 14, 7, 2),
(6, b'1', '2012-07-24 00:00:00', NULL, 0, 0, 0, 0, 0, 15, 7, 2),
(7, b'1', '2012-07-26 00:00:00', NULL, 0, 0, 0, 0, 0, 16, 7, 2),
(8, b'1', '2012-07-28 00:00:00', NULL, 0, 0, 0, 0, 0, 17, 7, 2),
(9, b'1', '2016-08-21 00:00:00', NULL, 0, 0, 0, 0, 0, 11, 10, 2),
(10, b'1', '2016-08-22 00:00:00', NULL, 0, 0, 0, 0, 0, 14, 10, 2),
(11, b'1', '2016-09-11 00:00:00', NULL, 0, 0, 0, 0, 0, 18, 10, 2),
(12, b'1', '2016-09-27 00:00:00', NULL, 0, 0, 0, 0, 0, 19, 10, 2),
(13, b'1', '2015-08-27 00:00:00', NULL, 0, 0, 0, 0, 0, 11, 8, 2),
(14, b'1', '2015-08-27 00:00:00', NULL, 0, 0, 0, 0, 0, 19, 8, 2),
(15, b'1', '2015-09-02 00:00:00', NULL, 0, 0, 0, 0, 0, 13, 8, 2),
(16, b'1', '2015-09-05 00:00:00', NULL, 0, 0, 0, 0, 0, 14, 8, 2),
(17, b'1', '2015-09-05 00:00:00', NULL, 0, 0, 0, 0, 0, 15, 8, 2),
(18, b'1', '2017-10-18 00:00:00', NULL, 0, 0, 0, 0, 0, 16, 8, 2),
(19, b'1', '2017-10-18 00:00:00', NULL, 0, 0, 0, 0, 0, 17, 8, 2),
(20, b'1', '2017-10-19 00:00:00', NULL, 0, 0, 0, 0, 0, 18, 8, 2),
(21, b'1', '2017-11-02 00:00:00', NULL, 0, 0, 0, 0, 0, 20, 8, 2),
(22, b'1', '2015-08-20 00:00:00', NULL, 0, 0, 0, 0, 0, 10, 9, 2),
(23, b'1', '2015-08-21 00:00:00', NULL, 0, 0, 0, 0, 0, 11, 9, 2),
(24, b'1', '2015-08-21 00:00:00', NULL, 0, 0, 0, 0, 0, 12, 9, 2),
(25, b'1', '2015-08-23 00:00:00', NULL, 0, 0, 0, 0, 0, 13, 9, 2),
(26, b'1', '2015-08-23 00:00:00', NULL, 0, 0, 0, 0, 0, 14, 9, 2),
(27, b'1', '2015-08-28 00:00:00', NULL, 0, 0, 0, 0, 0, 15, 9, 2),
(28, b'1', '2015-08-28 00:00:00', NULL, 0, 0, 0, 0, 0, 16, 9, 2),
(29, b'1', '2015-09-02 00:00:00', NULL, 0, 0, 0, 0, 0, 17, 9, 2),
(30, b'1', '2015-09-03 00:00:00', NULL, 0, 0, 0, 0, 0, 18, 9, 2),
(31, b'1', '2015-09-07 00:00:00', NULL, 0, 0, 0, 0, 0, 19, 9, 2),
(32, b'1', '2015-09-10 00:00:00', 'I dont have a bar code', 0, 0, 0, 0, 0, 20, 9, 2),
(33, b'1', '2016-11-05 00:00:00', NULL, 0, 0, 0, 0, 0, 16, 9, 2),
(34, b'1', '2016-11-05 00:00:00', 'Was unable to use the returned data', 0, 0, 0, 0, 0, 17, 9, 2),
(35, b'1', '2016-11-08 00:00:00', NULL, 0, 0, 0, 0, 0, 18, 9, 2),
(36, b'1', '2016-11-10 00:00:00', NULL, 0, 0, 0, 0, 0, 12, 9, 2),
(37, b'1', '2016-11-10 00:00:00', NULL, 0, 0, 0, 0, 0, 13, 9, 2),
(38, b'1', '2017-08-22 00:00:00', NULL, 0, 0, 0, 0, 0, 14, 9, 2),
(39, b'1', '2017-08-23 00:00:00', NULL, 0, 0, 0, 0, 0, 15, 9, 2),
(40, b'1', '2017-08-23 00:00:00', NULL, 0, 0, 0, 0, 0, 19, 9, 2),
(41, b'1', '2017-09-03 00:00:00', NULL, 0, 0, 0, 0, 0, 20, 9, 2),
(42, b'1', '2017-09-05 00:00:00', NULL, 0, 0, 0, 0, 0, 18, 9, 2),
(43, b'1', '2016-06-24 13:08:10', NULL, 10, 9, 8, 9, 10, 2, 9, 1),
(44, b'1', '2017-10-12 13:08:54', NULL, 10, 10, 8, 8, 10, 3, 9, 1),
(45, b'1', '2018-01-29 16:28:42', NULL, 0, 0, 0, 0, 0, 1, 1, 2),
(46, b'1', '2018-01-30 16:41:39', NULL, 0, 0, 0, 0, 0, 26, 14, 2),
(47, b'1', '2018-01-30 16:44:05', NULL, 0, 0, 0, 0, 0, 25, 14, 2),
(48, b'1', '2018-01-31 21:27:48', NULL, 0, 0, 0, 0, 0, 25, 15, 2),
(49, b'1', '2018-01-31 21:28:52', NULL, 0, 0, 0, 0, 0, 28, 15, 2),
(50, b'1', '2018-01-31 21:40:09', NULL, 0, 0, 0, 0, 0, 26, 15, 2),
(51, b'0', '2018-03-01 11:20:39', NULL, 9, 1, 7, 7, 8, 2, 9, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `res_workflow_services_ratings_invitations`
--

INSERT INTO `res_workflow_services_ratings_invitations` (`id`, `completed`, `date_chat`, `date_completed`, `date_invited`, `participated_in_chat`, `asker_id`, `rater_id`, `workflowService_id`) VALUES
(1, b'1', NULL, '2018-01-29 16:28:42', '2018-01-29 16:28:20', b'1', 1, 1, 1),
(2, b'1', NULL, '2018-01-30 16:44:05', '2018-01-29 19:42:12', b'1', 4, 22, 14),
(3, b'1', NULL, '2018-01-30 16:41:39', '2018-01-29 19:42:12', b'1', 4, 23, 14),
(4, b'0', '2018-02-28 00:00:00', NULL, '2018-01-31 20:23:39', b'0', 5, 10, 15),
(5, b'1', '2018-02-28 00:00:00', '2018-01-31 21:40:09', '2018-01-31 20:23:40', b'0', 5, 23, 15),
(6, b'1', '2018-02-28 00:00:00', '2018-01-31 21:27:48', '2018-01-31 20:23:40', b'0', 5, 22, 15),
(7, b'1', '2018-02-28 00:00:00', '2018-01-31 21:28:52', '2018-01-31 20:23:40', b'0', 5, 24, 15),
(8, b'0', '2018-05-19 00:00:00', NULL, '2018-04-19 05:51:36', b'0', 1, 2, 15);

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_animals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `sm_agriculture_animals`
--

INSERT INTO `sm_agriculture_animals` (`id`, `name`) VALUES
(1, 'Bovine');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_experiments`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_experiments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `endDate` datetime DEFAULT NULL,
  `startDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=6 ;

--
-- Extraindo dados da tabela `sm_agriculture_experiments`
--

INSERT INTO `sm_agriculture_experiments` (`id`, `description`, `endDate`, `startDate`) VALUES
(1, 'Experiment 01', '2017-08-01 00:00:00', '2017-08-31 00:00:00'),
(2, 'Experiment 02', '2017-09-01 00:00:00', '2017-09-30 00:00:00'),
(3, 'Experiment 03', '2017-10-01 00:00:00', '2017-10-31 00:00:00'),
(4, 'Experiment 04', '2017-11-01 00:00:00', '2017-11-30 00:00:00'),
(5, 'Experiment 05', '2017-12-01 00:00:00', '2017-12-31 00:00:00');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_experiment_animals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_experiment_animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `animal_id` int(11) DEFAULT NULL,
  `experiment_id` int(11) DEFAULT NULL,
  `diaryWeightGain` double DEFAULT NULL,
  `meanMetabolicWeight` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKhf5f09cee0igvq5h7wi7mb50` (`animal_id`),
  KEY `FK4lrx4w8s2scm14x46x8btf072` (`experiment_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=43 ;

--
-- Extraindo dados da tabela `sm_agriculture_experiment_animals`
--

INSERT INTO `sm_agriculture_experiment_animals` (`id`, `animal_id`, `experiment_id`, `diaryWeightGain`, `meanMetabolicWeight`) VALUES
(1, 1, 1, 10, 5),
(2, 1, 1, 12, 7),
(3, 1, 1, 11, 6),
(4, 1, 1, 10, 7),
(5, 1, 1, 11, 12),
(6, 1, 1, 12, 6),
(7, 1, 1, 20, 8),
(8, 1, 1, 13, 7),
(9, 1, 2, 9, 4),
(10, 1, 2, 11, 5),
(11, 1, 2, 10, 8),
(12, 1, 2, 12, 5),
(13, 1, 2, 13, 6),
(14, 1, 2, 13, 3),
(15, 1, 2, 12, 5),
(16, 1, 2, 11, 7),
(17, 1, 2, 12, 2),
(18, 1, 3, 10, 5),
(19, 1, 3, 13, 7),
(20, 1, 3, 14, 8),
(21, 1, 3, 8, 5),
(22, 1, 3, 9, 7),
(23, 1, 3, 11, 9),
(24, 1, 3, 12, 5),
(25, 1, 3, 11, 7),
(26, 1, 3, 22, 5),
(27, 1, 4, 13, 6),
(28, 1, 4, 14, 7),
(29, 1, 4, 16, 8),
(30, 1, 4, 13, 8),
(31, 1, 4, 14, 9),
(32, 1, 4, 15, 4),
(33, 1, 4, 16, 5),
(34, 1, 4, 23, 3),
(35, 1, 5, 11, 4),
(36, 1, 5, 12, 6),
(37, 1, 5, 12, 8),
(38, 1, 5, 12, 4),
(39, 1, 5, 11, 7),
(40, 1, 5, 12, 8),
(41, 1, 5, 10, 8),
(42, 1, 5, 11, 6);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=37 ;

--
-- Extraindo dados da tabela `sm_agriculture_experiment_animals_meals`
--

INSERT INTO `sm_agriculture_experiment_animals_meals` (`id`, `quantity`, `experimentAnimal_id`, `meal_id`) VALUES
(1, 9.8, 1, 1),
(2, 10.2, 1, 2),
(3, 5.8, 1, 3),
(4, 10, 2, 1),
(5, 9.7, 2, 2),
(6, 5.9, 2, 3),
(7, 9.8, 3, 1),
(8, 9.7, 3, 2),
(9, 10, 4, 1),
(10, 10.1, 4, 2),
(11, 10.3, 5, 1),
(12, 9.9, 5, 2),
(13, 10, 6, 2),
(14, 10, 6, 3),
(15, 9.6, 7, 2),
(16, 9.8, 7, 3),
(17, 9.8, 8, 2),
(18, 9.7, 8, 3),
(19, 9.8, 9, 2),
(20, 10.2, 9, 3),
(21, 10, 10, 2),
(22, 9.7, 10, 3),
(23, 9.8, 11, 2),
(24, 9.7, 11, 3),
(25, 10, 12, 2),
(26, 9.7, 12, 3),
(27, 9.8, 13, 2),
(28, 9.7, 13, 3),
(29, 10.2, 14, 2),
(30, 9.7, 14, 3),
(31, 9.7, 15, 2),
(32, 9.9, 15, 3),
(33, 10.3, 16, 2),
(34, 9.7, 16, 3),
(35, 9.8, 17, 2),
(36, 9.9, 17, 3);

-- --------------------------------------------------------

--
-- Estrutura da tabela `sm_agriculture_meals`
--

CREATE TABLE IF NOT EXISTS `sm_agriculture_meals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Extraindo dados da tabela `sm_agriculture_meals`
--

INSERT INTO `sm_agriculture_meals` (`id`, `name`) VALUES
(1, 'Corn'),
(2, 'Soy'),
(3, 'Silage');

-- --------------------------------------------------------

--
-- Estrutura da tabela `uac_roles`
--

CREATE TABLE IF NOT EXISTS `uac_roles` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=35 ;

--
-- Extraindo dados da tabela `uac_users`
--

INSERT INTO `uac_users` (`id`, `activation_code`, `activation_expire_date`, `active`, `email`, `login`, `password`, `redefinition_code`, `redefinition_expire_date`, `register_date`) VALUES
(1, NULL, NULL, b'1', 'leoaguiarpereira@gmail.com', 'leoaguiarpereira@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-12-06 04:42:35'),
(2, NULL, NULL, b'1', 'developer01@mail.com', 'developer01@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(3, NULL, NULL, b'1', 'developer02@mail.com', 'developer02@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(4, NULL, NULL, b'1', 'researcher01@mail.com', 'researcher01@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(5, NULL, NULL, b'1', 'researcher02@mail.com', 'researcher02@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(6, NULL, NULL, b'1', 'researcher03@mail.com', 'researcher03@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(7, NULL, NULL, b'1', 'researcher04@mail.com', 'researcher04@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(8, NULL, NULL, b'1', 'researcher05@mail.com', 'researcher05@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(9, NULL, NULL, b'1', 'researcher06@mail.com', 'researcher06@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(10, NULL, NULL, b'1', 'researcher07@mail.com', 'researcher07@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(11, NULL, NULL, b'1', 'researcher08@mail.com', 'researcher08@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(12, NULL, NULL, b'1', 'researcher09@mail.com', 'researcher09@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(13, NULL, NULL, b'1', 'researcher10@mail.com', 'researcher10@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(14, NULL, NULL, b'1', 'researcher11@mail.com', 'researcher11@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(15, NULL, NULL, b'1', 'researcher12@mail.com', 'researcher12@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(16, NULL, NULL, b'1', 'researcher13@mail.com', 'researcher13@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(17, NULL, NULL, b'1', 'researcher14@mail.com', 'researcher14@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(18, NULL, NULL, b'1', 'researcher15@mail.com', 'researcher15@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(19, NULL, NULL, b'1', 'researcher16@mail.com', 'researcher16@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(20, NULL, NULL, b'1', 'researcher17@mail.com', 'researcher17@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(21, NULL, NULL, b'1', 'researcher18@mail.com', 'researcher18@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(22, NULL, NULL, b'1', 'researcher19@mail.com', 'researcher19@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(23, NULL, NULL, b'1', 'researcher20@mail.com', 'researcher20@mail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-13 09:55:58'),
(24, NULL, NULL, b'1', 'dionisio.louro@gmail.com', 'dionisio.louro@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-01-29 17:35:58'),
(25, NULL, NULL, b'1', 'phillipe.marques@gmail.com', 'phillipe.marques@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-11-19 09:55:58'),
(26, NULL, NULL, b'1', 'lenita.ambrosio@gmail.com', 'lenita.ambrosio@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2017-12-08 09:55:58'),
(27, NULL, NULL, b'1', 'heitormagaldi@yahoo.com.br', 'heitormagaldi@yahoo.com.br', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-01-31 19:05:12'),
(28, NULL, NULL, b'1', 'pedrooska@gmail.com', 'pedrooska@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', NULL, NULL, '2018-01-31 15:26:54'),
(29, 'b7e89db1ad247e84c9e49aadbe7840142e09d573', '2018-02-22 16:48:38', b'0', 'luizmmat@gmail.com', 'luizmmat@gmail.com', NULL, NULL, NULL, '2018-02-21 16:48:38'),
(30, '1fd0a9dd881fddca28ee8db07c0162de4d0ff719', '2018-06-15 15:40:13', b'0', 'jade@ice.ufjf.br', 'jade@ice.ufjf.br', NULL, NULL, NULL, '2018-06-14 15:40:13'),
(31, 'b5962d173dc5b39ac17a709e43a34cf069333b1d', '2018-06-15 18:45:09', b'0', 'jose.david@ufjf.edu.br', 'jose.david@ufjf.edu.br', NULL, NULL, NULL, '2018-06-14 18:45:09'),
(32, '310f84b8b4df29af0d38eaeedd5e0d30ef3b6662', '2018-06-15 18:45:36', b'0', 'jmndavid@gmail.com', 'jmndavid@gmail.com', NULL, NULL, NULL, '2018-06-14 18:45:36'),
(34, NULL, NULL, b'1', 'nenc.eseco@gmail.com', 'nenc.eseco@gmail.com', '520e1d74fefcb014e4b3f7b49859ae98a340a0b8', NULL, NULL, '2018-06-15 00:00:10');

-- --------------------------------------------------------

--
-- Estrutura da tabela `uac_users_roles`
--

CREATE TABLE IF NOT EXISTS `uac_users_roles` (
  `id_user` int(11) NOT NULL,
  `id_role` int(11) NOT NULL,
  KEY `FKmjqpx78dy0ermw3hvguqs8020` (`id_role`),
  KEY `FK7808thnb4yhr5rw92ikg2h59j` (`id_user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `uac_users_roles`
--

INSERT INTO `uac_users_roles` (`id_user`, `id_role`) VALUES
(1, 2),
(1, 3),
(2, 3),
(3, 3),
(4, 2),
(5, 2),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(11, 2),
(12, 2),
(13, 2),
(14, 2),
(15, 2),
(16, 2),
(17, 2),
(18, 2),
(19, 2),
(20, 2),
(21, 2),
(22, 2),
(23, 2),
(24, 3),
(25, 2),
(26, 2),
(27, 3),
(28, 2),
(29, 2),
(30, 2),
(31, 2),
(32, 2),
(34, 2),
(34, 3);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
