-- Tests des différentes contraintes sur la BD achats
-- Iwinski,Bailleul,Lorio - 2021

-- Ordres SQL pour tester des contraintes d'intégrité sur la table Client
\echo '\n*** Test client 1 - Contrainte UNIQUE sur id_client de Client ***\n'
INSERT INTO client VALUES (7,'Test','Valentin',25);

\echo '\n*** Test client 2 - Contrainte NOT NULL sur id_client de client ***\n'
INSERT INTO client VALUES (NULL,'Test','Valentin',62);

\echo '\n*** Test client 3 - Contrainte UNIQUE sur nom de client ***\n'
INSERT INTO client VALUES (16,'Lemsi','Marc',45);

\echo '\n*** Test client 4 - Contrainte NOT NULL sur nom de client ***\n'
INSERT INTO client VALUES (16,null,'Marc',17);

\echo '\n*** Test client 5 - Contrainte NOT NULL sur prenom de client ***\n'
INSERT INTO client VALUES (16,'Marc',NULL,5);

\echo '\n*** Test client 6 - Contrainte age>0 sur age de client ***\n'
INSERT INTO client VALUES (16,'Marc','Oracle',0);

\echo '\n*** Test client 7 - Contrainte id_client>=0 sur id_client de client ***\n'
INSERT INTO client VALUES (0,'Marc','Oracle',61);

\echo '\n*** Test client 8 - Contrainte varchar(20) sur nom de client ***\n'
INSERT INTO client VALUES(0,'henrieieieiiiiiiiieiieeeeeee','Oracle',61);

\echo '\n*** Test client 9 - Contrainte varchar(20) sur prenom de client ***\n'
INSERT INTO client VALUES(0,'Marc','henrieieieiiiiiiiieiieeeeeee',61);


-- Ordres SQL pour tester des contraintes d'intégrité sur la table Produit

\echo '\n*** Test produit 1 - Contrainte UNIQUE sur id_produit de produit ***\n'
INSERT INTO produit VALUES (7,'Ballon de plage',10);

\echo '\n*** Test produit 2 - Contrainte NOT NULL sur id_produit de produit ***\n'
INSERT INTO produit VALUES (NULL,'Ballon',9);

\echo '\n*** Test produit 3 - Contrainte UNIQUE sur nom_produit de produit ***\n'
INSERT INTO produit VALUES (18,'Velo',3);

\echo '\n*** Test produit 4 - Contrainte NOT NULL sur nom_produit de produit ***\n'
INSERT INTO produit VALUES (18,NULL,7);

\echo '\n*** Test produit 5 - Contrainte NOT NULL sur prix_en_euros de produit ***\n'
INSERT INTO produit VALUES (18,'Ballon',NULL);

\echo '\n*** Test produit 6 - Contrainte id_produit>0 sur id_produit de produit ***\n'
INSERT INTO produit VALUES (0,'Ballon',7);

\echo '\n*** Test produit 7 - Contrainte prix_en_euros>=0 sur prix_en_euros de produit ***\n'
INSERT INTO produit VALUES (18,'Ballon',-1);

\echo '\n*** Test produit 8 - Contrainte varchar(50) sur nom_produit de produit ***\n'
INSERT INTO produit VALUES (18,'ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo',85);



-- Ordres SQL pour tester des contraintes d'intégrité sur la table Achete

\echo '\n*** Test achete 1 - Contrainte UNIQUE sur (id_client,id_produit) de achete ***\n'
INSERT INTO achete VALUES (1,6,15);

\echo '\n*** Test achete 2 - Contrainte NOT NULL sur id_client de achete ***\n'
INSERT INTO achete VALUES (NULL,18,10);

\echo '\n*** Test achete 3 - Contrainte NOT NULL sur id_produit de achete ***\n'
INSERT INTO achete VALUES (17,NULL,10);

\echo '\n*** Test achete 4 - Contrainte id_client de achete référence id_client de client ***\n'
INSERT INTO achete VALUES (25,1,15);

\echo '\n*** Test achete 5 - Contrainte id_produit de achete référence id_produit de produit ***\n'
INSERT INTO achete VALUES (4,25,10);

\echo '\n*** Test achete 6 - Contrainte points_de_fidelite_gagnes>=0 sur points_de_fidelite_gagnes de achete ***\n'
INSERT INTO achete VALUES (1,5,-15);