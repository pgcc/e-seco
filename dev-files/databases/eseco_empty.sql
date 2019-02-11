create table core_agents
(
  id       int auto_increment
    primary key,
  birthday datetime     null,
  gender   varchar(1)   null,
  name     varchar(255) not null,
  user_id  int          not null,
  constraint FKktjutrgawejpe3sx56qomtw9d
    foreign key (user_id) references uac_users (id)
)
  charset = latin1;

INSERT INTO eseco.core_agents (id, birthday, gender, name, user_id) VALUES (1, '1986-12-01 00:00:00', 'M', 'Leonardo de Aguiar', 1);
create table core_agents_developers
(
  id       int auto_increment
    primary key,
  photo    varchar(255) null,
  agent_id int          null,
  constraint FKt3u84t7tbhdlqr96gfjv8hsfk
    foreign key (agent_id) references core_agents (id)
)
  charset = latin1;

INSERT INTO eseco.core_agents_developers (id, photo, agent_id) VALUES (1, null, 1);
create table core_agents_developers_institutions
(
  developer_id   int not null,
  institution_id int not null,
  constraint UK_i6dwtf4lnaf4oj9kl8e3fi738
    unique (institution_id),
  constraint FKao27ibvtxixjphvpxoxsegi35
    foreign key (institution_id) references core_institutions (id),
  constraint FKhmayxudv5ag8pqn3028tscg1s
    foreign key (developer_id) references core_agents_developers (id)
)
  charset = latin1;


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
  researchgate_id varchar(255) null,
  constraint FK71mh4922a0q3t7ebjdmviloap
    foreign key (agent_id) references core_agents (id)
)
  charset = latin1;


create table core_agents_researchers_disciplines
(
  researcher_id int not null,
  discipline_id int not null,
  constraint FK3cljndx53oh3fhog3r3pcqlae
    foreign key (researcher_id) references core_agents_researchers (id),
  constraint FKaop4mqc7p60pj7ojdctcod69m
    foreign key (discipline_id) references core_disciplines (id)
)
  charset = latin1;


create table core_agents_researchers_institutions
(
  researcher_id  int not null,
  institution_id int not null,
  constraint FK4wlj79hpje54w1yhctjronm5t
    foreign key (institution_id) references core_institutions (id),
  constraint FKnjibjwyfx0du85ecdpc8fbyql
    foreign key (researcher_id) references core_agents_researchers (id)
)
  charset = latin1;


create table core_agents_researchers_interests
(
  researcher_id int not null,
  interest_id   int not null,
  constraint FKnh6mjtvpkjbia7pheato1wreb
    foreign key (researcher_id) references core_agents_researchers (id),
  constraint FKr2qbtbwm9j8ovy2ssgulkv1e2
    foreign key (interest_id) references core_interests (id)
)
  charset = latin1;


create table core_agents_researchers_keywords
(
  id            int auto_increment
    primary key,
  name          varchar(255) null,
  year          varchar(255) null,
  researcher_id int          null,
  constraint FKbysyrmdwrxoud8bteeejyfyyp
    foreign key (researcher_id) references core_agents_researchers (id)
)
  charset = latin1;


create table core_cities
(
  id       int auto_increment
    primary key,
  name     varchar(255) null,
  state_id int          not null,
  constraint UK_6ivyhwdpu1fxm1m97g2qawr8o
    unique (name),
  constraint FKr4n74h5yvj373tnllfn8y777x
    foreign key (state_id) references core_states (id)
)
  charset = latin1;

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
  parent int          null,
  constraint FKci04mmvbc7f2kf2rjr38xtodp
    foreign key (parent) references core_disciplines (id)
)
  charset = latin1;

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
  city_id int          null,
  constraint FKm24ugeiqnr5535qfa9eta6c6y
    foreign key (city_id) references core_cities (id)
)
  charset = latin1;

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
  charset = latin1;

INSERT INTO eseco.core_interests (id, name) VALUES (1, 'Context awareness');
INSERT INTO eseco.core_interests (id, name) VALUES (2, 'Data provenance');
INSERT INTO eseco.core_interests (id, name) VALUES (8, 'Zootecnia');
INSERT INTO eseco.core_interests (id, name) VALUES (9, 'Produção animal');
INSERT INTO eseco.core_interests (id, name) VALUES (10, 'Bovinocultura');
INSERT INTO eseco.core_interests (id, name) VALUES (11, 'Criação de bezerros');
INSERT INTO eseco.core_interests (id, name) VALUES (12, 'Reprodução animal');
INSERT INTO eseco.core_interests (id, name) VALUES (13, 'Produção de leite');
INSERT INTO eseco.core_interests (id, name) VALUES (14, 'Nutrição animal');
INSERT INTO eseco.core_interests (id, name) VALUES (15, 'Laticínios');
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
  researcher_id     int not null,
  constraint FKdwlqyjavrshab1xhd5wrgut5n
    foreign key (research_group_id) references core_research_groups (id),
  constraint FKmp014i6g70kmem7j7k0um55ge
    foreign key (researcher_id) references core_agents_researchers (id)
)
  charset = latin1;


create table core_research_groups
(
  id          int auto_increment
    primary key,
  description text         null,
  name        varchar(255) null,
  web_page    varchar(255) null
)
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
    unique (code),
  constraint FKqvbfm1xx841ggoffqcevyxbgw
    foreign key (capital_id) references core_cities (id),
  constraint FKrxrh3rp1wy2qnr4feqp2ackxt
    foreign key (country_id) references core_countries (id)
)
  charset = latin1;

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
  author_id    int          null,
  constraint FKknhvi932iavpyc4jvbgb860ij
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_activities_workflowservices
(
  activity_id        int not null,
  workflowservice_id int not null,
  constraint FKkt0tkhnlip2yrjog52hc55qqh
    foreign key (activity_id) references exp_activities (id),
  constraint FKlfri0mlyljcchw69d0ww7lwva
    foreign key (workflowservice_id) references res_workflow_services (id)
)
  charset = latin1;


create table exp_activity_detail
(
  activity_id int not null,
  detail_id   int not null,
  constraint UK_9p8nagsaqsb1polyd2kkorb1g
    unique (detail_id),
  constraint FK91m2uj5jbunsqqyh7tn69nr35
    foreign key (detail_id) references exp_detail (id),
  constraint FKg94xk6vxyu4hlk4iy64nq14sx
    foreign key (activity_id) references exp_activities (id)
)
  charset = latin1;


create table exp_activity_executions
(
  id         int auto_increment
    primary key,
  end_time   datetime null,
  start_time datetime null,
  activity   int      not null,
  author_id  int      not null,
  constraint FKi6j19dn15qjhbgvvimgkuwbpw
    foreign key (activity) references exp_activities (id),
  constraint FKqlj8imgp9b5848dule4ioqkvo
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_activity_inputs
(
  activity_id int not null,
  port_id     int not null,
  constraint FK8iyfqt6yrvbp4ce285l8sa2v8
    foreign key (activity_id) references exp_activity_executions (id),
  constraint FKlycvy5395xctc2cc8qjw7vwsl
    foreign key (port_id) references exp_ports (id)
)
  charset = latin1;


create table exp_activity_outputs
(
  activity_id int not null,
  port_id     int not null,
  constraint FK1t6g6i4xtt0150n2x7ropk0m1
    foreign key (port_id) references exp_ports (id),
  constraint FKsxoc2ds8xl42dcdl52jdrxmwn
    foreign key (activity_id) references exp_activity_executions (id)
)
  charset = latin1;


create table exp_data_providers
(
  id   int auto_increment
    primary key,
  name varchar(255) null
);

INSERT INTO eseco.exp_data_providers (id, name) VALUES (1, 'Solcast');
INSERT INTO eseco.exp_data_providers (id, name) VALUES (2, 'Darksky');
create table exp_data_providers_parameters
(
  id              int auto_increment
    primary key,
  name            varchar(255) null,
  dataProvider_id int          null,
  constraint FK7amatgircys7cvadyoal6l36o
    foreign key (dataProvider_id) references exp_data_providers (id)
);


create table exp_data_sources
(
  id           int auto_increment
    primary key,
  date_created datetime     null,
  date_updated datetime     null,
  name         varchar(255) null,
  author_id    int          null,
  constraint FKpe3w3tes9jrs1ivthrlewxh97
    foreign key (author_id) references core_agents_researchers (id)
);


create table exp_data_sources_providers
(
  id              int auto_increment
    primary key,
  dataProvider_id int null,
  dataSource_id   int null,
  constraint FK2yy4rp21708n1mfr3rw95jk8s
    foreign key (dataSource_id) references exp_data_sources (id),
  constraint FKhu799n2p6m7uxw1qw0pvd7hmn
    foreign key (dataProvider_id) references exp_data_providers (id)
);


create table exp_data_sources_providers_parameters
(
  id                       int auto_increment
    primary key,
  value_string             varchar(255) null,
  dataProviderParameter_id int          null,
  dataSourceProvider_id    int          null,
  constraint FKbqbybtk48ypdqwcrq5rmsveee
    foreign key (dataProviderParameter_id) references exp_data_providers_parameters (id),
  constraint FKqc5hx695up75hp8iixy4r8yn6
    foreign key (dataSourceProvider_id) references exp_data_sources_providers (id)
);


create table exp_detail
(
  id          int auto_increment
    primary key,
  description text         null,
  name        varchar(255) null
)
  charset = latin1;


create table exp_detail_group
(
  id      int auto_increment
    primary key,
  details varchar(255) null,
  name    varchar(255) null
)
  charset = latin1;


create table exp_entities
(
  id        int auto_increment
    primary key,
  name      varchar(255) null,
  author_id int          null,
  constraint FK699fd14d82vuqdi3jdb0i8ql1
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_entities_data
(
  id        int auto_increment
    primary key,
  type      varchar(255) null,
  value     text         null,
  entity_id int          null,
  constraint FKj153csisgfpd3u6orjwt7dj2c
    foreign key (entity_id) references exp_entities (id)
)
  charset = latin1;


create table exp_entities_documents
(
  id        int auto_increment
    primary key,
  file      varchar(255) null,
  type      varchar(255) null,
  value     text         null,
  entity_id int          null,
  constraint FK6lchls351ad1dhnlqen5xu3c3
    foreign key (entity_id) references exp_entities (id)
)
  charset = latin1;


create table exp_experiment_detail
(
  experiment_id int not null,
  detail_id     int not null,
  constraint UK_5qh9pd03h1yw4ypkv7fvkbpmr
    unique (detail_id),
  constraint FK7j63x9wgxt5a20myu4hfdfnnt
    foreign key (experiment_id) references exp_experiments (id),
  constraint FKxtda5eixw61hm7c1y4rnahsf
    foreign key (detail_id) references exp_detail (id)
)
  charset = latin1;


create table exp_experiment_discipline
(
  experiment_id int not null,
  discipline_id int not null,
  constraint FK6405qih7ujt75qdek5jdjilxh
    foreign key (discipline_id) references core_disciplines (id),
  constraint FKicvn8r1iufvhwgbjs46n832wg
    foreign key (experiment_id) references exp_experiments (id)
)
  charset = latin1;


create table exp_experiment_institution
(
  experiment_id  int not null,
  institution_id int not null,
  constraint FK30q79mt5qlny8appo6dleufhh
    foreign key (institution_id) references core_institutions (id),
  constraint FKlyfd8lk44lvpi327gij49ejv
    foreign key (experiment_id) references exp_experiments (id)
)
  charset = latin1;


create table exp_experiment_phase_reports
(
  id            int auto_increment
    primary key,
  current_phase int  null,
  date_created  date null,
  description   text null,
  author_id     int  not null,
  experiment_id int  not null,
  constraint FK2ga5hmynaoplcs0465uvovke1
    foreign key (experiment_id) references exp_experiments (id),
  constraint FKbyjnl6edgxdup59rbo11fq13u
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_experiment_research_group
(
  experiment_id     int not null,
  research_group_id int not null,
  constraint FKk0f62wi8ou8gy95afpvn31369
    foreign key (research_group_id) references core_research_groups (id),
  constraint FKp405w03fa0qljtm7q4gdxkyu4
    foreign key (experiment_id) references exp_experiments (id)
)
  charset = latin1;


create table exp_experiment_researcher
(
  experiment_id int not null,
  researcher_id int not null,
  constraint FK36kab23m9ujw80yr0k0uxismy
    foreign key (experiment_id) references exp_experiments (id),
  constraint FK39mgah2kmqt5mbre5lubvmbh4
    foreign key (researcher_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_experiment_workflow
(
  experiment_id int not null,
  workflow_id   int not null,
  constraint FK72eci3bh650vx70nkt2lfccah
    foreign key (experiment_id) references exp_experiments (id),
  constraint FKmq6ldbobb91incdsjidwq95p1
    foreign key (workflow_id) references exp_workflows (id)
)
  charset = latin1;


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
  detail_group  int          null,
  constraint FK3y6i7ghj28e3kd4gnxh1i40kv
    foreign key (detail_group) references exp_detail_group (id),
  constraint FK8wdtrv2sj8xua9d7s9pmq2cf4
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_ports
(
  id        int auto_increment
    primary key,
  entity_id int not null,
  constraint FK830q3jyptlpgcj45opi97hmw5
    foreign key (entity_id) references exp_entities (id)
)
  charset = latin1;


create table exp_wfms
(
  id   int auto_increment
    primary key,
  link varchar(255) null,
  name varchar(255) null
)
  charset = latin1;


create table exp_workflow_activity
(
  order_exec  int null,
  activity_id int not null,
  workflow_id int not null,
  primary key (activity_id, workflow_id),
  constraint FK22ppdcl5uu8bj6at6eaqc2sv2
    foreign key (activity_id) references exp_activities (id),
  constraint FKo8td603fqb6sv954o1fwwxpy9
    foreign key (workflow_id) references exp_workflows (id)
)
  charset = latin1;


create table exp_workflow_execution_activity_execution
(
  workflow_execution_id int not null,
  activity_execution_id int not null,
  constraint UK_93w0is4v17g1k0noldtw2m27r
    unique (activity_execution_id),
  constraint FKgcp79sv36gerdehg3m4rh24kg
    foreign key (activity_execution_id) references exp_activity_executions (id),
  constraint FKh8s3866jdht94q2rbhj72nfam
    foreign key (workflow_execution_id) references exp_workflow_executions (id)
)
  charset = latin1;


create table exp_workflow_executions
(
  id            int auto_increment
    primary key,
  end_time      datetime null,
  start_time    datetime null,
  author_id     int      not null,
  experiment_id int      not null,
  workflow      int      not null,
  constraint FKebyw0g9ol47bdei6to92ithk7
    foreign key (experiment_id) references exp_experiments (id),
  constraint FKk4v7d9ofa6iq5xf2e57s0wx0g
    foreign key (workflow) references exp_workflows (id),
  constraint FKnjlmwsbt81c6q3bxjb2phr0g7
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table exp_workflow_inputs
(
  workflow_id int not null,
  port_id     int not null,
  constraint FKgnujy2g8lck650r1rlerthyi9
    foreign key (port_id) references exp_ports (id),
  constraint FKmjmnxve10uj2na4jw2et0mrvg
    foreign key (workflow_id) references exp_workflow_executions (id)
)
  charset = latin1;


create table exp_workflow_outputs
(
  workflow_id int not null,
  port_id     int not null,
  constraint FKc1esrqi7mpm87s6lppkwueebm
    foreign key (port_id) references exp_ports (id),
  constraint FKqrnhq7rsyaknym2y0fx9ds1wm
    foreign key (workflow_id) references exp_workflow_executions (id)
)
  charset = latin1;


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
  wfms         int          not null,
  constraint FK1s70xnudcejtrpibci2oiyu0g
    foreign key (wfms) references exp_wfms (id),
  constraint FKqslqgl3bji8jfhnk39ho8x3cj
    foreign key (author_id) references core_agents_researchers (id)
)
  charset = latin1;


create table hibernate_sequence
(
  next_val bigint null
);

INSERT INTO eseco.hibernate_sequence (next_val) VALUES (21);
create table res_component_developers
(
  component_id int not null,
  developer_id int not null,
  constraint UK_h941jk5dpq11i0uiaqo2t7gby
    unique (developer_id),
  constraint FKeoykgm79uj440dfm89tkidhgb
    foreign key (component_id) references res_components (id),
  constraint FKs0x2dn8b3r81ai68ppx2cyy3j
    foreign key (developer_id) references core_agents_developers (id)
)
  charset = latin1;


create table res_component_types
(
  id   int auto_increment
    primary key,
  name varchar(255) null
)
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
  type_id           int          not null,
  constraint FKfa2l3vre3kbnar6k9alu8q9fl
    foreign key (author_id) references core_agents_developers (id),
  constraint FKgvn6qp9ggx1vjv0xuw9aa8w8w
    foreign key (type_id) references res_component_types (id)
)
  charset = latin1;

INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (1, '2018-12-31 15:25:26', null, null, 'E-SECO - Physics - Distance Traveled', 1, 2);
INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (2, '2018-12-31 15:58:20', null, null, 'E-SECO - Physics - Acceleration Calculator', 1, 2);
INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (3, '2018-12-31 16:36:28', null, null, 'E-SECO - Biology - Specimen Information Search', 1, 2);
INSERT INTO eseco.res_components (id, date_created, date_updated, documentation_url, name, author_id, type_id) VALUES (4, '2019-02-10 18:13:05', null, null, 'Collaborative Research Environment ', 1, 1);
create table res_plugins
(
  id             int auto_increment
    primary key,
  internal_class varchar(255) null,
  component_id   int          null,
  constraint UK_7avy3qpxm22uii6g4s9jgnmwm
    unique (internal_class)
)
  engine = MyISAM;

create index FKm6vs8u7lif4nnmgo567srxxgq
  on res_plugins (component_id);

INSERT INTO eseco.res_plugins (id, internal_class, component_id) VALUES (1, 'br.ufjf.pgcc.eseco.app.plugins.CollaborativeResearchEnvironment.Plugin', 4);
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
    unique (internal_class),
  constraint FK4xgj81k1ipc821xx0f0scx770
    foreign key (component_id) references res_components (id)
)
  charset = latin1;

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
  workflowService_id int      null,
  constraint FK2sb2migp57btlnwt2ysc2atu
    foreign key (commenter_id) references core_agents (id),
  constraint FK7n39gqun30il865diafefctoi
    foreign key (parent_id) references res_workflow_services_comments (id),
  constraint FKaq7r193c0ly8s681avret2nrr
    foreign key (workflowService_id) references res_workflow_services (id)
)
  charset = latin1;


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
  workflowService_id  int      null,
  constraint FK1wsug3y880h83wxsqag980oil
    foreign key (workflowService_id) references res_workflow_services (id),
  constraint FKp7jehvgu7w02hpgqleahm7qg1
    foreign key (rater_id) references core_agents (id)
)
  charset = latin1;


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
  workflowService_id   int      null,
  constraint FK7t5m8q9o3pt01dwfsdceevtcp
    foreign key (asker_id) references core_agents_developers (id),
  constraint FK85bfwpgps3rrcqr0psg9ceqnp
    foreign key (rater_id) references core_agents_researchers (id),
  constraint FKkppk4lffpqe7amg9jdasqcb2d
    foreign key (workflowService_id) references res_workflow_services (id)
)
  charset = latin1;


create table sm_eseco_biology_specimen_collection_types
(
  id   int auto_increment
    primary key,
  name varchar(255) not null
);

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
  charset = latin1;

INSERT INTO eseco.uac_users (id, activation_code, activation_expire_date, active, email, login, password, redefinition_code, redefinition_expire_date, register_date) VALUES (1, null, null, true, 'leoaguiarpereira@gmail.com', 'leoaguiarpereira@gmail.com', '94cd166631d14dab533858b9b47e9584a2ff3f65', null, null, '2018-12-31 15:19:39');
create table uac_users_roles
(
  id_user int not null,
  id_role int not null,
  constraint FK7808thnb4yhr5rw92ikg2h59j
    foreign key (id_user) references uac_users (id),
  constraint FKmjqpx78dy0ermw3hvguqs8020
    foreign key (id_role) references uac_roles (id)
)
  charset = latin1;

INSERT INTO eseco.uac_users_roles (id_user, id_role) VALUES (1, 2);
INSERT INTO eseco.uac_users_roles (id_user, id_role) VALUES (1, 3);