-- Création du contenu initial de la BD SPORTS21_BDA_v1
-- Jean-François Condotta - 2021

DELETE FROM PRATIQUE;
DELETE FROM SPORT;
DELETE FROM PERSONNE;


INSERT INTO PERSONNE VALUES
(0,'Dujardin','Marc',20),
(1,'Devos','Evelyne',43),
(2,'Panahi','Mahmoud',38),
(3,'Buzek','Elsa',50),
(4,'Amalric','Jeanne',20),
(5,'Pheonix','Arthur',32)
;

INSERT INTO SPORT VALUES
(0,'Marche','Athlétisme'),
(1,'Rugby','Collectif'),
(2,'Football','Collectif'),
(3,'Karaté','Art martial'),
(4,'Course à pied','Athlétisme'),
(5,'VTT','Cyclisme'),
(6,'Judo','Art martial'),
(7,'Volley-ball','Collectif')
;

INSERT INTO PRATIQUE VALUES
(0,2,2.0),
(1,4,1.5),
(1,5,3.5),
(2,2,4.0),
(3,0,NULL),
(4,3,2.5),
(4,6,2.0),
(5,0,NULL),
(5,4,NULL),
(5,7,3.0)
;

