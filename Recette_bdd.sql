-- V_6 DATABASE [Ajout de plus de recettes pour plus de plaisir!]

DROP DATABASE IF EXISTS id5862521_cook_book;

create database id5862521_cook_book;
use id5862521_cook_book;

#------------------------------------------------------------
#        Script MySQL.
#------------------------------------------------------------


#------------------------------------------------------------
# Table: Recette
#------------------------------------------------------------

CREATE TABLE Recette(
        ID_recette  int (11) Auto_increment  NOT NULL ,
        nom_recette Varchar (200) ,
        nb_pers     Int ,
        temps_min   Int ,
        instruction Longtext ,
        note        Float ,
        ID_cat      Int ,
        PRIMARY KEY (ID_recette )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Categorie
#------------------------------------------------------------

CREATE TABLE Categorie(
        ID_cat  int (11) Auto_increment  NOT NULL ,
        nom_cat Varchar (25) NOT NULL ,
        PRIMARY KEY (ID_cat )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Ingredient
#------------------------------------------------------------

CREATE TABLE Ingredient(
        ID_ingr  int (11) Auto_increment  NOT NULL ,
        nom_ingr Varchar (200) ,
        type     Varchar (25) ,
        PRIMARY KEY (ID_ingr )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Allergene
#------------------------------------------------------------

CREATE TABLE Allergene(
        ID_all     int (11) Auto_increment  NOT NULL ,
        nom_allerg Varchar (25) ,
        PRIMARY KEY (ID_all )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: Utilisateur
#------------------------------------------------------------

CREATE TABLE Utilisateur(
        ID_utilis     int (11) Auto_increment  NOT NULL ,
        mot_d_passe   Varchar (25) ,
        nom_utilis    Varchar (25) ,
        prenom_utilis Varchar (25) ,
        vegetarien    Bool ,
        halal         Bool ,
        vegan         Bool ,
        ad_mail		  Varchar(25),
        PRIMARY KEY (ID_utilis )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: possede_Rc_Ing
#------------------------------------------------------------

CREATE TABLE possede_Rc_Ing(
        quantite   Float ,
        mesure     Varchar (25) ,
        ID_recette Int NOT NULL ,
        ID_ingr    Int NOT NULL ,
        PRIMARY KEY (ID_recette ,ID_ingr )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: compose_Ing_All
#------------------------------------------------------------

CREATE TABLE compose_Ing_All(
        ID_all  Int NOT NULL ,
        ID_ingr Int NOT NULL ,
        PRIMARY KEY (ID_all ,ID_ingr )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: note_Util_Rc
#------------------------------------------------------------

CREATE TABLE note_Util_Rc(
        note        Int ,
        description Varchar (500) ,
        date_note   Date ,
        ID_recette  Int NOT NULL ,
        ID_utilis   Int NOT NULL ,
        PRIMARY KEY (ID_recette ,ID_utilis )
)ENGINE=InnoDB;


#------------------------------------------------------------
# Table: est_allergique_All_Util
#------------------------------------------------------------

CREATE TABLE est_allergique_All_Util(
        ID_all    Int NOT NULL ,
        ID_utilis Int NOT NULL ,
        PRIMARY KEY (ID_all ,ID_utilis )
)ENGINE=InnoDB;

ALTER TABLE Recette ADD CONSTRAINT FK_Recette_ID_cat FOREIGN KEY (ID_cat) REFERENCES Categorie(ID_cat);
ALTER TABLE possede_Rc_Ing ADD CONSTRAINT FK_possede_Rc_Ing_ID_recette FOREIGN KEY (ID_recette) REFERENCES Recette(ID_recette);
ALTER TABLE possede_Rc_Ing ADD CONSTRAINT FK_possede_Rc_Ing_ID_ingr FOREIGN KEY (ID_ingr) REFERENCES Ingredient(ID_ingr);
ALTER TABLE compose_Ing_All ADD CONSTRAINT FK_compose_Ing_All_ID_all FOREIGN KEY (ID_all) REFERENCES Allergene(ID_all);
ALTER TABLE compose_Ing_All ADD CONSTRAINT FK_compose_Ing_All_ID_ingr FOREIGN KEY (ID_ingr) REFERENCES Ingredient(ID_ingr);
ALTER TABLE note_Util_Rc ADD CONSTRAINT FK_note_Util_Rc_ID_recette FOREIGN KEY (ID_recette) REFERENCES Recette(ID_recette);
ALTER TABLE note_Util_Rc ADD CONSTRAINT FK_note_Util_Rc_ID_utilis FOREIGN KEY (ID_utilis) REFERENCES Utilisateur(ID_utilis);
ALTER TABLE est_allergique_All_Util ADD CONSTRAINT FK_est_allergique_All_Util_ID_all FOREIGN KEY (ID_all) REFERENCES Allergene(ID_all);
ALTER TABLE est_allergique_All_Util ADD CONSTRAINT FK_est_allergique_All_Util_ID_utilis FOREIGN KEY (ID_utilis) REFERENCES Utilisateur(ID_utilis);

INSERT INTO `id5862521_cook_book`.`categorie` (`nom_cat`) VALUES ('Entrée');
INSERT INTO `id5862521_cook_book`.`categorie` (`nom_cat`) VALUES ('Plat');
INSERT INTO `id5862521_cook_book`.`categorie` (`nom_cat`) VALUES ('Dessert');


INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Jambalaya Poulet', '1', '65', '/ Couper le poivron en deux, retirer les graines et les cloisons internes, le débiter en carrés. / Eplucher et émincer le céleri en tronçons. Préchauffer le four à 180°C. / Dans une grande terrine, faire revenir 5 mn le chorizo avec les lardons, dans l\'huile chaude. Remplacer par le poulet. Faire dorer sur toutes leurs faces et les retirer. / Dans la même cocotte, faire fondre l\'oignon et l\'ail épluchés et hachés pendant 5 mn. Ajouter le poivron et le céleri et faire cuire 8 mn. en remuant. / Ajouter ensuite le poulet, les lardons, le riz versé en pluie, le coulis et la chair de tomate concassée, le thym, la sauge, le laurier, le piment de Cayenne. Arroser du bouillon et porter à ébullition. / Enfourner et faire cuire 40 mn. Laisser la jambalaya pendant 5 mn dans le four éteint, porte entrouverte, avant de servir.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Poulet Basquaise', '1', '80', '/ Hacher l\'oignon et l\'ail. Couper les tomates en morceaux et détailler les poivrons en lanières. / Faire chauffer 4 cuillères à soupe d\'huile dans une cocotte. Y faire dorer les oignons, l\'ail et les poivron. Laisser cuire 5 min. / Ajouter les tomates à la cocotte, saler, poivrer. Couvrir et laisser mijoter 20 min. / Dans une sauteuse, faire dorer dans l\'huile d\'olive les morceaux de poulet salés et poivrés. / Lorsqu\'ils sont dorés, les ajouter aux légumes, couvrir, ajouter le bouquet garni et le vin blanc et c\'est parti pour 35 min de cuisson.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Brochettes de poulet express aux épices', '1', '20', '/ Couper le poulet en cubes et les tremper dans la marinade (mélanger tous les ingrédients) puis faire 4 brochettes égales. / Faire cuire 10 min à la poêle en versant 2 cuillères de marinade pour la cuisson, retourner plusieurs fois. / Possibilité de saupoudrer un peu plus de curry à la cuisson. / Augmenter légèrement le feu pour un aspect caramélisé. / Servir avec du couscous aux épices ou une simple salade verte !', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Escalopes de poulet à l\'indienne', '1', '45', '/ Couper les carottes, l’ail, les échalotes et la pomme, en petits dés. / Emincer les escalopes de poulet. / Faire dorer les émincés, dans du beurre et ajouter les dés (carottes, pomme, etc.) pour les faire revenir. / Saupoudrer de farine et de curry, tourner. / Ajouter un grand verre d’eau, les tomates pelées et coupées, en petits dés. / Laisser cuire, à petit feu, pendant 20 à 30 min. / Incorporer la crème fraîche et porter à ébullition pendant 1 min.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Verrine avocat-truite fumée', '1', '15', '/ Ecraser la pulpe de l\'avocat dans un bol. / Saler très peu, poivrer et citronner. / Déposer 1/4 de la préparation dans chaque verrine. / Mélanger le fromage frais et le fromage ail et fines herbes dans un bol avec 1 cuillère à soupe d\'eau pour fluidifier. / Déposer dans les verrines en une seconde couche. / Couper les tranches de saumon fumé en petits morceaux, répartir dans les verrines et mettre au frais. / Au moment de servir, décorer de quelques oeufs de truite, brins de ciboulette, un filet de citron et un tour de moulin à poivres 5 baies. Note de l\'aute', '2.5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Crème d\'avocat', '1', '10', '/ Dénoyautez les avocats et enlevez la peau et mettez les dans un mixer avec le jus de citron. Mélangez. Ajoutez un peu de lait , crème et huile. C\'est prêt ! / Mettre au frais avant de servir.', '2.5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Gatêau au yaourt', '1', '45', '/ Préchauffer le four à 180°C (thermostat 6). Mélanger tout simplement les ingrédients un à un en suivant l\'ordre suivant : levure, / yaourt / huile / sucre / farine / oeuf et zeste / Beurrer un moule à manquer et y verser la pâte. / Enfourner pour environ 30 minutes de cuisson. / Vérifier la cuisson avec la pointe d\'un couteau (elle doit ressortir sèche).', '2.5', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Brochette boeuf fromage', '1', '30', '/ Couper le fromage en bâtonnets. La longueur doit correspondre à la largeur des tranches de viande. / Saler, poivrer la viande et la passer rapidement dans la sauce terryaiki. / Piquer le fromage sur les piques, enrouler la viande autour. / Cuire au barbecue ou à la poêle à feu vif.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tatin de navets confits au Parme', '1', '90', '/ Préchauffer le four à thermostat 7 (210°C). / Peler les navets, les faire cuire 5 mn à feu doux à couvert avec un peu de sel et de l eau à hauteur, puis les égoutter. / Faire réduire le vin de moitié (à feu vif). Caraméliser le sucre avec une goutte d eau dans une sauteuse. / Hors du feu, ajouter le vinaigre et le jus d orange. Remmettre sur le feu, ajouter le vin, 50 g de beurre, du sel et du poivre. / Plonger les navets dans ce sirop, couvrir aux trois quarts, puis laisser cuire en les retournant fréquement jusqu à ce qu ils soient tendres et enrobés d une couche sirupeuse. / Tapisser le fond de moule à tarte de papier sulfurisé beurré. Aligner les navets. poser la pâte, la piquer avec une aiguille, faire glisser les bords contre le moule. Cuire 25 mn au four. / Faire rissoler le jambon en lanières dans 10 g de beurre. / Laisser tiédir la tarte 5 mn, puis la retourner dans un plat. Parsemer de jambon et de brins de cerfeuil, puis servir.', '4', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tomates aux oeufs cocottes', '1', '20', '/ Laver les tomates, couper un "chapeau", et les évider complètement. / Enfourner les tomates salées et poivrées au four (200°C-th 6-7), pendant 3 min. / Sortir les tomates du four. Déposer dans le fond des tomates 1 cuillère à café de crème fraîche. / Casser les oeufs dans les tomates, remettre au four. / Laisser cuire, jusqu à ce que le blanc des oeufs blanchisse (environ 5 min), et servir immédiatement.', '3.5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tagliatelles au mascarpone et petits pois', '1', '35', '/ Faites bouillir une grande casserole d eau salée. / Mettez-y les petits pois, Laissez cuire 5 minutes puis ajoutez les tagliatelles. Laissez cuire 10 min. / Emincez l oignon, pressez l ail. Faites-les dorer avec un peu d huile dans une poêle. / Ajoutez le mascarpone et laissez fondre à feu doux. / Egouttez les pâtes et les petits pois, récupérez 2-3 cuillères à soupe d eau de cuisson pour délayer la sauce. / Mélangez les tagliatelles et petits pois à la sauce, parsemez de copeaux de parmesan et servez.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Pommes dauphines', '1', '70', '/ Faites cuire les pommes de terre à l eau bouilante salée environ 30 minutes (selon la taille). / Pendant ce temps, préparez la pâte à choux : portez à ébullition 10 cl d eau avec le beurre. / Salez et versez d un coup la farine, remuez énergiquement à la cuillère en bois jusqu à ce que la pâte se détache des birds de la casserole. / Laissez tiédir puis ajoutez les oeufs un à un, en mélangeant bien à chaque fois. / Egouttez et pelez les pommes de terre, écrasez-les en purée fine et ajoutez-les à la pâte à choux. Salez et poivrez, puis laissez refroidir. / Formez ensuite des petites boules de la taille d une noix avec vos mains farinées, ou utilisez une poche à douille. / Jetez-les dans l huile de friture bien chaude par petites quantités et laissez dorer 1 min environ.', '3', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Cookies pépites aux flocons d avoine', '1', '20', '/ Préchauffer le four à 180°C. / Mélanger flocons, farine et sucre (vanillé et roux), puis malaxer à la main avec oeufs, levure, sucre et beurre/margarine, ajouter ensuite les pépites. / Mettre de petites boules de pâte légèrement applaties sur une plaque à pâtisserie recouverte d une feuille de cuisson, bien espacées. / Enfourner 10 mn environ, pas plus, ça continue de cuire après être sorti du four.', '2.5', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Braisé de boeuf aux carottes', '1', '165', '/ Faire revenir les oignons a feu vif dans l huile d olive. / Une fois qu il sont un peu transparents, ajouter la viande de boeuf et tourner pour que toutes les faces soient prises. / Saler (peu si vous utilisez le bouillon cube), poivrer et ajouter une bonne pincée d herbes de Provence. Mélanger. / Ajouter le lard, puis les carottes et l ail non épluché. Verser le vin et le bouillon. / Maintenir le feu vif jusqu a ce que ça bouillone. / Ensuite, baisser le feu (feu très doux), puis laisser mijoter pendant 1h30 (ou plus) en vérifiant qu il reste suffisamment de liquide pour que ça n atttache pas. Sinon, rajouter un peu d eau.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Bruschetta', '1', '30', '/ Passer les tranches de pain 5 min au four (le temps de dorer très légèrement la mie). / Déposer sur chaque tranche de fine rondelles de tomates, une tranche de jambon. / Puis, y déposer enfin du fromage râpé ou du chèvre ou encore de la mozzarella (suivant le goût de chacun). Terminer la tartine par un filet d huile d olive, / un peu de poivre, et des herbes Provence. / Et passer au grill 5 min (le temps que le fromage soit gratiné). / Déguster.', '2.5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Poulet au Mont-d or et champignons', '1', '80', '/ Préchauffer le four à 210°C (thermostat 7). / Découper le poulet (voir vidéos très bien faites). / Faire revenir les morceaux de poulet dans une poêle pour les colorer. / Mettre les morceaux de poulet dans un plat allant au four. / Cuire 20 minutes. / Pendant ce temps, faire revenir les champignons dans la même poêle. Couper le feu lorsque les champignons sont décongelés. / A la fin de la cuisson du poulet, ajouter les champignons dans le plat. Sortir le Mont-d Or de sa boite en bois, le couper en deux et le poser sur le plat. / Remettre au four. / Sortir lorsque le dessus commence à gratiner (environ 20 min).', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Salade d été aux pêches', '1', '25', ' / Nettoyer la salade. / Couper le concombre en fines lamelles. / Couper les pêches en quartiers ou en dés. / Cuire le poulet une dizaine de minutes à la poêle et l assaisonner de sel et poivre. / Mélanger les ingrédients pour la vinaigrette. Mettre le tout dans un saladier, puis servir.', '2.5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Flan libanais à l eau de fleurs d oranger ', '6', '25', ' / Prendre comme mesure un verre à eau. / Dans une casserole mettre le lait avec le sucre et la fleur de maïs, fouettez pour bien diluer le tout et obtenir un mélange homogène, puis porter sur le feu en remuant avec une cuillère en bois sans arrêt pour que les grumeaux ne se forment pas. / Lorsque le mélange s épaissit retirer du feu, ajouter l eau de fleurs d oranger et les raisins secs et répartir dans des ramequins de service. / Mettre au frais pendant au moins 2 heures. / Au moment de servir, décorer de pistaches.', '2.5', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Boulettes de poulet au citron', '1', '40', ' / Hâcher les escalopes de poulet, râper le zeste du citron et presser le citron. / Dans un saladier, mélanger le poulet haché, un quart du zeste de citron, la moitié du jus de citron, le jaune d oeuf et la panure. Y ajouter la moutarde (2 cuillères à soupe), sel et poivre selon goût. / Façonner ensuite des petites boulettes de la taille d une grosse noix. / Mélanger le yaourt nature avec avec quelques feuilles de menthe préalablement ciselées très finement (j en mets 5 à 6 habituellement, vous pouvez en mettre plus si vous le souhaitez). Y ajouter environ 2 cuillères à soupe de jus de citron et une de zeste de citron. Réserver la sauce au yaourt au frais. / Chauffer de l huile dans une poêle et y dorer les boulettes de poulet de tous côtés, jusqu à ce qu elles soient cuites à l intérieur. / Servir avec la sauce yaourt-menthe. J accompagne souvent cette recette avec du riz et une salade. C est léger et rafraîchissant ! Bon appétit !', '3', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Riz sauté à l ananas', '1', '45', ' / Plonger le riz dans une casserole d eau bouillante salée. Eplucher et hacher finement l ail, ciseler les cébettes. / Ouvrir l ananas en 2 dans le sens de la longueur et en récupérer la chair. Attention à ne pas trop creuser pour ne pas percer la peau du fruit. / Couper la chair en cubes. / Préparer la sauce en mélangeant l huile de sésame, la sauce soja, le gingembre moulu et le piment coupé en petits morceaux. / Dans une sauteuse, faire revenir les crevettes décortiquées avec un peu d huile de sésame. Elles doivent devenir roses. / Retirer les crevettes de la poêle et faire revenir à la place l oignon rouge et l ail haché. / Ajouter le maïs et l ananas et laisser revenir 5 à 7 minutes. / Ajouter le riz et faire rissoler 3 minutes à feu vif. / Ajouter les crevettes et faire revenir 5 minutes avant de servir bien chaud.', '2.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Bananes flambées', '1', '10', '/ Faites chauffer une poêle, faites-y fondre le beurre et ajoutez-y les bananes coupées en long, faites dorer de chaque côté. / Saupoudrez de sucre vanillé, versez le rhum et faites flamber : lorsqu il n y aura plus de flammes, servez !', '3.5', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Aubergines farcies', '1', '55', '/ Coupez l aubergine eu deux dans le sens de la longueur. Avec un couteau, fendez la chair de l aubergine en faisant des X (cest pour que çà cuise à l intérieur). / Faites coulez un filez d huile d olive sur la surface, et enfournez à 250° pendant une demi heure. / Avec une cuillère à soupe, retirez la chair des aubergines et coupez la finement. / Faites blanchir les oignons à feu doux pendant un bon quart  heure sans les faire griller... au bout de 5 min, ajouter de la chair à saucisse si vous aimez la viande (c est très bon aussi sans…) / Puis ajouter la tomate coupée en petits dés et l ail, en laissant à feu très doux. / Ajoutez la chair d aubergine et assaisonner. Ajouter le persil et le basilic. / Et aussi l oeuf battu. / Mélangez bien le tout et remplissez les demi-aubergines. recouvrez de gruyère râpé. / Replacez au four pendant 5 à 10 mn dans le four encore chaud. /0 Faites refroidir un peu, c est bon chaud ou froid.', '3.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Osso bucco de veau', '1', '65', '/ Fariner la viande, tapoter pour retirer l excédent. Les faire dorer sur toutes les faces dans une cocotte-minute avec un fond d huile. / Peler et couper les carottes en rondelles épaisses, émincer les oignons, hacher l ail. Les ajouter dans la cocotte, ainsi que les tomates et le vin blanc. Saler, poivrer, ajouter le bouquet garni et fermer la cocotte. / Laisser cuire 45 min à partir de la mise en rotation de la soupape, à feu doux.', '4', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Poulet à la bière brune et au pain d épices', '1', '75', '/ Dans une cocotte (en fonte de préférence) ou une sauteuse, faire dorer les cuisses de poulets coté peau dans un premier temps pour les retourner pour faire dorer l autre coté à feu vif. / Une fois les deux cotés dorés, les retirer de la cocotte, laisser la graisse rendue par les cuisses dans le font et faire dorer les oignons hachés grossièrement puis les laisser fondre. / Rajouter les lardons, laisser un peu dorer l ensemble. / Baisser le feu et rajouter sur les oignons et les lardons, les cuisses de poulet. / Couvrir l ensemble avec la bière et émietter les tranches de pain d épice et ajouter le poivre (un tour ou deux). / Baisser le feu, laisser mijoter pendant 30 min à feu doux, cocotte couverte. / Puis découvrir pour que la sauce réduise, en augmentant le feu (15 min environ). Attention, bien surveiller car la sauce réduit très vite. / Quand la sauce a épaissie, couper le feu. / Servir avec des spaghettis ou des endives à la vapeur.', '4.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Galettes bretonnes complètes', '1', '15', '/ Hacher le jambon. / Malaxer la farine avec l huile, l oeuf et le sel puis verser l eau petit à petit. La pâte doit être fluide. / Laisser reposer 1 heure puis les cuire dans une poêle bien chaude légèrement graissée. / Retourner la crêpe et casser un oeuf dessus. Ajouter l équivalent d une demie tranche de jambon et 10 g de gruyère. / Lorsque le blanc d oeuf est cuit, repliez les côtés de la crêpes vers le centre. Saler, poivrer et servir.', '4', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Bagel toasté au saumon fumé', '1', '5', '/ Couper les bagels en 2 et les placer dans le grille pain (ou les toaster au four). / Retirer, tartiner de fromage frais, arroser de jus de citron et déposer le saumon fumé. Ajouter de l\'aneth. / Bon appétit !.', '4', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Velouté glacé petit pois menthe et mouillettes au chèvre', '1', '25', '/ Le velouté: / Faire cuire pendant 15 min les petits pois dans l\'eau bouillante avec le bouillon cube. / Egoutter les petits pois et garder un peu de bouillon.Le mettre au frigo / Passer les petits pois dans l\'eau glacé pour conserver leur couleur. / Mixer les petits pois avec les yaourts, la menthe, l\'ail et le bouillon refroidi. / Passer au chinois ou à la passoire fine et garder la "purée de petit pois" / Assaisoner à votre goût et mettre au frigo. / Pour les mouillettes: / Tartiner le pain avec la purée de petit pois puis mettre le chèvre coupé en tranche dessus. / Passer au four le temps de faire fondre le chèvre.Couper les tranches de pains en petits tronçons.', '3', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Egg muffin', '1', '10', '/ 1 Couper le muffin en 2 et placer le au four à 150°C (thermostat 5). / Faire cuire l \'oeuf au plat, saler, poivrer, le retourner en fin de cuisson pour donner une texture onctueuse au jaune. / Dès que l\'oeuf est retourné, mettre le bacon à griller rapidement dans une poêle bien chaude. / Sortir le muffin, confectionner le sandwich en mettant une tranche de bacon, le fromage, l\'oeuf, puis la dernière tranche de bacon.', '5', '1');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Cookies au chocolat blanc', '1', '35', '/ Préchauffez le four thermostat 6 (180°C). / Découpez une feuille de papier de cuisson de la taille de la plaque à pâtisserie du four. / A l\'aide d\'un grand couteau, concassez le chocolat pour obtenir des petits morceaux et mettez-les au réfrigérateur. / Tamisez ensemble la farine et la levure chimique au-dessus du saladier. Ajoutez le beurre coupé en très petits morceaux, travaillez rapidement du bout des doigts, comme pour une pâte sablée, jusqu\'à obtenir un mélange d\'aspect sablonneux. / Ajoutez la cassonade, le sucre vanillé, les œufs entiers, la noix de coco et le chocolat blanc. / Mélangez cette préparation à l\'aide d\'une fourchette puis malaxez avec les doigts pour obtenir une pâte souple. / Façonnez des billes de la taille d\'une noix, déposez-les au fur et à mesure sur la feuille de papier de cuisson, en prenant soin de les espacer les unes des autres de quelques centimètres. / Enfournez et laissez cuire pendant 12 à 15 min. / Laissez refroidir les cookies sur une grille avant de les déguster.', '4', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Soupe chinoise au poulet', '1', '65', '/ Faites chauffer l\'huile dans une cocotte ou un wok et faites-y revenir le poulet avec l\'ail, l\'oignon, le gingembre et les légumes, et faites revenir quelques minutes. Ajoutez le bouillon et laissez cuire de 12 à 15 min. / Délayez la maïzena avec du bouillon et versez-la dans le plat. Ajoutez les nouilles et les champignons préalablement réhydratés. Assaisonner à votre goût avec le piment, la sauce soja et le vinaigre et laissez cuire quelques minutes. C\'est prêt !', '4.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Mousse banane et kiwi', '1', '5', '/ Mixer les bananes avec la crème fraîche. / Battre les blancs en neige et les incorporer à la préparation. / Peler les kiwis et les couper en rondelles, puis chaque rondelle en 4 morceaux. / Remplir les verres avec la mousse, puis ajouter les kiwis. / Décorer avec la feuille de menthe. / Vous pouvez varier en remplaçant les kiwi par des fruits rouges ou autres, suivant ce que vous avez dans votre frigo (framboises, fraises, etc.).', '4.5', '3');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Soupe Pho', '1', '27', '/ Lavez, séchez,ciselez la ciboulette et la coriandre, émincez le piment, coupez le citron vert en 4 dans le sens de la longueur et mettez-les en attente dans des coupelles. / Portez à ébullition, le bouillon de boeuf, ajoutez-y l\'étoile de badiane, et le morceau de gingembre pelé et émincé. Couvrez et laissez cuire doucement pendant 12 min. / Détaillez le boeuf en fine lamelles, aites cuire les nouilles de riz dans de l\'eau bouillante salée, respectez les indications sur le paquet. / Dans 4 grands bols versez 1 cuillerée à soupe de sauce Nuoc-mâm, egouttezles nouilles de riz,répartissez-les dans les bols, posez les lamelles de boeuf, et versez le bouillon de boeuf brûlant, parsemez de ciboulette et de corinadre. Servez aussitôt. / Chacun ajoutera à son goût, citron vert,et piment. Bon appétit', '4.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Empanadas au tofu', '1', '100', '/ / Préparer la pâte : mélanger la farine, le sel et l \'huile d \'olive jusqu\'à obtention mélange sableux. / Ajouter graduellement de l\'eau (environ 20 cl) jusqu\'à pouvoir former une boule lisse. Laisser reposer. / Préparer la farce : émincer l\'ail et l\'oignon, puis les faire revenir avec le piment, puis ajouter tofu et remuer 5 min. / Ajouter tomate et courgette, sel, poivre, curry (préférez du curry de madras ou du curry doux, pour résultat plus relevé forcez le piment). / Laisser cuire 5 min, les courgettes doivent rester croquantes. Retirez du feu, ajouter coriandre hachée, laisser bien refroidir. / Là, ça se complique... :) Pour former des ronds de pâte de 8cm de diamètre, abaisser des petites quantités de pâte pour former des ronds approximativement de la bonne grandeur, puis découper la forme exacte avec un emporte-pièce ou simplement avec un récipient du bon diamètre et un couteau. / Répartir la farce dans chaque rond en laissant suffisamment de bords pour pouvoir refermer en pliant en 2. Bien presser les bords ensemble, petits trous à la fourchette sur le dessus. / Cuire à four chaud (180 à 200°C) pour éviter que le dessous soit tout mou... 10 min pile, 15 min face, 10 à 15 min dernier tour en badigeonnant légèrement le dessus à l\'oeuf. Voilà, faut avoir le temps, pour végétariens patients... Version viande hachée délicieuse aussi cela dit!', '3', '1');
INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Risotto de quinoa', '1', '35', '/ Faire revenir le poivron et la courgette. / Verser le quinoa préalablement rincé. / Verser l\'eau. / Verser le curry, le sel et le poivre. / Remuer. / Faire cuire 15 min. / Ajouter le lait de coco à la fin./ C\'est prêt lorsqu\'on voit les germes du quinoa.', '4.5', '2');

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Smoothie végétalien', '1', '10', '/ Mixer dans un blender les épinards et les brocoli avec un peu d\'eau, puis ajouter les flocons d \'avoine, le beurre de cacahuètes, les baie de goji, la banane. / Ajouter quelques fruits rouges surgelés et plus ou moins d\'eau en fonctions de vos envies.', '4', '3');


INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Riz', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poulet', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chorizo', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Lardon fumé', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oignon', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ail', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon de poule', 'Bouillon');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sel', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Piment de cayenne', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Céleri', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poivron rouge', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('laurier', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Thym', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauge', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile d\'olive', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Coulis de tomate', 'Sauce');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chair de tomate', 'Fruit');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tomate', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vin Blanc', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouquet garni', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poivre', 'Condiment');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Moutarde', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Miel liquide', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Curry', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cumin', 'Condiment');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Echalote', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Carotte', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pomme', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Beurre', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Crème fraiche', 'Laitier');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Avocat', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Truite', 'Poisson');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage frais', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Citron', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage ail et fine herbes', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ciboulette', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pot d\'oeuf de truite', 'Poisson');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Lait', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Levure chimique', 'Epicerie Sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Yaourt nature', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre', 'Epicerie Sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine', 'Epicerie Sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oeuf', 'Frais');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Boeuf', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauce terryiaki', 'Sauce');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cheddar', 'Fromage');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Navet', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pâte Feuilletée', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jambon de Parme', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vinaigre', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jus d orange', 'Jus');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Aneth', 'Herbe');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tagliatelles', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mascarpone', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Petit Pois', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Parmesan', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pommes de terre', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Eau', 'Eau');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de friture', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Flocons d avoine', 'Céréale');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mascarpone', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Levure', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre vanillé', 'Sucre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chocolat', 'Sucre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre roux', 'Sucre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Margarine', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Herbes de Provence', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vin Rouge', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon', 'Bouillon');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pain de campagne', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jambon', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Gruyère râpé', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mozzarella', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage de chèvre', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Origan', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mont d or', 'Laitier');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Champignons', 'Champignon');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Salade', 'Salade');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Noix', 'Noix');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pêche', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('concombre', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Escalope de poulet', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de noix', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vinaigre balsamique', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine fleur de Maïs', 'Epicerie sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre semoule', 'Sucre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Eau de fleurs d oranger', 'Eau');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Raisins secs', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pistaches', 'Noix');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Menthe', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Moutarde', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Panure', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ananas', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Crevettes roses', 'Poisson');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Maïs', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cébettes', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oignon rouge', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauce soja', 'Sauce');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de sésame', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Gingembre moulu', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Coriandre', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Piment', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Banane', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Rhum', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Aubergine', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chair à saucisse', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Persil', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Basilic', 'Herbe');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jarret de veau', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile', 'Huile');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tomates concacassées', 'Fruit');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cerfeuil', 'Herbe');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cuisse de poulet', 'Viande');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pain d épice', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bière brune (type pelfort)', 'Condiment');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine de blé noir', 'Epicerie sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine de froment', 'Epicerie sucré');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bagel', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Saumon fumé', 'Poisson');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jus de citron', 'Jus');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon cube', 'Bouillon');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pain complet', 'Féculent');


INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Muffin Blanc', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bacon', 'Viande');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chocolat Blanc', 'Sucre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Noix de Coco en poudre', 'Epicerie sucré');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre Cassonade', 'Sucre');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Soja', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('gingembre en poudre', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Nouilles Chinoise', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Champignon noir', 'Champignon');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Blanc d\'oeuf', 'Frais');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Kiwi', 'Fruit');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Citron vert', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Gingembre', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Petit piment vert', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ciboulette Thaï', 'Herbe');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pâte de riz', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon de pot au feu', 'Bouillon');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Badiane', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauce Nuoc mam', 'Sauce');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine Bise', 'Condiment');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tofu', 'Soja');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Courgette', 'Légume');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Quinoa', 'Féculent');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Lait de coco', 'Jus');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Epinard', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Brocolis', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Beurre de cacahuètes', 'Beurre');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Baies de goji', 'Fruit');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fruit rouge', 'Fruit');






INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('58.5', 'g', '1', '1');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('58.5', 'g', '1', '2');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('33.5', 'g', '1', '3');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('33.5', 'g', '1', '4');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '1', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'gousse', '1', '6');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('17', 'g', '1', '16');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '1', '17');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'cl', '1', '7');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '1', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'cuillère à café', '1', '9');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'céleri', '1', '10');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '1', '11');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'Feuille', '1', '12');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '1', '13');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '1', '14');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cl', '1', '15');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '2', '2');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'kg', '2', '18');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '2', '11');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '2', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'gousse', '2', '6');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3.5', 'cl', '2', '19');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '2', '20');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '2', '15');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '2', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '2', '21');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'blanc', '3', '2');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'verre', '3', '15');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '22');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '3', '21');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '3', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '23');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '24');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '3', '25');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1.5', 'escalope', '4', '2');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'gousse', '4', '6');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '4', '26');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '24');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '27');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '4', '18');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '4', '28');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '4', '29');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'cube', '4', '30');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '31');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '5', '32');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'tranche', '5', '33');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '5', '34');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'NULL', '5', '35');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'g', '5', '36');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'brin', '5', '37');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '5', '38');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '6', '32');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'NULL', '6', '35');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '39');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '27');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '15');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'paquet', '7', '40');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'pot', '7', '41');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'pot', '7', '15');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'pot', '7', '42');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pot', '7', '43');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '7', '44');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'zeste', '7', '35');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranches', '8', '45');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranches', '8', '47');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à soupe', '8', '46');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'pincée', '8', '8');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '9', '48'); -- 200g de navet
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '9', '49'); -- 1 pate feuilleté
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'bouquet', '9', '113'); -- 1 bouquet de cerfeuil
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'cl', '9', '19'); -- 5 cl bin blanc
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '9', '50'); -- 1 tranche jambon de parme
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.3', 'cuillère a soupe', '9', '51'); -- 1 CAS cuillère a soupe de vinaigre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.3', 'cuillère à soupe', '9', '52'); -- 1 CAS de jus d'orange
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('8.5', 'g', '9', '42'); -- 8.5g de sucre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('30', 'g', '9', '26'); -- 30 gramme de beurre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '9', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '9', '8'); -- 1 pincée de sel

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '18'); -- 1 tomate
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '44'); -- 1 Oeuf
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '10', '27'); -- 1 cuillere a café de creme fraiche
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '53'); -- 1 branche d'aneth
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '10', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '10', '21'); -- 1 pincée de poivre

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '11', '54'); -- 75g tagliatelles
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('31.5', 'g', '11', '55'); -- 31.5g de mascarpone
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '11', '56'); -- 75g de petits pois frais
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '11', '5'); -- 1/4 oignon 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '11', '6'); -- 1/4 gousse ail
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('10', 'g', '11', '57'); -- 10g parmesan
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '11', '15'); -- 1 cuillère a café huilde d'olive
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '11', '21'); -- 1 pincée de poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '11', '8'); -- 1 pincée de sel

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('130', 'g', '12', '58'); -- 130g de pommes de terre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('31.5', 'g', '12', '23'); -- 31.5g de farine
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('19', 'g', '12', '26'); -- 19g de beurre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '12', '59'); -- 25g d'eau
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '12', '44'); -- 1 oeuf
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '12', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '12', '60'); -- 1 huile de friture

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '13', '61'); -- 120g flcons d avoine
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('240', 'g', '13', '23'); -- 31.5g de farine
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'NULL', '13', '44'); -- 2 oeufs
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'sachet', '13', '63'); -- 1 sachet de levure 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'sachet', '13', '64'); -- 1 sachet de sucre vanillé
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '13', '65'); -- 120g de chocolat
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '13', '66'); -- 150g sucre roux
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '13', '26'); -- 75g de beurre 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '13', '67'); -- 75g de margarine

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '14', '45'); -- 150g de boeuf
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '14', '24'); -- 150 g de carottes
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '14', '4'); -- 50 g de lardon fumé
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '14', '5'); -- 1/2 oignon 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '14', '6'); -- 1/2 gousse d'ail
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '14', '21'); -- 1 pincée de poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '14', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '14', '68'); -- Herbe de provence
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '14', '15'); -- Huile d'olive
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'mL', '14', '69'); -- 3/20 vin rouge
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'mL', '14', '70'); -- 3/20 bouillon

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '15', '71'); -- 1 tranche de pain de campagne
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '15', '72'); -- 1 tranche de jambon cuit ou speck (type jambon cru)
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '15', '18'); -- 1/2 tomate
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '73'); -- Gruyère râpé
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '74'); -- Mozzarella
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '15', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '15', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '76'); -- Origan
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '15', '15'); -- Huile d'olive

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1.8', 'kg', '16', '2'); -- 1/5 poulet (au moins 1,8 kg)
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '16', '77'); -- 1/5 mont d'or
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '16', '78'); -- 50 g de champignons surgelés (mélange forestier, cèpes, girolles...)

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '17', '79'); -- 1/4 salade (type feuille de chêne rouge
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'poignée', '17', '80'); -- 1/4 poignée de noix (ou de pignons)
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '17', '81'); -- 1 pêche fraîches (ou au sirop)
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '17', '82'); -- 1/4 concombre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '17', '83'); -- 1 escalope de poulet
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '17', '84'); -- 1/4 cuillère à soupe d'huile de noix
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '17', '85'); -- 1/2 cuillère à soupe de vinaigre balsamique
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '17', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '17', '8'); -- 1 pincée de sel

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'cl', '18', '39'); -- 50cl lait
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '86'); -- 50g farine fleur de mais
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('125', 'g', '18', '87'); -- 125g sucre semoule
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '18', '88'); -- 1 CAS fleur d'oranger
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '89'); -- 50g raisins secs
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '90'); -- 50g pistache

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '19', '83'); -- 1 tranche d'escalope de poulet
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '19', '35'); -- 1/4 citron
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'feuille', '19', '91'); -- 1 feuille de menthe
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '19', '92'); -- Moutarde
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '19', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '19', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'jaune', '19', '44'); -- 1 jaune d'oeuf
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'cuillère à soupe', '19', '93'); -- 1 CAS de panure
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '19', '41'); -- 1/4 Yaourt nature

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '94'); -- 1/4 ananas
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '20', '1'); -- 100g de riz
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'NULL', '20', '95'); -- 3 crevettes roses crues
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '20', '96'); -- 25g de maïs 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '20', '97'); -- 0.5 Cébette
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '98'); -- 1/4 oigon rouge
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '20', '6'); -- 0.5 gousse ail
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '20', '99'); -- 1 CAS de sauce soja
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '20', '100'); -- 1 cas huile de sesame
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à café', '20', '101'); -- 3/20 cuillère de gingembre moulu
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'bouquet', '20', '102'); -- 1/4 bouquet coriandre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '103'); -- 1/4 piment

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '21', '104'); -- 1 banane 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'sachet', '21', '64'); -- 1/2 sachet de sucre vanillé
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'verre', '21', '105'); -- 1/2 verre de rhum
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'noisette', '21', '26'); -- 1 noisette de beurre

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '106'); -- 1/2 aubergine
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '5'); -- 1 oignon
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '18'); -- 1/2 tomate
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '44'); -- 1 oeuf 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '22', '107'); -- 50g de chair à saucisse
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '22', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '22', '8'); -- 1 pincée de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '108'); -- 1 persil
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '6'); -- 1 ail
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '109'); -- basilic
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '22', '15'); -- 1 CAS de huile d'olive
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'g', '22', '73'); -- 12.5g de gruyere rapé

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '23', '110'); -- 200g de veau
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2.5', 'cl', '23', '111'); -- 2.5cl huile
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '23', '6'); -- 1 ail
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '23', '112'); -- 100 g de tomates concassés
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '23', '24'); -- 50g de carottes
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '23', '5'); -- 25g d'oignon
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'cl', '23', '19'); -- 5cl de vin blanc
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '23', '20'); -- 1 bouquet garni
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '23', '21'); -- Poivre
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '23', '8'); -- 1 pincée de sel

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '24', '114'); -- 1 cuisse de poulet avec la peau
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '24', '19'); -- 50 g de lardons fumés
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '24', '5'); -- 1/2 oignons
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'tranche', '24', '115'); -- 1/2 tranche de pain d'épices
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'bouteille', '24', '116'); -- 1/4 bouteille de bière brune
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '24', '21'); -- poivre du moulin

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('17', 'g', '25', '117'); -- 17g de farine de blé noir
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'g', '25', '118'); -- 5g de farine de froment
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.1', 'cuillère à soupe', '25', '5'); -- 1/10 cuillère à soupe de huile
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.1', 'cuillère à café', '25', '115'); -- 1/10 cuillère a café de sel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.05', 'l', '25', '59'); -- 1/20 eau
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'tranche', '25', '72'); -- 1/2 tranche de jambon
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'NULL', '25', '44'); -- 2 oeuf
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('10', 'g', '25', '73'); -- 10g de gruyere

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '26', '119'); -- 1 bagel
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranche', '26', '120'); -- 2 tranches saumon fumé
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '26', '36'); -- Fromage frais
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'filet', '26', '121'); -- 1/2 filet de jus de citron
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '26', '53'); -- Aneth

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('130', 'g', '27', '56'); -- velouté glacé aux petit pois
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '27', '41'); --
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '27', '91'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '27', '122'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '27', '53'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '27', '8'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '27', '21'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'tranche', '27', '123'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '27', '75');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '28', '124'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '28', '44'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranche', '28', '125');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '28', '47');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'plaque', '29', '126'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '29', '26'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '29', '1'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '29', '127');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '29', '128'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'sachet', '29', '64'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('62.5', 'g', '29', '23');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'sachet', '29', '40');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '30', '83'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'cuillère à soupe', '30', '111'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'NULL', '30', '6'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'NULL', '30', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'NULL', '30', '24'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('33.5', 'g', '30', '129'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('20', 'cl', '30', '7');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'cuillère à soupe', '30', '23');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'cuillère à soupe', '30', '103'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'cuillère à café', '30', '130'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'cuillère à soupe', '30', '99'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'cuillère à soupe', '30', '51');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('42', 'g', '30', '131'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '30', '132'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '30', '21');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '30', '8');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '31', '104'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2.5', 'g', '31', '27'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '31', '133');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '31', '8'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '31', '42'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '31', '134');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'feuille', '31', '91');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '32', '45');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '32', '135');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'morceau', '32', '136'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '32', '137'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'petit bouquet', '32', '102'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'petit bouquet', '32', '138');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '32', '139'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('37.5', 'cl', '32', '140'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'étoile', '32', '141');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '32', '142');


INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '33', '143');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '33', '15');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '33', '8'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '33', '144'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '33', '145'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '33', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '33', '6'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '33', '103'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '33', '18');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'Cuillère à soupe', '33', '30');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'g', '33', '102');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '34', '11'); 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '34', '145'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'verre', '34', '146');--
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '34', '30');  
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '34', '8'); 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '34', '21');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'verre', '34', '59');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'cl', '34', '147');--


INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'poignées', '35', '148'); 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'bouquets', '35', '149'); -- 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '35', '104');--
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '35', '61');  
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '35', '150'); 
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('10', 'NULL', '35', '151');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '35', '59');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '35', '152');--


INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Cooper', 'Travis', '0', '1', '0', 'CooperTravis@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Bobo', 'marc', '1', '0', '0', 'marctheBobo@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Boby', 'Patrick', '1', '1', '0', 'BobyandPatrick@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Boukbouk', 'Remrem', '0', '1', '0', 'remi.boukeloua@efrei.net');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'huang', 'Claire', '0', '0', '0', 'claire.huang@efrei.net');

-- nouvel ajout

INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Pierre', 'Jean', '1', '0', '0', 'Jeanbon@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Chang', 'Simon', '0', '0', '0', 'simon.chang@efrei.net');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Boumassa', 'Abdel', '0', '1', '0', 'Abdou@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Racine', 'Jean', '0', '0', '1', 'Lalecture@gmail.com');
INSERT INTO `id5862521_cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Tran', 'Vinh', '1', '0', '0', 'kinhvinh.tran@efrei.net');

-- fin ajout


INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('1', 'A ne jamais refaire', '2018-02-10', '5', '5');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'n\'a pas assez de goûts', '2018-02-8', '6', '4');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('3', 'Pas mal', '2018-02-7', '20', '3');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('4', 'Une tuerie', '2018-02-17', '19', '2');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent, je recommande', '2018-02-15', '13', '1');

INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Super', '2018-02-10', '16', '5');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('4', 'A tester au moins une fois', '2018-02-8', '4', '5');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('3', 'très bon', '2018-02-7', '20', '5');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('4', 'Une tuerie', '2018-02-17', '19', '5');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent, je recommande', '2018-02-15', '13', '5');

INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Super', '2018-02-10', '16', '9');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent,', '2018-02-8', '16', '10');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'très bon', '2018-02-7', '16', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent', '2018-02-17', '16', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent, je recommande', '2018-02-15', '16', '8');



INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'Aucune qualité', '2018-05-10', '35', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'Une vrai calamité culinaire', '2018-02-8', '34', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'A revoir, aucune valeur nutritionnelle', '2018-03-7', '33', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'délice insuffisant', '2017-02-17', '32', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'affreux repas', '2018-02-15', '4', '7');

INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Succulent', '2018-02-10', '35', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Un vrai repas gastronomique', '2018-02-8', '31', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'hmmm, miam', '2018-02-7', '30', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Rafiné', '2018-02-17', '29', '6');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'un vrai restaurant 5 étoiles', '2018-02-15', '17', '7');


-- fin nouvel ajout
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Gluten');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Crustacé');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Oeuf');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Poisson');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Arachide');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Soja');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Lait');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Fruit à coques');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Céleri');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Moutarde');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Graines de sésame');
INSERT INTO `id5862521_cook_book`.`allergene` (`nom_allerg`) VALUES ('Mollusque');

INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '23');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '43');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '86');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '71');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '49');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '99');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '61');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('3', '44');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('2', '95');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('4', '33');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('4', '38');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '90');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '80');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '84');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '89');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('6', '99');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '26');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '27');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '34');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '36');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '39');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '41');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '55');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '57');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '62');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '73');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '74');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '75');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '77');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('9', '10');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('10', '23');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('10', '92');
INSERT INTO `id5862521_cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('11', '100');

INSERT INTO `id5862521_cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('2', '1');
INSERT INTO `id5862521_cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('3', '2');
INSERT INTO `id5862521_cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('4', '3');
INSERT INTO `id5862521_cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('8', '4');
INSERT INTO `id5862521_cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('6', '5');


ALTER TABLE `id5862521_cook_book`.`recette` 
ADD COLUMN `date` DATE NULL DEFAULT NULL AFTER `ID_cat`;

UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-02-01' WHERE `ID_recette`='1';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-02-06' WHERE `ID_recette`='2';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-01' WHERE `ID_recette`='3';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-02-12' WHERE `ID_recette`='4';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='5';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='6';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='7';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='8';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='9';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='10';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='11';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='12';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='13';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-08' WHERE `ID_recette`='14';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='15';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='16';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='17';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='18';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='19';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='20';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='21';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='22';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='23';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='24';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='25';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='26';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='27';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='28';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='29';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='30';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='30';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='31';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='32';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='33';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='34';
UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='35';
-- UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='36';
-- UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-19' WHERE `ID_recette`='37';
-- UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='38';
-- UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='39';
-- UPDATE `id5862521_cook_book`.`recette` SET `date`='2018-04-20' WHERE `ID_recette`='40';



UPDATE `id5862521_cook_book`.`recette` SET `instruction`='/ Le velouté: Faire cuire pendant 15 min les petits pois dans l\'eau bouillante avec le bouillon cube. / Egoutter les petits pois et garder un peu de bouillon.Le mettre au frigo / Passer les petits pois dans l\'eau glacé pour conserver leur couleur. / Mixer les petits pois avec les yaourts, la menthe, l\'ail et le bouillon refroidi. / Passer au chinois ou à la passoire fine et garder la \"purée de petit pois\" / Assaisoner à votre goût et mettre au frigo. / Pour les mouillettes:  Tartiner le pain avec la purée de petit pois puis mettre le chèvre coupé en tranche dessus. / Passer au four le temps de faire fondre le chèvre.Couper les tranches de pains en petits tronçons.' WHERE `ID_recette`='27';

INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Tomates farcies végan', '4', '80', ' Etape 1 Vider les tomates, saler l’intérieur et les laisser dégorger à l\'envers dans un plat pendant la préparation de la farce. Réserver la pulpe et le jus pour après. Etape 2 Porter à ébullition un litre d\'eau salée y incorporer les protéines de soja texturé et la branche de céleri émincée. Laisser mijoter 1/4 d\'heure à feu doux. Etape 3 Faire revenir dans l\'huile d\'olive l\'oignon émincé et les champignons jusqu\'à ce qu\'ils blondissent. Saler, poivrer. Etape 4 Égoutter les protéines de soja et le céleri, ajouter l\'oignon et les champignons, les herbes finement ciselées, les épices, sel poivre. Etape 5 Dans une casserole, faire mijoter 10 min à feu doux la pulpe et le jus des tomates avec un morceau de sucre pour casser l\'acidité. Couper les gros morceaux. Etape 6 Préchauffer le four à 180°C. Farcir les tomates avec ce mélange. Etape 7 Verser la sauce tomate dans le plat et sur la farce. 20 min au four à 180°C. ', '2', '1', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Girolle', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Piment d\'espelette', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Paprika', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Muscade', 'Epice');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'NULL', '36', '18');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '36', '153');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '36', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'branche', '36', '10');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'feuilles', '36', '109');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café de', '36', '154');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café de', '36', '155');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café de', '36', '156');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'morceau de', '36', '42');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '36', '15');




INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Tarte à la pomme', '8', '120', 'Etape 1 Préparation de la compote de pommes Etape 2 Tout d\'abord, commencez par préparer la compote de pommes. Pour cela, épluchez 4 pommes puis découpez-les en petits morceaux. Mettez les pommes dans une casserole et ajoutez de l\'eau (environ 10 cl). Etape 3 Laissez la casserole à feu doux afin de ramollir les pommes. Surveillez que les pommes n\'accrochent pas à fond de la casserole, sinon ajoutez un peu d\'eau. Quand les pommes sont réduites en compote (elles doivent être très molles et former un mélange plus-ou-moins homogène), ajoutez le sucre, mélangez puis laissez refroidir. La réalisation de la compote de pommes est relativement longue au niveau de la cuisson : pour gagner du temps, vous pouvez utiliser une compote déjà prête. Etape 4 Préparation de la pâte Etape 5 Pendant que la compote cuit, vous pouvez déjà préparer la pâte à tarte. Etape 6 Mélangez la farine, l\'huile et l\'eau dans un saladier. Ajoutez le sirop d\'agave pour donner un goût plus sucré. Mélangez le tout jusqu\'à obtenir une boule de pâte homogène. Vous pouvez ajuster les doses (farine ou eau) pour obtenir la bonne texture. Etape 7 Étalez la pâte avec un rouleau à pâtisserie pour former un cercle de taille légèrement supérieure à celle de votre moule à tarte. Après avoir huilé le moule, positionnez-y le cercle de pâte. A l\'aide d\'une fourchette, faîtes des petits trous dans la pâte puis mettez-la au four pendant quelques minutes pour la préchauffer. Etape 8 Répartissez ensuite la compote de pommes de manière régulière dans le moule à tarte. Etape 9 Épluchez les deux dernières pommes et coupez-les en lamelles. Placez les lamelles en spirale sur la compote. Saupoudrez légèrement de sucre de canne. Etape 10 Mettez la tarte au four et laissez cuire une vingtaine de minutes.', '2', '3', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sirop d\'agave', 'Condiment');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('250', 'g', '37', '27');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('10', 'cl', '37', '111');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('20', 'cl', '37', '59');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'cuillère à soupe', '37', '157');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('6', 'NULL', '37', '29');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à soupe de sucre', '37', '42');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'cuillère à soupe de sucre', '37', '128');






INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Chili con carne facile', '4', '35', 'Etape 1 Préchauffer le four à 180°C (thermostat 6). Etape 2 Hacher l\'oignon et l\'ail. Etape 3 Dans une cocotte en fonte, faire fondre le beurre, et ensuite dorer doucement l\'oignon et l’ail. Etape 4 Incorporer le boeuf haché et laisser cuire doucement 10 min. Etape 5 Mélanger le chili, le cumin, le concentré de tomates, et incorporer le tout au boeuf. Ajouter les haricots, le bouillon, du sel et du poivre. Etape 6 Couvrir et cuire 25 min au four.', '2', '2', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chili poudre', 'Epice');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Concentré de tomates', 'Sauce');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Haricot rouge', 'Légume');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon de boeuf', 'Bouillon');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '38', '30');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'NULL', '38', '5');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'grousses', '38', '6');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('500', 'g', '38', '45');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '38', '158');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à café', '38', '25');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('65', 'g', '38', '159');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'boîte', '38', '160');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('30', 'cl', '38', '161');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'pincées', '38', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincées', '38', '21');




INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Pâte à pizza fine', '3', '70', 'Etape 1 Verser la farine dans un grand saladier et y faire un puits. Etape 2 Verser la levure, le sel et le sucre dans un verre doseur. Ajouter 1/4 de litre d\'eau tiède, bien mélanger. Couvrir d\'un film plastique et laisser reposer environ 10 minutes (jusqu\'à l\'apparition d\'une mousse brune bien épaisse en surface). Etape 3 Verser le mélange du verre doseur dans le saladier, mélanger à la main. Puis quand la pâte n\'est plus collante pétrir environ 5 minutes à la main sur une surface farinée. Etape 4 Arroser d\'un peu d\'huile d\'olive, puis pétrir à nouveau environ 5 minutes. Etape 5 Laisser reposer au moins 1 h sous un linge humide dans un endroit tiède (à côté d\'un radiateur, d\'une cheminée ou d\'un poêle en hiver). Etape 6 Après repos, pétrir quelques instants puis diviser la pâte en trois boules égales (on peut en congeler). Etape 7 Etaler la pâte sur une surface farinée. Badigeonner la plaque d\'un peu d\'huile d\'olive avant d\'y appliquer la pâte. Etape 8 Cuisson 10 minutes à 220°C (thermostat 7-8).', '2', '2', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('500', 'g', '39', '27');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'sachet', '39', '40');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '39', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'l', '39', '59');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '39', '42');



INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Pavé de saumon sur son lit de poireaux', '4', '40', 'Etape 1 Couper les poireaux en rondelles (tout le blanc et un peu de vert, environ 3 centimètres), les laver et les faire fondre dans une poêle avec l\'huile, couvercle fermé, pour ne pas qu\'ils grillent (environ 15 min). Etape 2 Avant la fin de la cuisson, ajouter sel poivre et curry à sa guise. Etape 3 Disposer ensuite ces poireaux dans un plat allant au four, les recouvrir des pavés de saumon, que l\'on peut poivrer si l\'on aime, et recouvrir le tout de crème fraîche. Etape 4 Fermer le plat le plus hermétiquement possible avec un papier d\'aluminium, et mettre au four à thermostat 6-7 , pendant environ 20 min, selon la grosseur du saumon. Etape 5 Pour changer et selon les goûts, on peut enlever le curry, et à la place, saupoudrer le saumon avec de l\'aneth ciselée. Etape 6 Bon appétit!', '2', '2', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Saumon', 'Poisson');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poireaux', 'Légume');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pavés', '40', '162');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'NULL', '40', '163');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('20', 'cl', '40', '31');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'pincées', '40', '21');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'pincées', '40', '8');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à soupe', '40', '15');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à café', '40', '24');


INSERT INTO `id5862521_cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`, `date`) VALUES ('Soupe de courgettes à la vache qui rit', '4', '45', 'Etape 1 Mettre à chauffer l\'eau, les cubes de bouillon, la vache qui rit, l\'ail écrasé, les courgettes coupées en morceaux avec la peau; sel et poivre. Etape 2 Laisser cuire environ 40 min (quand la courgette est tendre). Etape 3 Mixer le tout, et déguster!', '2', '1', '2018-05-23');

INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vache qui rit', 'Fromage');
INSERT INTO `id5862521_cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon légumes et épices', 'Bouillon');

INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('700', 'g', '41', '145');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'portions', '41', '164');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cubes', '41', '165');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'gousses', '41', '6');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'l', '41', '59');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'pincées', '41', '21');
INSERT INTO `id5862521_cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'pincées', '41', '8');

INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Un poulet d\'un gout surprenant', '2018-05-23', '1', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'PouletBamba, j\'ai adoré', '2018-05-23', '2', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'C\'est comme dans mon pays', '2018-05-23', '3', '7');
INSERT INTO `id5862521_cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'Un poulet à l\'image de la gastronomie française', '2018-05-23', '19', '7');
