USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_police', 'Police', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('police', 'Police')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('police',0,'recruit','Aspirant',200,'{}','{}'),
	('police',1,'officer','Surveillant',250,'{}','{}'),
	('police',2,'sergeant','Agent',300,'{}','{}'),
	('police',3,'lieutenant','Hoofdagent',500,'{}','{}'),
	('police',4,'boss','Inspecteur',600,'{}','{}')
	('police',5,'brigadier','Brigadier',700,'{}','{}')
	('police',6,'commisarris','Commisarris',800,'{}','{}')
	('police',7,'hoofdcommisarris','Hoofd-commisarris',900,'{}','{}')
	('police',8,'eerstecommisarris','Eerste-commisarris',950,'{}','{}')
	('police',9,'kmar1','Marechaussee 1e Klasse',1000,'{}','{}')
	('police',10,'kmar2','Marechaussee 2e Klasse',1050,'{}','{}')
	('police',11,'kmar3','Marechaussee 3e Klasse',1100,'{}','{}')
	('police',12,'kmar4','Marechaussee 4e Klasse',1150,'{}','{}')
	('police',13,'kmar5',' Wachtmeester',1200,'{}','{}')
	('police',14,'kmar6','Wachtmeester 1e Klasse',1250,'{}','{}')
	('police',15,'kmar7','Opperwachtmeester',1300,'{}','{}')
	('police',16,'kmar8','Adjudant-onderofficier',1350,'{}','{}')
	('police',17,'kmar9','Kornet',1400,'{}','{}')
	('police',18,'kmar10','Tweede-luitenant',1450,'{}','{}')
	('police',19,'kmar11','Eerste-luitenant',1550,'{}','{}')
	('police',20,'kmar12','Kapitein',1650,'{}','{}')
	('police',21,'kmar13','Majoor',1700,'{}','{}')
	('police',22,'kmar14','Luitenantkolonel',1750,'{}','{}')
	('police',23,'kmar15','Kolonel',1800,'{}','{}')
	('police',24,'kmar16','Brigadegeneraal',1850,'{}','{}')
	('police',25,'kmar17','Generaalmajoor',1900,'{}','{}')
	('police',26,'kmar17','Luitenantgeneraal',2150,'{}','{}')
;

CREATE TABLE `fine_types` (

	`id` int(11) NOT NULL AUTO_INCREMENT,
	`label` varchar(255) DEFAULT NULL,
	`amount` int(11) DEFAULT NULL,
	`category` int(11) DEFAULT NULL,

	PRIMARY KEY (`id`)
);

INSERT INTO `fine_types` (label, amount, category) VALUES
	('Misbruik van een hoorn', 30, 0),
('Illegaal oversteken van een ononderbroken lijn', 40, 0),
('Rijden aan de verkeerde kant van de weg', 250, 0),
('Illegale U-Turn', 250, 0),
('illegaal off-road rijden', 170, 0),
('Weigeren van een wettig bevel', 30, 0),
('Illegaal stoppen van een voertuig', 150, 0),
('Illegaal parkeren', 70, 0),
('Niet meegeven naar rechts', 70, 0),
('Niet voldoen aan voertuiginformatie', 90, 0),
('Niet stoppen bij een stopbord', 105, 0),
('Niet stoppen voor een rood licht', 130, 0),
('Illegaal doorgeven', 100, 0),
('Rijden met een illegaal voertuig', 100, 0),
('Rijden zonder rijbewijs', 1500, 0),
('Hit and Run', 800, 0),
('Snelheden overschrijden < 5 mph', 90, 0),
('Snelheden overschrijden van meer dan 5-15 mph', 120, 0),
('Snelheden overschrijden van meer dan 15-30 mph', 180, 0),
('Snelheden overschrijden > 30 mph', 300, 0),
('Doorstroming belemmeren', 110, 1),
('Openbare Intoxicatie', 90, 1),
('Onregelmatig gedrag', 90, 1),
('Obstructie van Justitie', 130, 1),
('Beledigingen jegens burgers', 75, 1),
('Het niet respecteren van een Ambtenaar in functie', 110, 1),
('Verbale bedreiging voor een burger', 90, 1),
('Verbale bedreiging voor een Ambtenaar in functie', 150, 1),
('Onjuiste informatie verstrekken', 250, 1),
('Poging tot corruptie', 1500, 1),
('Brandishing a wapen in city Limits', 120, 2),
('Brandishing a Lethal Weapon in City Limits', 300, 2),
('Geen wapenvergunning', 600, 2),
('Bezit van een illegaal wapen', 700, 2),
('Bezit van inbraakgereedschap', 300, 2),
('Grand Theft Auto', 1800, 2),
('Intentie om een ​​illegale stof te verkopen/verspreiden', 1500, 2),
('Verbroedering van een illegale stof', 1500, 2),
('Bezit van een illegale stof', 650, 2),
('Ontvoering van een burger', 1500, 2),
('Ontvoering van een Ambtenaar in functie', 2000, 2),
('Overval', 650, 2),
('Gewapende overval op een winkel', 650, 2),
('Gewapende overval op een bank', 1500, 2),
('Aanval op een burger', 2000, 3),
('Aanval van een Ambtenaar in functie', 2500, 3),
('Poging tot moord op een burger', 3000, 3),
('Poging tot moord op een Ambtenaar in functie', 5000, 3),
('Moord op een burger', 10000, 3),
('Moord op een Ambtenaar in functie', 30000, 3),
('Onvrijwillige doodslag', 1800, 3),
('Fraude', 2000, 2);
;
