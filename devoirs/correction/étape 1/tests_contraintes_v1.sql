-- Tests des différentes contraintes sur la BD SPORTS21_BDA_v1
-- Jean-François Condotta - 2021

-- Ordres SQL pour tester des contraintes d'intégrité sur la table SPORT

\echo '\n*** Test SPORT 1 - Contrainte UNIQUE sur id_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (2,'superSport1','superCatégorie1');
\echo '\n*** Test SPORT 2 - Contrainte NOT NULL sur id_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (NULL,'superSport2','superCatégorie2');
\echo '\n*** Test SPORT 3 - Contrainte UNIQUE sur nom_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (8,'Rugby','superCatégorie3');
\echo '\n*** Test SPORT 4 - Contrainte NOT NULL sur nom_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (9,NULL,'superCatégorie4');
\echo '\n*** Test SPORT 5 - Contrainte NOT NULL sur categorie de SPORT ***\n'
INSERT INTO SPORT VALUES (10,'superSport5',NULL);
\echo '\n*** Test SPORT 6 - Contrainte taille>0 sur nom_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (11,'','superCatégorie6');
\echo '\n*** Test SPORT 7 - Contrainte taille>0 sur categorie de SPORT ***\n'
INSERT INTO SPORT VALUES (12,'superSport7','');
\echo '\n*** Test SPORT 8 - Contrainte id_sport>=0 sur id_sport de SPORT ***\n'
INSERT INTO SPORT VALUES (-1,'superSport8','superCatégorie8');

-- Ordres SQL pour tester des contraintes d'intégrité sur la table PERSONNE

\echo '\n*** Test PERSONNE 1 - Contrainte UNIQUE sur id_pers de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (2,'superNom1','superPrenom1',30);
\echo '\n*** Test PERSONNE 2 - Contrainte NOT NULL sur id_pers de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (NULL,'superNom2','superPrenom2',30);
\echo '\n*** Test PERSONNE 3 - Contrainte UNIQUE sur (nom,prenom) de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (6,'Dujardin','Marc',30);
\echo '\n*** Test PERSONNE 4 - Contrainte NOT NULL sur nom de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (7,NULL,'superPrenom3',30);
\echo '\n*** Test PERSONNE 5 - Contrainte NOT NULL sur prenom de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (8,'superNom4',NULL,30);
\echo '\n*** Test PERSONNE 6 - Contrainte age>0 sur age de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (9,'superNom5','superPrenom5',0);
\echo '\n*** Test PERSONNE 7 - Contrainte id_pers>=0 sur id_pers de PERSONNE ***\n'
INSERT INTO PERSONNE VALUES (-1,'superNom6','superPrenom6',30);

-- Ordres SQL pour tester des contraintes d'intégrité sur la table PRATIQUE

\echo '\n*** Test PRATIQUE 1 - Contrainte UNIQUE sur (id_pers,id_sport) de PRATIQUE ***\n'
INSERT INTO PRATIQUE VALUES (0,2,10.0);
\echo '\n*** Test PRATIQUE 2 - Contrainte NOT NULL sur id_pers de PRATIQUE ***\n'
INSERT INTO PRATIQUE VALUES (NULL,2,10.0);
\echo '\n*** Test PRATIQUE 3 - Contrainte NOT NULL sur id_sport de PRATIQUE ***\n'
INSERT INTO PRATIQUE VALUES (0,NULL,10.0);
\echo '\n*** Test PRATIQUE 4 - Contrainte nb_heures>0.0 sur nb_heures de PRATIQUE ***\n'
INSERT INTO PRATIQUE VALUES (0,3,0.0);
\echo '\n*** Test PRATIQUE 5 - Contrainte id_pers de PRATIQUE référence id_pers de PERSONNE ***\n'
INSERT INTO PRATIQUE VALUES (50,1,2.0);
\echo '\n*** Test PRATIQUE 6 - Contrainte id_sport de PRATIQUE référence id_sport de SPORT ***\n'
INSERT INTO PRATIQUE VALUES (1,50,2.0);




