create table core_agents
(
  id       int auto_increment
    primary key,
  birthday datetime     null,
  gender   varchar(1)   null,
  name     varchar(255) not null,
  user_id  int          not null
)
  engine = InnoDB
  charset = latin1;

create index FKktjutrgawejpe3sx56qomtw9d
  on core_agents (user_id);

INSERT INTO eseco.core_agents (id, birthday, gender, name, user_id) VALUES (1, '1986-12-01 00:00:00', 'M', 'Leonardo de Aguiar', 1);
create table core_agents_developers
(
  id       int auto_increment
    primary key,
  photo    varchar(255) null,
  agent_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FKt3u84t7tbhdlqr96gfjv8hsfk
  on core_agents_developers (agent_id);

INSERT INTO eseco.core_agents_developers (id, photo, agent_id) VALUES (1, null, 1);
create table core_agents_developers_institutions
(
  developer_id   int not null,
  institution_id int not null,
  constraint UK_i6dwtf4lnaf4oj9kl8e3fi738
    unique (institution_id)
)
  engine = InnoDB
  charset = latin1;

create index FKhmayxudv5ag8pqn3028tscg1s
  on core_agents_developers_institutions (developer_id);


create table core_agents_researchers
(
  id              int auto_increment
    primary key,
  academic_status varchar(255) null,
  display_name    varchar(255) null,
  kepler_id       varchar(255) null,
  mendeley_id     varchar(255) null,
  photo           varchar(255) null,
  title           varchar(255) null,
  agent_id        int          null,
  lattes_id       varchar(255) null,
  researchgate_id varchar(255) null
)
  engine = InnoDB
  charset = latin1;

create index FK71mh4922a0q3t7ebjdmviloap
  on core_agents_researchers (agent_id);


create table core_agents_researchers_disciplines
(
  researcher_id int not null,
  discipline_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK3cljndx53oh3fhog3r3pcqlae
  on core_agents_researchers_disciplines (researcher_id);

create index FKaop4mqc7p60pj7ojdctcod69m
  on core_agents_researchers_disciplines (discipline_id);


create table core_agents_researchers_institutions
(
  researcher_id  int not null,
  institution_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK4wlj79hpje54w1yhctjronm5t
  on core_agents_researchers_institutions (institution_id);

create index FKnjibjwyfx0du85ecdpc8fbyql
  on core_agents_researchers_institutions (researcher_id);


create table core_agents_researchers_interests
(
  researcher_id int not null,
  interest_id   int not null
)
  engine = InnoDB
  charset = latin1;

create index FKnh6mjtvpkjbia7pheato1wreb
  on core_agents_researchers_interests (researcher_id);

create index FKr2qbtbwm9j8ovy2ssgulkv1e2
  on core_agents_researchers_interests (interest_id);


create table core_agents_researchers_keywords
(
  id            int auto_increment
    primary key,
  name          varchar(255) null,
  year          varchar(255) null,
  researcher_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FKbysyrmdwrxoud8bteeejyfyyp
  on core_agents_researchers_keywords (researcher_id);


create table core_cities
(
  id       int auto_increment
    primary key,
  name     varchar(255) null,
  state_id int          not null,
  constraint UK_6ivyhwdpu1fxm1m97g2qawr8o
    unique (name)
)
  engine = InnoDB
  charset = latin1;

create index FKr4n74h5yvj373tnllfn8y777x
  on core_cities (state_id);

INSERT INTO eseco.core_cities (id, name, state_id) VALUES (1, 'Rio Branco', 1);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (2, 'Maceió', 2);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (3, 'Macapá', 3);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (4, 'Manaus', 4);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (5, 'Salvador', 5);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (6, 'Fortaleza', 6);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (7, 'Brasília', 7);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (8, 'Vitória', 8);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (9, 'Goiânia', 9);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (10, 'São Luís', 10);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (11, 'Cuiabá', 11);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (12, 'Campo Grande', 12);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (13, 'Belo Horizonte', 13);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (14, 'Belém', 14);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (15, 'João Pessoa', 15);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (16, 'Curitiba', 16);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (17, 'Recife', 17);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (18, 'Teresina', 18);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (19, 'Rio de Janeiro', 19);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (20, 'Natal', 20);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (21, 'Porto Alegre', 21);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (22, 'Porto Velho', 22);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (23, 'Boa Vista', 23);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (24, 'Florianópolis', 24);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (25, 'São Paulo', 25);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (26, 'Aracaju', 26);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (27, 'Palmas', 27);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (28, 'Juiz de Fora', 13);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (29, 'Itapetinga', 5);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (30, 'Montes Claros', 13);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (31, 'Viçosa', 13);
INSERT INTO eseco.core_cities (id, name, state_id) VALUES (32, 'Ilhéus', 5);
create table core_countries
(
  id   int auto_increment
    primary key,
  code varchar(255) not null,
  name varchar(255) null,
  constraint UK_c6cc4ik7w6okhs21nt6f44650
    unique (code),
  constraint UK_pp4fmuelxg7uksfdfnkoofkog
    unique (name)
)
  engine = InnoDB
  charset = latin1;

INSERT INTO eseco.core_countries (id, code, name) VALUES (1, 'AF', 'Afghanistan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (2, 'AX', 'AlandIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (3, 'AL', 'Albania');
INSERT INTO eseco.core_countries (id, code, name) VALUES (4, 'DZ', 'Algeria');
INSERT INTO eseco.core_countries (id, code, name) VALUES (5, 'AS', 'AmericanSamoa');
INSERT INTO eseco.core_countries (id, code, name) VALUES (6, 'AD', 'Andorra');
INSERT INTO eseco.core_countries (id, code, name) VALUES (7, 'AO', 'Angola');
INSERT INTO eseco.core_countries (id, code, name) VALUES (8, 'AI', 'Anguilla');
INSERT INTO eseco.core_countries (id, code, name) VALUES (9, 'AQ', 'Antarctica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (10, 'AG', 'AntiguaandBarbuda');
INSERT INTO eseco.core_countries (id, code, name) VALUES (11, 'AR', 'Argentina');
INSERT INTO eseco.core_countries (id, code, name) VALUES (12, 'AM', 'Armenia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (13, 'AW', 'Aruba');
INSERT INTO eseco.core_countries (id, code, name) VALUES (14, 'AU', 'Australia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (15, 'AT', 'Austria');
INSERT INTO eseco.core_countries (id, code, name) VALUES (16, 'AZ', 'Azerbaijan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (17, 'BS', 'Bahamas');
INSERT INTO eseco.core_countries (id, code, name) VALUES (18, 'BH', 'Bahrain');
INSERT INTO eseco.core_countries (id, code, name) VALUES (19, 'BD', 'Bangladesh');
INSERT INTO eseco.core_countries (id, code, name) VALUES (20, 'BB', 'Barbados');
INSERT INTO eseco.core_countries (id, code, name) VALUES (21, 'BY', 'Belarus');
INSERT INTO eseco.core_countries (id, code, name) VALUES (22, 'BE', 'Belgium');
INSERT INTO eseco.core_countries (id, code, name) VALUES (23, 'BZ', 'Belize');
INSERT INTO eseco.core_countries (id, code, name) VALUES (24, 'BJ', 'Benin');
INSERT INTO eseco.core_countries (id, code, name) VALUES (25, 'BM', 'Bermuda');
INSERT INTO eseco.core_countries (id, code, name) VALUES (26, 'BT', 'Bhutan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (27, 'BO', 'Bolivia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (28, 'BA', 'BosniaandHerzegovina');
INSERT INTO eseco.core_countries (id, code, name) VALUES (29, 'BW', 'Botswana');
INSERT INTO eseco.core_countries (id, code, name) VALUES (30, 'BV', 'BouvetIsland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (31, 'BR', 'Brazil');
INSERT INTO eseco.core_countries (id, code, name) VALUES (32, 'VG', 'BritishVirginIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (33, 'IO', 'BritishIndianOceanTerritory');
INSERT INTO eseco.core_countries (id, code, name) VALUES (34, 'BN', 'BruneiDarussalam');
INSERT INTO eseco.core_countries (id, code, name) VALUES (35, 'BG', 'Bulgaria');
INSERT INTO eseco.core_countries (id, code, name) VALUES (36, 'BF', 'BurkinaFaso');
INSERT INTO eseco.core_countries (id, code, name) VALUES (37, 'BI', 'Burundi');
INSERT INTO eseco.core_countries (id, code, name) VALUES (38, 'KH', 'Cambodia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (39, 'CM', 'Cameroon');
INSERT INTO eseco.core_countries (id, code, name) VALUES (40, 'CA', 'Canada');
INSERT INTO eseco.core_countries (id, code, name) VALUES (41, 'CV', 'CapeVerde');
INSERT INTO eseco.core_countries (id, code, name) VALUES (42, 'KY', 'CaymanIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (43, 'CF', 'CentralAfricanRepublic');
INSERT INTO eseco.core_countries (id, code, name) VALUES (44, 'TD', 'Chad');
INSERT INTO eseco.core_countries (id, code, name) VALUES (45, 'CL', 'Chile');
INSERT INTO eseco.core_countries (id, code, name) VALUES (46, 'CN', 'China');
INSERT INTO eseco.core_countries (id, code, name) VALUES (47, 'HK', 'HongKong,SARChina');
INSERT INTO eseco.core_countries (id, code, name) VALUES (48, 'MO', 'Macao,SARChina');
INSERT INTO eseco.core_countries (id, code, name) VALUES (49, 'CX', 'ChristmasIsland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (50, 'CC', 'Cocos(Keeling)Islands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (51, 'CO', 'Colombia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (52, 'KM', 'Comoros');
INSERT INTO eseco.core_countries (id, code, name) VALUES (53, 'CG', 'Congo (Brazzaville)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (54, 'CD', 'Congo,(Kinshasa)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (55, 'CK', 'CookIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (56, 'CR', 'CostaRica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (57, 'CI', 'Côted''Ivoire');
INSERT INTO eseco.core_countries (id, code, name) VALUES (58, 'HR', 'Croatia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (59, 'CU', 'Cuba');
INSERT INTO eseco.core_countries (id, code, name) VALUES (60, 'CY', 'Cyprus');
INSERT INTO eseco.core_countries (id, code, name) VALUES (61, 'CZ', 'CzechRepublic');
INSERT INTO eseco.core_countries (id, code, name) VALUES (62, 'DK', 'Denmark');
INSERT INTO eseco.core_countries (id, code, name) VALUES (63, 'DJ', 'Djibouti');
INSERT INTO eseco.core_countries (id, code, name) VALUES (64, 'DM', 'Dominica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (65, 'DO', 'DominicanRepublic');
INSERT INTO eseco.core_countries (id, code, name) VALUES (66, 'EC', 'Ecuador');
INSERT INTO eseco.core_countries (id, code, name) VALUES (67, 'EG', 'Egypt');
INSERT INTO eseco.core_countries (id, code, name) VALUES (68, 'SV', 'ElSalvador');
INSERT INTO eseco.core_countries (id, code, name) VALUES (69, 'GQ', 'EquatorialGuinea');
INSERT INTO eseco.core_countries (id, code, name) VALUES (70, 'ER', 'Eritrea');
INSERT INTO eseco.core_countries (id, code, name) VALUES (71, 'EE', 'Estonia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (72, 'ET', 'Ethiopia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (73, 'FK', 'FalklandIslands(Malvinas)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (74, 'FO', 'FaroeIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (75, 'FJ', 'Fiji');
INSERT INTO eseco.core_countries (id, code, name) VALUES (76, 'FI', 'Finland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (77, 'FR', 'France');
INSERT INTO eseco.core_countries (id, code, name) VALUES (78, 'GF', 'FrenchGuiana');
INSERT INTO eseco.core_countries (id, code, name) VALUES (79, 'PF', 'FrenchPolynesia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (80, 'TF', 'FrenchSouthernTerritories');
INSERT INTO eseco.core_countries (id, code, name) VALUES (81, 'GA', 'Gabon');
INSERT INTO eseco.core_countries (id, code, name) VALUES (82, 'GM', 'Gambia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (83, 'GE', 'Georgia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (84, 'DE', 'Germany');
INSERT INTO eseco.core_countries (id, code, name) VALUES (85, 'GH', 'Ghana');
INSERT INTO eseco.core_countries (id, code, name) VALUES (86, 'GI', 'Gibraltar');
INSERT INTO eseco.core_countries (id, code, name) VALUES (87, 'GR', 'Greece');
INSERT INTO eseco.core_countries (id, code, name) VALUES (88, 'GL', 'Greenland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (89, 'GD', 'Grenada');
INSERT INTO eseco.core_countries (id, code, name) VALUES (90, 'GP', 'Guadeloupe');
INSERT INTO eseco.core_countries (id, code, name) VALUES (91, 'GU', 'Guam');
INSERT INTO eseco.core_countries (id, code, name) VALUES (92, 'GT', 'Guatemala');
INSERT INTO eseco.core_countries (id, code, name) VALUES (93, 'GG', 'Guernsey');
INSERT INTO eseco.core_countries (id, code, name) VALUES (94, 'GN', 'Guinea');
INSERT INTO eseco.core_countries (id, code, name) VALUES (95, 'GW', 'Guinea-Bissau');
INSERT INTO eseco.core_countries (id, code, name) VALUES (96, 'GY', 'Guyana');
INSERT INTO eseco.core_countries (id, code, name) VALUES (97, 'HT', 'Haiti');
INSERT INTO eseco.core_countries (id, code, name) VALUES (98, 'HM', 'HeardandMcdonaldIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (99, 'VA', 'HolySee (VaticanCityState)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (100, 'HN', 'Honduras');
INSERT INTO eseco.core_countries (id, code, name) VALUES (101, 'HU', 'Hungary');
INSERT INTO eseco.core_countries (id, code, name) VALUES (102, 'IS', 'Iceland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (103, 'IN', 'India');
INSERT INTO eseco.core_countries (id, code, name) VALUES (104, 'ID', 'Indonesia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (105, 'IR', 'Iran,IslamicRepublicof');
INSERT INTO eseco.core_countries (id, code, name) VALUES (106, 'IQ', 'Iraq');
INSERT INTO eseco.core_countries (id, code, name) VALUES (107, 'IE', 'Ireland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (108, 'IM', 'IsleofMan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (109, 'IL', 'Israel');
INSERT INTO eseco.core_countries (id, code, name) VALUES (110, 'IT', 'Italy');
INSERT INTO eseco.core_countries (id, code, name) VALUES (111, 'JM', 'Jamaica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (112, 'JP', 'Japan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (113, 'JE', 'Jersey');
INSERT INTO eseco.core_countries (id, code, name) VALUES (114, 'JO', 'Jordan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (115, 'KZ', 'Kazakhstan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (116, 'KE', 'Kenya');
INSERT INTO eseco.core_countries (id, code, name) VALUES (117, 'KI', 'Kiribati');
INSERT INTO eseco.core_countries (id, code, name) VALUES (118, 'KP', 'Korea (North)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (119, 'KR', 'Korea (South)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (120, 'KW', 'Kuwait');
INSERT INTO eseco.core_countries (id, code, name) VALUES (121, 'KG', 'Kyrgyzstan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (122, 'LA', 'LaoPDR');
INSERT INTO eseco.core_countries (id, code, name) VALUES (123, 'LV', 'Latvia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (124, 'LB', 'Lebanon');
INSERT INTO eseco.core_countries (id, code, name) VALUES (125, 'LS', 'Lesotho');
INSERT INTO eseco.core_countries (id, code, name) VALUES (126, 'LR', 'Liberia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (127, 'LY', 'Libya');
INSERT INTO eseco.core_countries (id, code, name) VALUES (128, 'LI', 'Liechtenstein');
INSERT INTO eseco.core_countries (id, code, name) VALUES (129, 'LT', 'Lithuania');
INSERT INTO eseco.core_countries (id, code, name) VALUES (130, 'LU', 'Luxembourg');
INSERT INTO eseco.core_countries (id, code, name) VALUES (131, 'MK', 'Macedonia,Republicof');
INSERT INTO eseco.core_countries (id, code, name) VALUES (132, 'MG', 'Madagascar');
INSERT INTO eseco.core_countries (id, code, name) VALUES (133, 'MW', 'Malawi');
INSERT INTO eseco.core_countries (id, code, name) VALUES (134, 'MY', 'Malaysia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (135, 'MV', 'Maldives');
INSERT INTO eseco.core_countries (id, code, name) VALUES (136, 'ML', 'Mali');
INSERT INTO eseco.core_countries (id, code, name) VALUES (137, 'MT', 'Malta');
INSERT INTO eseco.core_countries (id, code, name) VALUES (138, 'MH', 'MarshallIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (139, 'MQ', 'Martinique');
INSERT INTO eseco.core_countries (id, code, name) VALUES (140, 'MR', 'Mauritania');
INSERT INTO eseco.core_countries (id, code, name) VALUES (141, 'MU', 'Mauritius');
INSERT INTO eseco.core_countries (id, code, name) VALUES (142, 'YT', 'Mayotte');
INSERT INTO eseco.core_countries (id, code, name) VALUES (143, 'MX', 'Mexico');
INSERT INTO eseco.core_countries (id, code, name) VALUES (144, 'FM', 'Micronesia,FederatedStatesof');
INSERT INTO eseco.core_countries (id, code, name) VALUES (145, 'MD', 'Moldova');
INSERT INTO eseco.core_countries (id, code, name) VALUES (146, 'MC', 'Monaco');
INSERT INTO eseco.core_countries (id, code, name) VALUES (147, 'MN', 'Mongolia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (148, 'ME', 'Montenegro');
INSERT INTO eseco.core_countries (id, code, name) VALUES (149, 'MS', 'Montserrat');
INSERT INTO eseco.core_countries (id, code, name) VALUES (150, 'MA', 'Morocco');
INSERT INTO eseco.core_countries (id, code, name) VALUES (151, 'MZ', 'Mozambique');
INSERT INTO eseco.core_countries (id, code, name) VALUES (152, 'MM', 'Myanmar');
INSERT INTO eseco.core_countries (id, code, name) VALUES (153, 'NA', 'Namibia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (154, 'NR', 'Nauru');
INSERT INTO eseco.core_countries (id, code, name) VALUES (155, 'NP', 'Nepal');
INSERT INTO eseco.core_countries (id, code, name) VALUES (156, 'NL', 'Netherlands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (157, 'AN', 'NetherlandsAntilles');
INSERT INTO eseco.core_countries (id, code, name) VALUES (158, 'NC', 'NewCaledonia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (159, 'NZ', 'NewZealand');
INSERT INTO eseco.core_countries (id, code, name) VALUES (160, 'NI', 'Nicaragua');
INSERT INTO eseco.core_countries (id, code, name) VALUES (161, 'NE', 'Niger');
INSERT INTO eseco.core_countries (id, code, name) VALUES (162, 'NG', 'Nigeria');
INSERT INTO eseco.core_countries (id, code, name) VALUES (163, 'NU', 'Niue');
INSERT INTO eseco.core_countries (id, code, name) VALUES (164, 'NF', 'NorfolkIsland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (165, 'MP', 'NorthernMarianaIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (166, 'NO', 'Norway');
INSERT INTO eseco.core_countries (id, code, name) VALUES (167, 'OM', 'Oman');
INSERT INTO eseco.core_countries (id, code, name) VALUES (168, 'PK', 'Pakistan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (169, 'PW', 'Palau');
INSERT INTO eseco.core_countries (id, code, name) VALUES (170, 'PS', 'PalestinianTerritory');
INSERT INTO eseco.core_countries (id, code, name) VALUES (171, 'PA', 'Panama');
INSERT INTO eseco.core_countries (id, code, name) VALUES (172, 'PG', 'PapuaNewGuinea');
INSERT INTO eseco.core_countries (id, code, name) VALUES (173, 'PY', 'Paraguay');
INSERT INTO eseco.core_countries (id, code, name) VALUES (174, 'PE', 'Peru');
INSERT INTO eseco.core_countries (id, code, name) VALUES (175, 'PH', 'Philippines');
INSERT INTO eseco.core_countries (id, code, name) VALUES (176, 'PN', 'Pitcairn');
INSERT INTO eseco.core_countries (id, code, name) VALUES (177, 'PL', 'Poland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (178, 'PT', 'Portugal');
INSERT INTO eseco.core_countries (id, code, name) VALUES (179, 'PR', 'PuertoRico');
INSERT INTO eseco.core_countries (id, code, name) VALUES (180, 'QA', 'Qatar');
INSERT INTO eseco.core_countries (id, code, name) VALUES (181, 'RE', 'Réunion');
INSERT INTO eseco.core_countries (id, code, name) VALUES (182, 'RO', 'Romania');
INSERT INTO eseco.core_countries (id, code, name) VALUES (183, 'RU', 'RussianFederation');
INSERT INTO eseco.core_countries (id, code, name) VALUES (184, 'RW', 'Rwanda');
INSERT INTO eseco.core_countries (id, code, name) VALUES (185, 'BL', 'Saint-Barthélemy');
INSERT INTO eseco.core_countries (id, code, name) VALUES (186, 'SH', 'SaintHelena');
INSERT INTO eseco.core_countries (id, code, name) VALUES (187, 'KN', 'SaintKittsandNevis');
INSERT INTO eseco.core_countries (id, code, name) VALUES (188, 'LC', 'SaintLucia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (189, 'MF', 'Saint-Martin(Frenchpart)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (190, 'PM', 'SaintPierreandMiquelon');
INSERT INTO eseco.core_countries (id, code, name) VALUES (191, 'VC', 'SaintVincentandGrenadines');
INSERT INTO eseco.core_countries (id, code, name) VALUES (192, 'WS', 'Samoa');
INSERT INTO eseco.core_countries (id, code, name) VALUES (193, 'SM', 'SanMarino');
INSERT INTO eseco.core_countries (id, code, name) VALUES (194, 'ST', 'SaoTomeandPrincipe');
INSERT INTO eseco.core_countries (id, code, name) VALUES (195, 'SA', 'SaudiArabia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (196, 'SN', 'Senegal');
INSERT INTO eseco.core_countries (id, code, name) VALUES (197, 'RS', 'Serbia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (198, 'SC', 'Seychelles');
INSERT INTO eseco.core_countries (id, code, name) VALUES (199, 'SL', 'SierraLeone');
INSERT INTO eseco.core_countries (id, code, name) VALUES (200, 'SG', 'Singapore');
INSERT INTO eseco.core_countries (id, code, name) VALUES (201, 'SK', 'Slovakia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (202, 'SI', 'Slovenia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (203, 'SB', 'SolomonIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (204, 'SO', 'Somalia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (205, 'ZA', 'SouthAfrica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (206, 'GS', 'SouthGeorgiaandtheSouthSandwichIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (207, 'SS', 'SouthSudan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (208, 'ES', 'Spain');
INSERT INTO eseco.core_countries (id, code, name) VALUES (209, 'LK', 'SriLanka');
INSERT INTO eseco.core_countries (id, code, name) VALUES (210, 'SD', 'Sudan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (211, 'SR', 'Suriname');
INSERT INTO eseco.core_countries (id, code, name) VALUES (212, 'SJ', 'SvalbardandJanMayenIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (213, 'SZ', 'Swaziland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (214, 'SE', 'Sweden');
INSERT INTO eseco.core_countries (id, code, name) VALUES (215, 'CH', 'Switzerland');
INSERT INTO eseco.core_countries (id, code, name) VALUES (216, 'SY', 'SyrianArabRepublic (Syria)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (217, 'TW', 'Taiwan,RepublicofChina');
INSERT INTO eseco.core_countries (id, code, name) VALUES (218, 'TJ', 'Tajikistan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (219, 'TZ', 'Tanzania,UnitedRepublicof');
INSERT INTO eseco.core_countries (id, code, name) VALUES (220, 'TH', 'Thailand');
INSERT INTO eseco.core_countries (id, code, name) VALUES (221, 'TL', 'Timor-Leste');
INSERT INTO eseco.core_countries (id, code, name) VALUES (222, 'TG', 'Togo');
INSERT INTO eseco.core_countries (id, code, name) VALUES (223, 'TK', 'Tokelau');
INSERT INTO eseco.core_countries (id, code, name) VALUES (224, 'TO', 'Tonga');
INSERT INTO eseco.core_countries (id, code, name) VALUES (225, 'TT', 'TrinidadandTobago');
INSERT INTO eseco.core_countries (id, code, name) VALUES (226, 'TN', 'Tunisia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (227, 'TR', 'Turkey');
INSERT INTO eseco.core_countries (id, code, name) VALUES (228, 'TM', 'Turkmenistan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (229, 'TC', 'TurksandCaicosIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (230, 'TV', 'Tuvalu');
INSERT INTO eseco.core_countries (id, code, name) VALUES (231, 'UG', 'Uganda');
INSERT INTO eseco.core_countries (id, code, name) VALUES (232, 'UA', 'Ukraine');
INSERT INTO eseco.core_countries (id, code, name) VALUES (233, 'AE', 'UnitedArabEmirates');
INSERT INTO eseco.core_countries (id, code, name) VALUES (234, 'GB', 'UnitedKingdom');
INSERT INTO eseco.core_countries (id, code, name) VALUES (235, 'US', 'UnitedStatesofAmerica');
INSERT INTO eseco.core_countries (id, code, name) VALUES (236, 'UM', 'USMinorOutlyingIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (237, 'UY', 'Uruguay');
INSERT INTO eseco.core_countries (id, code, name) VALUES (238, 'UZ', 'Uzbekistan');
INSERT INTO eseco.core_countries (id, code, name) VALUES (239, 'VU', 'Vanuatu');
INSERT INTO eseco.core_countries (id, code, name) VALUES (240, 'VE', 'Venezuela (BolivarianRepublic)');
INSERT INTO eseco.core_countries (id, code, name) VALUES (241, 'VN', 'VietNam');
INSERT INTO eseco.core_countries (id, code, name) VALUES (242, 'VI', 'VirginIslands,US');
INSERT INTO eseco.core_countries (id, code, name) VALUES (243, 'WF', 'WallisandFutunaIslands');
INSERT INTO eseco.core_countries (id, code, name) VALUES (244, 'EH', 'WesternSahara');
INSERT INTO eseco.core_countries (id, code, name) VALUES (245, 'YE', 'Yemen');
INSERT INTO eseco.core_countries (id, code, name) VALUES (246, 'ZM', 'Zambia');
INSERT INTO eseco.core_countries (id, code, name) VALUES (247, 'ZW', 'Zimbabwe');
create table core_disciplines
(
  id     int auto_increment
    primary key,
  name   varchar(255) null,
  parent int          null
)
  engine = InnoDB
  charset = latin1;

create index FKci04mmvbc7f2kf2rjr38xtodp
  on core_disciplines (parent);

INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (1, 'Agricultural and Biological Sciences', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (2, 'Arts and Humanities', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (3, 'Biochemistry, Genetics and Molecular Biology', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (4, 'Business, Management and Accounting', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (5, 'Chemical Engineering', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (6, 'Chemistry', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (7, 'Computer Science', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (8, 'Decision Sciences', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (9, 'Design', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (10, 'Earth and Planetary Sciences', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (11, 'Economics, Econometrics and Finance', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (12, 'Energy', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (13, 'Engineering', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (14, 'Environmental Science', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (15, 'Immunology and Microbiology', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (16, 'Linguistics', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (17, 'Materials Science', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (18, 'Mathematics', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (19, 'Medicine and Dentistry', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (20, 'Neuroscience', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (21, 'Nursing and Health Professions', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (22, 'Pharmacology, Toxicology and Pharmaceutical Science', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (23, 'Philosophy', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (24, 'Physics and Astronomy', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (25, 'Psychology', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (26, 'Social Sciences', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (27, 'Sports and Recreations', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (28, 'Unspecified', null);
INSERT INTO eseco.core_disciplines (id, name, parent) VALUES (29, 'Veterinary Science and Veterinary Medicine', null);
create table core_institutions
(
  id      int auto_increment
    primary key,
  name    varchar(255) not null,
  city_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FKm24ugeiqnr5535qfa9eta6c6y
  on core_institutions (city_id);

INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (1, 'Universidade Federal de Juiz de Fora', 28);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (2, 'Universidade Federal de  Minas Gerais', 13);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (3, 'Universidade Estadual do Sudoeste da Bahia', 29);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (4, 'Empresa Brasileira de Pesquisa Agropecuária - EMBRAPA', 28);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (5, 'Federal University of Juiz de Fora', 28);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (6, 'Universidade Estadual de Montes Claros', 30);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (7, 'Universidade Federal de Viçosa', 31);
INSERT INTO eseco.core_institutions (id, name, city_id) VALUES (8, 'Universidade Estadual de Santa Cruz', 32);
create table core_interests
(
  id   int auto_increment
    primary key,
  name varchar(255) null
)
  engine = InnoDB
  charset = latin1;

INSERT INTO eseco.core_interests (id, name) VALUES (1, 'Context awareness');
INSERT INTO eseco.core_interests (id, name) VALUES (2, 'Data provenance');
INSERT INTO eseco.core_interests (id, name) VALUES (15, 'Laticínios');
INSERT INTO eseco.core_interests (id, name) VALUES (14, 'Nutrição animal');
INSERT INTO eseco.core_interests (id, name) VALUES (13, 'Produção de leite');
INSERT INTO eseco.core_interests (id, name) VALUES (12, 'Reprodução animal');
INSERT INTO eseco.core_interests (id, name) VALUES (11, 'Criação de bezerros');
INSERT INTO eseco.core_interests (id, name) VALUES (8, 'Zootecnia');
INSERT INTO eseco.core_interests (id, name) VALUES (9, 'Produção animal');
INSERT INTO eseco.core_interests (id, name) VALUES (10, 'Bovinocultura');
INSERT INTO eseco.core_interests (id, name) VALUES (16, 'Rúmen');
INSERT INTO eseco.core_interests (id, name) VALUES (17, 'Nutrição de ruminantes');
INSERT INTO eseco.core_interests (id, name) VALUES (18, 'Produção de ruminates');
INSERT INTO eseco.core_interests (id, name) VALUES (19, 'Eficiência alimentar');
INSERT INTO eseco.core_interests (id, name) VALUES (20, 'Avaliação de alimentos');
INSERT INTO eseco.core_interests (id, name) VALUES (21, 'Conservação de forragens');
INSERT INTO eseco.core_interests (id, name) VALUES (22, 'Bioenergética e Exigências Nutricionais de Bovinos Leiteiros');
INSERT INTO eseco.core_interests (id, name) VALUES (23, 'Gases de Efeito Estufa na Pecuária');
INSERT INTO eseco.core_interests (id, name) VALUES (24, 'Técnicas de digestibilidade para ruminantes');
INSERT INTO eseco.core_interests (id, name) VALUES (25, 'Pastagens e forragicultura');
INSERT INTO eseco.core_interests (id, name) VALUES (26, 'Avaliação de alimentos para ruminantes');
INSERT INTO eseco.core_interests (id, name) VALUES (27, 'Nutrição e alimentação animal');
INSERT INTO eseco.core_interests (id, name) VALUES (28, 'Inseminação Artificial Animal');
INSERT INTO eseco.core_interests (id, name) VALUES (29, ' Fisiopatologia da Reprodução Animal');
INSERT INTO eseco.core_interests (id, name) VALUES (30, 'Melhoramento Animal');
INSERT INTO eseco.core_interests (id, name) VALUES (31, 'Manejo de rebanho');
INSERT INTO eseco.core_interests (id, name) VALUES (32, 'Qualidade do Leite');
create table core_research_group_researcher
(
  research_group_id int not null,
  researcher_id     int not null
)
  engine = InnoDB
  charset = latin1;

create index FKdwlqyjavrshab1xhd5wrgut5n
  on core_research_group_researcher (research_group_id);

create index FKmp014i6g70kmem7j7k0um55ge
  on core_research_group_researcher (researcher_id);


create table core_research_groups
(
  id          int auto_increment
    primary key,
  description text         null,
  name        varchar(255) null,
  web_page    varchar(255) null
)
  engine = InnoDB
  charset = latin1;


create table core_states
(
  id         int auto_increment
    primary key,
  code       varchar(255) not null,
  name       varchar(255) null,
  capital_id int          null,
  country_id int          not null,
  constraint UK_3i9bpujt632hy8sgefetumy1o
    unique (name),
  constraint UK_evs3m0995aphx73eacn09rh0j
    unique (code)
)
  engine = InnoDB
  charset = latin1;

create index FKqvbfm1xx841ggoffqcevyxbgw
  on core_states (capital_id);

create index FKrxrh3rp1wy2qnr4feqp2ackxt
  on core_states (country_id);

INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (1, 'AC', 'Acre', 1, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (2, 'AL', 'Alagoas', 2, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (3, 'AP', 'Amapá', 3, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (4, 'AM', 'Amazonas', 4, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (5, 'BA', 'Bahia', 5, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (6, 'CE', 'Ceará', 6, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (7, 'DF', 'Distrito Federal', 7, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (8, 'ES', 'Espírito Santo', 8, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (9, 'GO', 'Goiás', 9, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (10, 'MA', 'Maranhão', 10, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (11, 'MT', 'Mato Grosso', 11, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (12, 'MS', 'Mato Grosso do Sul', 12, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (13, 'MG', 'Minas Gerais', 13, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (14, 'PA', 'Pará', 14, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (15, 'PB', 'Paraíba', 15, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (16, 'PR', 'Paraná', 16, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (17, 'PE', 'Pernambuco', 17, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (18, 'PI', 'Piauí', 18, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (19, 'RJ', 'Rio de Janeiro', 19, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (20, 'RN', 'Rio Grande do Norte', 20, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (21, 'RS', 'Rio Grande do Sul', 21, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (22, 'RO', 'Rondônia', 22, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (23, 'RR', 'Roraima', 23, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (24, 'SC', 'Santa Catarina', 24, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (25, 'SP', 'São Paulo', 25, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (26, 'SE', 'Sergipe', 26, 31);
INSERT INTO eseco.core_states (id, code, name, capital_id, country_id) VALUES (27, 'TO', 'Tocantins', 27, 31);
create table exp_activities
(
  id           int auto_increment
    primary key,
  date_created date         null,
  description  text         null,
  name         varchar(255) null,
  author_id    int          null
)
  engine = InnoDB
  charset = latin1;

create index FKknhvi932iavpyc4jvbgb860ij
  on exp_activities (author_id);


create table exp_activities_workflowservices
(
  activity_id        int not null,
  workflowservice_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FKkt0tkhnlip2yrjog52hc55qqh
  on exp_activities_workflowservices (activity_id);

create index FKlfri0mlyljcchw69d0ww7lwva
  on exp_activities_workflowservices (workflowservice_id);


create table exp_activity_detail
(
  activity_id int not null,
  detail_id   int not null,
  constraint UK_9p8nagsaqsb1polyd2kkorb1g
    unique (detail_id)
)
  engine = InnoDB
  charset = latin1;

create index FKg94xk6vxyu4hlk4iy64nq14sx
  on exp_activity_detail (activity_id);


create table exp_activity_executions
(
  id         int auto_increment
    primary key,
  end_time   datetime null,
  start_time datetime null,
  activity   int      not null,
  author_id  int      not null
)
  engine = InnoDB
  charset = latin1;

create index FKi6j19dn15qjhbgvvimgkuwbpw
  on exp_activity_executions (activity);

create index FKqlj8imgp9b5848dule4ioqkvo
  on exp_activity_executions (author_id);


create table exp_activity_inputs
(
  activity_id int not null,
  port_id     int not null
)
  engine = InnoDB
  charset = latin1;

create index FK8iyfqt6yrvbp4ce285l8sa2v8
  on exp_activity_inputs (activity_id);

create index FKlycvy5395xctc2cc8qjw7vwsl
  on exp_activity_inputs (port_id);


create table exp_activity_outputs
(
  activity_id int not null,
  port_id     int not null
)
  engine = InnoDB
  charset = latin1;

create index FK1t6g6i4xtt0150n2x7ropk0m1
  on exp_activity_outputs (port_id);

create index FKsxoc2ds8xl42dcdl52jdrxmwn
  on exp_activity_outputs (activity_id);


create table exp_data_providers
(
  id   int auto_increment
    primary key,
  name varchar(255) null
)
  engine = InnoDB;

INSERT INTO eseco.exp_data_providers (id, name) VALUES (1, 'Solcast');
INSERT INTO eseco.exp_data_providers (id, name) VALUES (2, 'Darksky');
create table exp_data_providers_parameters
(
  id              int auto_increment
    primary key,
  name            varchar(255) null,
  dataProvider_id int          null
)
  engine = InnoDB;

create index FK7amatgircys7cvadyoal6l36o
  on exp_data_providers_parameters (dataProvider_id);


create table exp_data_sources
(
  id           int auto_increment
    primary key,
  date_created datetime     null,
  date_updated datetime     null,
  name         varchar(255) null,
  author_id    int          null
)
  engine = InnoDB;

create index FKpe3w3tes9jrs1ivthrlewxh97
  on exp_data_sources (author_id);


create table exp_data_sources_providers
(
  id              int auto_increment
    primary key,
  dataProvider_id int null,
  dataSource_id   int null
)
  engine = InnoDB;

create index FK2yy4rp21708n1mfr3rw95jk8s
  on exp_data_sources_providers (dataSource_id);

create index FKhu799n2p6m7uxw1qw0pvd7hmn
  on exp_data_sources_providers (dataProvider_id);


create table exp_data_sources_providers_parameters
(
  id                       int auto_increment
    primary key,
  value_string             varchar(255) null,
  dataProviderParameter_id int          null,
  dataSourceProvider_id    int          null
)
  engine = InnoDB;

create index FKbqbybtk48ypdqwcrq5rmsveee
  on exp_data_sources_providers_parameters (dataProviderParameter_id);

create index FKqc5hx695up75hp8iixy4r8yn6
  on exp_data_sources_providers_parameters (dataSourceProvider_id);


create table exp_detail
(
  id          int auto_increment
    primary key,
  description text         null,
  name        varchar(255) null
)
  engine = InnoDB
  charset = latin1;


create table exp_detail_group
(
  id      int auto_increment
    primary key,
  details varchar(255) null,
  name    varchar(255) null
)
  engine = InnoDB
  charset = latin1;


create table exp_entities
(
  id        int auto_increment
    primary key,
  name      varchar(255) null,
  author_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FK699fd14d82vuqdi3jdb0i8ql1
  on exp_entities (author_id);


create table exp_entities_data
(
  id        int auto_increment
    primary key,
  type      varchar(255) null,
  value     text         null,
  entity_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FKj153csisgfpd3u6orjwt7dj2c
  on exp_entities_data (entity_id);


create table exp_entities_documents
(
  id        int auto_increment
    primary key,
  file      varchar(255) null,
  type      varchar(255) null,
  value     text         null,
  entity_id int          null
)
  engine = InnoDB
  charset = latin1;

create index FK6lchls351ad1dhnlqen5xu3c3
  on exp_entities_documents (entity_id);


create table exp_experiment_detail
(
  experiment_id int not null,
  detail_id     int not null,
  constraint UK_5qh9pd03h1yw4ypkv7fvkbpmr
    unique (detail_id)
)
  engine = InnoDB
  charset = latin1;

create index FK7j63x9wgxt5a20myu4hfdfnnt
  on exp_experiment_detail (experiment_id);


create table exp_experiment_discipline
(
  experiment_id int not null,
  discipline_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK6405qih7ujt75qdek5jdjilxh
  on exp_experiment_discipline (discipline_id);

create index FKicvn8r1iufvhwgbjs46n832wg
  on exp_experiment_discipline (experiment_id);


create table exp_experiment_institution
(
  experiment_id  int not null,
  institution_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK30q79mt5qlny8appo6dleufhh
  on exp_experiment_institution (institution_id);

create index FKlyfd8lk44lvpi327gij49ejv
  on exp_experiment_institution (experiment_id);


create table exp_experiment_phase_reports
(
  id            int auto_increment
    primary key,
  current_phase int  null,
  date_created  date null,
  description   text null,
  author_id     int  not null,
  experiment_id int  not null
)
  engine = InnoDB
  charset = latin1;

create index FK2ga5hmynaoplcs0465uvovke1
  on exp_experiment_phase_reports (experiment_id);

create index FKbyjnl6edgxdup59rbo11fq13u
  on exp_experiment_phase_reports (author_id);


create table exp_experiment_research_group
(
  experiment_id     int not null,
  research_group_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FKk0f62wi8ou8gy95afpvn31369
  on exp_experiment_research_group (research_group_id);

create index FKp405w03fa0qljtm7q4gdxkyu4
  on exp_experiment_research_group (experiment_id);


create table exp_experiment_researcher
(
  experiment_id int not null,
  researcher_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK36kab23m9ujw80yr0k0uxismy
  on exp_experiment_researcher (experiment_id);

create index FK39mgah2kmqt5mbre5lubvmbh4
  on exp_experiment_researcher (researcher_id);


create table exp_experiment_workflow
(
  experiment_id int not null,
  workflow_id   int not null
)
  engine = InnoDB
  charset = latin1;

create index FK72eci3bh650vx70nkt2lfccah
  on exp_experiment_workflow (experiment_id);

create index FKmq6ldbobb91incdsjidwq95p1
  on exp_experiment_workflow (workflow_id);


create table exp_experiments
(
  id            int auto_increment
    primary key,
  current_phase int          null,
  date_created  date         null,
  date_ended    date         null,
  date_updated  date         null,
  description   text         null,
  key_words     varchar(255) null,
  name          varchar(255) null,
  status        int          null,
  version       varchar(255) null,
  author_id     int          not null,
  detail_group  int          null
)
  engine = InnoDB
  charset = latin1;

create index FK3y6i7ghj28e3kd4gnxh1i40kv
  on exp_experiments (detail_group);

create index FK8wdtrv2sj8xua9d7s9pmq2cf4
  on exp_experiments (author_id);


create table exp_ports
(
  id        int auto_increment
    primary key,
  entity_id int not null
)
  engine = InnoDB
  charset = latin1;

create index FK830q3jyptlpgcj45opi97hmw5
  on exp_ports (entity_id);


create table exp_wfms
(
  id   int auto_increment
    primary key,
  link varchar(255) null,
  name varchar(255) null
)
  engine = InnoDB
  charset = latin1;


create table exp_workflow_activity
(
  order_exec  int null,
  activity_id int not null,
  workflow_id int not null,
  primary key (activity_id, workflow_id)
)
  engine = InnoDB
  charset = latin1;

create index FKo8td603fqb6sv954o1fwwxpy9
  on exp_workflow_activity (workflow_id);


create table exp_workflow_execution_activity_execution
(
  workflow_execution_id int not null,
  activity_execution_id int not null,
  constraint UK_93w0is4v17g1k0noldtw2m27r
    unique (activity_execution_id)
)
  engine = InnoDB
  charset = latin1;

create index FKh8s3866jdht94q2rbhj72nfam
  on exp_workflow_execution_activity_execution (workflow_execution_id);


create table exp_workflow_executions
(
  id            int auto_increment
    primary key,
  end_time      datetime null,
  start_time    datetime null,
  author_id     int      not null,
  experiment_id int      not null,
  workflow      int      not null
)
  engine = InnoDB
  charset = latin1;

create index FKebyw0g9ol47bdei6to92ithk7
  on exp_workflow_executions (experiment_id);

create index FKk4v7d9ofa6iq5xf2e57s0wx0g
  on exp_workflow_executions (workflow);

create index FKnjlmwsbt81c6q3bxjb2phr0g7
  on exp_workflow_executions (author_id);


create table exp_workflow_inputs
(
  workflow_id int not null,
  port_id     int not null
)
  engine = InnoDB
  charset = latin1;

create index FKgnujy2g8lck650r1rlerthyi9
  on exp_workflow_inputs (port_id);

create index FKmjmnxve10uj2na4jw2et0mrvg
  on exp_workflow_inputs (workflow_id);


create table exp_workflow_outputs
(
  workflow_id int not null,
  port_id     int not null
)
  engine = InnoDB
  charset = latin1;

create index FKc1esrqi7mpm87s6lppkwueebm
  on exp_workflow_outputs (port_id);

create index FKqrnhq7rsyaknym2y0fx9ds1wm
  on exp_workflow_outputs (workflow_id);


create table exp_workflows
(
  id           int auto_increment
    primary key,
  date_created date         null,
  description  text         null,
  link         varchar(255) null,
  name         varchar(255) null,
  value        text         null,
  version      varchar(255) null,
  author_id    int          not null,
  wfms         int          not null
)
  engine = InnoDB
  charset = latin1;

create index FK1s70xnudcejtrpibci2oiyu0g
  on exp_workflows (wfms);

create index FKqslqgl3bji8jfhnk39ho8x3cj
  on exp_workflows (author_id);


create table hibernate_sequence
(
  next_val bigint null
)
  engine = InnoDB;

INSERT INTO eseco.hibernate_sequence (next_val) VALUES (21);
create table res_component_developers
(
  component_id int not null,
  developer_id int not null,
  constraint UK_h941jk5dpq11i0uiaqo2t7gby
    unique (developer_id)
)
  engine = InnoDB
  charset = latin1;

create index FKeoykgm79uj440dfm89tkidhgb
  on res_component_developers (component_id);


create table res_component_types
(
  id   int auto_increment
    primary key,
  name varchar(255) null
)
  engine = InnoDB
  charset = latin1;

INSERT INTO eseco.res_component_types (id, name) VALUES (1, 'Plugin');
INSERT INTO eseco.res_component_types (id, name) VALUES (2, 'Workflow Service');
create table res_components
(
  id                int auto_increment
    primary key,
  date_created      datetime     null,
  date_updated      datetime     null,
  documentation_url text         null,
  name              varchar(255) null,
  author_id         int          not null,
  type_id           int          not null
)
  engine = InnoDB
  charset = latin1;

create index FKfa2l3vre3kbnar6k9alu8q9fl
  on res_components (author_id);

create index FKgvn6qp9ggx1vjv0xuw9aa8w8w
  on res_components (type_id);

INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (1, '2018-12-31 15:25:26', null, null, 'E-SECO - Physics - Distance Traveled', 1, 2);
INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (2, '2018-12-31 15:58:20', null, null, 'E-SECO - Physics - Acceleration Calculator', 1, 2);
INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (3, '2018-12-31 16:36:28', null, null, 'E-SECO - Biology - Specimen Information Search', 1, 2);
create table res_workflow_services
(
  id             int auto_increment
    primary key,
  description    varchar(255) null,
  internal_class varchar(255) null,
  nature         varchar(255) null,
  type           varchar(255) null,
  url            varchar(255) null,
  component_id   int          null,
  constraint UK_rqe4cpt8u2tqae6mff9ugshfl
    unique (internal_class)
)
  engine = InnoDB
  charset = latin1;

create index FK4xgj81k1ipc821xx0f0scx770
  on res_workflow_services (component_id);

INSERT INTO eseco.res_workflow_services (id, description, internal_class, nature, type, url, component_id) VALUES (1, 'Return the distance traveled by an specified acceleration from between an initial and final speeds', 'br.ufjf.pgcc.eseco.services.eseco.physics.DistanceTraveled', null, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/eseco-physics/distance-traveled', 1);
INSERT INTO eseco.res_workflow_services (id, description, internal_class, nature, type, url, component_id) VALUES (2, 'Return the acceleration from a change of speed in certain time. Also returns the distance traveled.', 'br.ufjf.pgcc.eseco.services.eseco.physics.AccelerationCalculator', null, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/eseco-physics/acceleration-calculator', 2);
INSERT INTO eseco.res_workflow_services (id, description, internal_class, nature, type, url, component_id) VALUES (3, 'Get information about a Earth life specimen', 'br.ufjf.pgcc.eseco.services.eseco.biology.SpecimenInformationSearch', null, 'REST', 'http://nenc.ufjf.br:8080/eseco/api/eseco-biology/specimen-information-search', 3);
create table res_workflow_services_comments
(
  id                 int auto_increment
    primary key,
  content            text     null,
  date               datetime null,
  rate_star_1        int      null,
  rate_star_2        int      null,
  rate_star_3        int      null,
  rate_star_4        int      null,
  rate_star_5        int      null,
  commenter_id       int      not null,
  parent_id          int      null,
  workflowService_id int      null
)
  engine = InnoDB
  charset = latin1;

create index FK2sb2migp57btlnwt2ysc2atu
  on res_workflow_services_comments (commenter_id);

create index FK7n39gqun30il865diafefctoi
  on res_workflow_services_comments (parent_id);

create index FKaq7r193c0ly8s681avret2nrr
  on res_workflow_services_comments (workflowService_id);


create table res_workflow_services_ratings
(
  id                  int auto_increment
    primary key,
  approved            bit      null,
  date                datetime null,
  reproved_text       text     null,
  type                int      null,
  value_disponibility int      null,
  value_documentation int      null,
  value_ease_of_use   int      null,
  value_performance   int      null,
  value_reliability   int      null,
  rater_id            int      not null,
  workflowService_id  int      null
)
  engine = InnoDB
  charset = latin1;

create index FK1wsug3y880h83wxsqag980oil
  on res_workflow_services_ratings (workflowService_id);

create index FKp7jehvgu7w02hpgqleahm7qg1
  on res_workflow_services_ratings (rater_id);


create table res_workflow_services_ratings_invitations
(
  id                   int auto_increment
    primary key,
  completed            bit      null,
  date_chat            datetime null,
  date_completed       datetime null,
  date_invited         datetime null,
  participated_in_chat bit      null,
  asker_id             int      null,
  rater_id             int      null,
  workflowService_id   int      null
)
  engine = InnoDB
  charset = latin1;

create index FK7t5m8q9o3pt01dwfsdceevtcp
  on res_workflow_services_ratings_invitations (asker_id);

create index FK85bfwpgps3rrcqr0psg9ceqnp
  on res_workflow_services_ratings_invitations (rater_id);

create index FKkppk4lffpqe7amg9jdasqcb2d
  on res_workflow_services_ratings_invitations (workflowService_id);


create table sm_eseco_biology_specimen_collection_types
(
  id   int auto_increment
    primary key,
  name varchar(255) not null
)
  engine = InnoDB;

INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (1, 'Observations');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (2, 'Botany');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (3, 'Mollusca');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (4, 'Lepidoptera');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (5, 'Hymenoptera');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (6, 'Aves');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (7, 'Coleoptera');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (8, 'Paleontology Invertebrates');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (9, 'Bird sounds');
INSERT INTO eseco.sm_eseco_biology_specimen_collection_types (id, name) VALUES (10, 'Crustacea');
create table uac_roles
(
  id   int          not null
    primary key,
  name varchar(255) not null
)
  engine = InnoDB
  charset = latin1;

INSERT INTO eseco.uac_roles (id, name) VALUES (1, 'Admin');
INSERT INTO eseco.uac_roles (id, name) VALUES (2, 'Researcher');
INSERT INTO eseco.uac_roles (id, name) VALUES (3, 'Developer');
create table uac_users
(
  id                       int auto_increment
    primary key,
  activation_code          varchar(255) null,
  activation_expire_date   datetime     null,
  active                   bit          not null,
  email                    varchar(255) not null,
  login                    varchar(255) not null,
  password                 varchar(255) null,
  redefinition_code        varchar(255) null,
  redefinition_expire_date datetime     null,
  register_date            datetime     null,
  constraint UK_4irsjvmmxr66a910owdqsvsl8
    unique (email),
  constraint UK_kl9p593rs2a8wjpsitrgh7i60
    unique (login)
)
  engine = InnoDB
  charset = latin1;

INSERT INTO eseco.uac_users (id, activation_code, activation_expire_date, active, email, login, password, redefinition_code, redefinition_expire_date, register_date) VALUES (1, null, null, true, 'leoaguiarpereira@gmail.com', 'leoaguiarpereira@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', null, null, '2018-12-31 15:19:39');
create table uac_users_roles
(
  id_user int not null,
  id_role int not null
)
  engine = InnoDB
  charset = latin1;

create index FK7808thnb4yhr5rw92ikg2h59j
  on uac_users_roles (id_user);

create index FKmjqpx78dy0ermw3hvguqs8020
  on uac_users_roles (id_role);

INSERT INTO eseco.uac_users_roles (id_user, id_role) VALUES (1, 2);
INSERT INTO eseco.uac_users_roles (id_user, id_role) VALUES (1, 3);