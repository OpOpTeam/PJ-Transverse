DROP DATABASE IF EXISTS cook_book;

create database cook_book;
use cook_book;

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

INSERT INTO `cook_book`.`categorie` (`nom_cat`) VALUES ('Entrée');
INSERT INTO `cook_book`.`categorie` (`nom_cat`) VALUES ('Plat');
INSERT INTO `cook_book`.`categorie` (`nom_cat`) VALUES ('Dessert');


INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Jambalaya Poulet', '1', '65', 'Etape 1 Couper le poivron en deux, retirer les graines et les cloisons internes, le débiter en carrés. Etape 2 Eplucher et émincer le céleri en tronçons. Préchauffer le four à 180°C. Etape 3 Dans une grande terrine, faire revenir 5 mn le chorizo avec les lardons, dans l\'huile chaude. Remplacer par le poulet. Faire dorer sur toutes leurs faces et les retirer. Etape 4 Dans la même cocotte, faire fondre l\'oignon et l\'ail épluchés et hachés pendant 5 mn. Ajouter le poivron et le céleri et faire cuire 8 mn. en remuant. Etape 5 Ajouter ensuite le poulet, les lardons, le riz versé en pluie, le coulis et la chair de tomate concassée, le thym, la sauge, le laurier, le piment de Cayenne. Arroser du bouillon et porter à ébullition. Etape 6 Enfourner et faire cuire 40 mn. Laisser la jambalaya pendant 5 mn dans le four éteint, porte entrouverte, avant de servir.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Poulet Basquaise', '1', '80', 'Etape 1 Hacher l\'oignon et l\'ail. Couper les tomates en morceaux et détailler les poivrons en lanières. Etape 2 Faire chauffer 4 cuillères à soupe d\'huile dans une cocotte. Y faire dorer les oignons, l\'ail et les poivron. Laisser cuire 5 min. Etape 3 Ajouter les tomates à la cocotte, saler, poivrer. Couvrir et laisser mijoter 20 min. Etape 4 Dans une sauteuse, faire dorer dans l\'huile d\'olive les morceaux de poulet salés et poivrés. Etape 5 Lorsqu\'ils sont dorés, les ajouter aux légumes, couvrir, ajouter le bouquet garni et le vin blanc et c\'est parti pour 35 min de cuisson.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Brochettes de poulet express aux épices', '1', '20', 'Etape 1 Couper le poulet en cubes et les tremper dans la marinade (mélanger tous les ingrédients) puis faire 4 brochettes égales. Etape 2 Faire cuire 10 min à la poêle en versant 2 cuillères de marinade pour la cuisson, retourner plusieurs fois. Etape 3 Possibilité de saupoudrer un peu plus de curry à la cuisson. Etape 4 Augmenter légèrement le feu pour un aspect caramélisé. Etape 5 Servir avec du couscous aux épices ou une simple salade verte !', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Escalopes de poulet à l\'indienne', '1', '45', 'Etape 1 Couper les carottes, l’ail, les échalotes et la pomme, en petits dés. Etape 2 Emincer les escalopes de poulet. Etape 3 Faire dorer les émincés, dans du beurre et ajouter les dés (carottes, pomme, etc.) pour les faire revenir. Etape 4 Saupoudrer de farine et de curry, tourner. Etape 5 Ajouter un grand verre d’eau, les tomates pelées et coupées, en petits dés. Etape 6 Laisser cuire, à petit feu, pendant 20 à 30 min. Etape 7 Incorporer la crème fraîche et porter à ébullition pendant 1 min.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Verrine avocat-truite fumée', '1', '15', 'Etape 1 Ecraser la pulpe de l\'avocat dans un bol. Etape 2 Saler très peu, poivrer et citronner. Etape 3 Déposer 1/4 de la préparation dans chaque verrine. Etape 4 Mélanger le fromage frais et le fromage ail et fines herbes dans un bol avec 1 cuillère à soupe d\'eau pour fluidifier. Etape 5 Déposer dans les verrines en une seconde couche. Etape 6 Couper les tranches de saumon fumé en petits morceaux, répartir dans les verrines et mettre au frais. Etape 7 Au moment de servir, décorer de quelques oeufs de truite, brins de ciboulette, un filet de citron et un tour de moulin à poivres 5 baies. Note de l\'aute', '2.5', '1');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Crème d\'avocat', '1', '10', 'Etape 1 Dénoyautez les avocats et enlevez la peau et mettez les dans un mixer avec le jus de citron. Mélangez. Ajoutez un peu de lait , crème et huile. C\'est prêt ! Etape 2 Mettre au frais avant de servir.', '2.5', '1');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Gatêau au yaourt', '1', '45', 'Etape 1 Préchauffer le four à 180°C (thermostat 6). Mélanger tout simplement les ingrédients un à un en suivant l\'ordre suivant : levure, Etape 2 yaourt Etape 3 huile Etape 4 sucre Etape 5 farine Etape 6 oeuf et zeste Etape 7 Beurrer un moule à manquer et y verser la pâte. Etape 8 Enfourner pour environ 30 minutes de cuisson. Etape 9 Vérifier la cuisson avec la pointe d\'un couteau (elle doit ressortir sèche).', '2.5', '3');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Brochette boeuf fromage', '1', '30', 'Etape 1 Couper le fromage en bâtonnets. La longueur doit correspondre à la largeur des tranches de viande. Etape 2 Saler, poivrer la viande et la passer rapidement dans la sauce terryaiki. Etape 3 Piquer le fromage sur les piques, enrouler la viande autour. Etape 4 Cuire au barbecue ou à la poêle à feu vif.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tatin de navets confits au Parme', '1', '90', 'Etape 1 Préchauffer le four à thermostat 7 (210°C). Etape 2 Peler les navets, les faire cuire 5 mn à feu doux à couvert avec un peu de sel et de l eau à hauteur, puis les égoutter. Etape 3 Faire réduire le vin de moitié (à feu vif). Caraméliser le sucre avec une goutte d eau dans une sauteuse. Etape 4 Hors du feu, ajouter le vinaigre et le jus d orange. Remmettre sur le feu, ajouter le vin, 50 g de beurre, du sel et du poivre. Etape 5 Plonger les navets dans ce sirop, couvrir aux trois quarts, puis laisser cuire en les retournant fréquement jusqu à ce qu ils soient tendres et enrobés d une couche sirupeuse. Etape 6 Tapisser le fond de moule à tarte de papier sulfurisé beurré. Aligner les navets. poser la pâte, la piquer avec une aiguille, faire glisser les bords contre le moule. Cuire 25 mn au four. Etape 7 Faire rissoler le jambon en lanières dans 10 g de beurre. Etape 8 Laisser tiédir la tarte 5 mn, puis la retourner dans un plat. Parsemer de jambon et de brins de cerfeuil, puis servir.', '4', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tomates aux oeufs cocottes', '1', '20', 'Etape 1 Laver les tomates, couper un "chapeau", et les évider complètement. Etape 2 Enfourner les tomates salées et poivrées au four (200°C-th 6-7), pendant 3 min. Etape 3 Sortir les tomates du four. Déposer dans le fond des tomates 1 cuillère à café de crème fraîche. Etape 4 Casser les oeufs dans les tomates, remettre au four. Etape 5 Laisser cuire, jusqu à ce que le blanc des oeufs blanchisse (environ 5 min), et servir immédiatement.', '3.5', '1');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Tagliatelles au mascarpone et petits pois', '1', '35', 'Etape 1 Faites bouillir une grande casserole d eau salée. Etape 2 Mettez-y les petits pois, Laissez cuire 5 minutes puis ajoutez les tagliatelles. Laissez cuire 10 min. Etape 3 Emincez l oignon, pressez l ail. Faites-les dorer avec un peu d huile dans une poêle. Etape 4 Ajoutez le mascarpone et laissez fondre à feu doux. Etape 5 Egouttez les pâtes et les petits pois, récupérez 2-3 cuillères à soupe d eau de cuisson pour délayer la sauce. Etape 6 Mélangez les tagliatelles et petits pois à la sauce, parsemez de copeaux de parmesan et servez.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Pommes dauphines', '1', '70', 'Etape 1 Faites cuire les pommes de terre à l eau bouilante salée environ 30 minutes (selon la taille). Etape 2 Pendant ce temps, préparez la pâte à choux : portez à ébullition 10 cl d eau avec le beurre. Etape 3 Salez et versez d un coup la farine, remuez énergiquement à la cuillère en bois jusqu à ce que la pâte se détache des birds de la casserole. Etape 4 Laissez tiédir puis ajoutez les oeufs un à un, en mélangeant bien à chaque fois. Etape 5 Egouttez et pelez les pommes de terre, écrasez-les en purée fine et ajoutez-les à la pâte à choux. Salez et poivrez, puis laissez refroidir. Etape 6 Formez ensuite des petites boules de la taille d une noix avec vos mains farinées, ou utilisez une poche à douille. Etape 7 Jetez-les dans l huile de friture bien chaude par petites quantités et laissez dorer 1 min environ.', '3', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Cookies pépites aux flocons d avoine', '1', '20', 'Etape 1 Préchauffer le four à 180°C. Etape 2 Mélanger flocons, farine et sucre (vanillé et roux), puis malaxer à la main avec oeufs, levure, sucre et beurre/margarine, ajouter ensuite les pépites. Etape 3 Mettre de petites boules de pâte légèrement applaties sur une plaque à pâtisserie recouverte d une feuille de cuisson, bien espacées. Etape 4 Enfourner 10 mn environ, pas plus, ça continue de cuire après être sorti du four.', '2.5', '3');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Braisé de boeuf aux carottes', '1', '165', 'Etape 1 Faire revenir les oignons a feu vif dans l huile d olive. Etape 2 Une fois qu il sont un peu transparents, ajouter la viande de boeuf et tourner pour que toutes les faces soient prises. Etape 3 Saler (peu si vous utilisez le bouillon cube), poivrer et ajouter une bonne pincée d herbes de Provence. Mélanger. Etape 4 Ajouter le lard, puis les carottes et l ail non épluché. Verser le vin et le bouillon. Etape 5 Maintenir le feu vif jusqu a ce que ça bouillone. Etape 6 Ensuite, baisser le feu (feu très doux), puis laisser mijoter pendant 1h30 (ou plus) en vérifiant qu il reste suffisamment de liquide pour que ça n atttache pas. Sinon, rajouter un peu d eau.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Bruschetta', '1', '30', 'Etape 1 Passer les tranches de pain 5 min au four (le temps de dorer très légèrement la mie). Etape 2 Déposer sur chaque tranche de fine rondelles de tomates, une tranche de jambon. Etape 3 Puis, y déposer enfin du fromage râpé ou du chèvre ou encore de la mozzarella (suivant le goût de chacun). Terminer la tartine par un filet d huile d olive, Etape 4 un peu de poivre, et des herbes Provence. Etape 5 Et passer au grill 5 min (le temps que le fromage soit gratiné). Etape 6 Déguster.', '2.5', '1');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Poulet au Mont-d or et champignons', '1', '80', 'Etape 1 Préchauffer le four à 210°C (thermostat 7). Etape 2 Découper le poulet (voir vidéos très bien faites). Etape 3 Faire revenir les morceaux de poulet dans une poêle pour les colorer. Etape 4 Mettre les morceaux de poulet dans un plat allant au four. Etape 5 Cuire 20 minutes. Etape 6 Pendant ce temps, faire revenir les champignons dans la même poêle. Couper le feu lorsque les champignons sont décongelés. Etape 7 A la fin de la cuisson du poulet, ajouter les champignons dans le plat. Sortir le Mont-d Or de sa boite en bois, le couper en deux et le poser sur le plat. Etape 8 Remettre au four. Etape 9 Sortir lorsque le dessus commence à gratiner (environ 20 min).', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Salade d été aux pêches', '1', '25', ' Etape 1 Nettoyer la salade. Etape 2 Couper le concombre en fines lamelles. Etape 3 Couper les pêches en quartiers ou en dés. Etape 4 Cuire le poulet une dizaine de minutes à la poêle et l assaisonner de sel et poivre. Etape 5 Mélanger les ingrédients pour la vinaigrette. Mettre le tout dans un saladier, puis servir.', '2.5', '1');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Flan libanais à l eau de fleurs d oranger ', '6', '25', ' Etape 1 Prendre comme mesure un verre à eau. Etape 2 Dans une casserole mettre le lait avec le sucre et la fleur de maïs, fouettez pour bien diluer le tout et obtenir un mélange homogène, puis porter sur le feu en remuant avec une cuillère en bois sans arrêt pour que les grumeaux ne se forment pas. Etape 3 Lorsque le mélange s épaissit retirer du feu, ajouter l eau de fleurs d oranger et les raisins secs et répartir dans des ramequins de service. Etape 4 Mettre au frais pendant au moins 2 heures. Etape 5 Au moment de servir, décorer de pistaches.', '2.5', '3');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Boulettes de poulet au citron', '1', '40', ' Etape 1 Hâcher les escalopes de poulet, râper le zeste du citron et presser le citron. Etape 2 Dans un saladier, mélanger le poulet haché, un quart du zeste de citron, la moitié du jus de citron, le jaune d oeuf et la panure. Y ajouter la moutarde (2 cuillères à soupe), sel et poivre selon goût. Etape 3 Façonner ensuite des petites boulettes de la taille d une grosse noix. Etape 4 Mélanger le yaourt nature avec avec quelques feuilles de menthe préalablement ciselées très finement (j en mets 5 à 6 habituellement, vous pouvez en mettre plus si vous le souhaitez). Y ajouter environ 2 cuillères à soupe de jus de citron et une de zeste de citron. Réserver la sauce au yaourt au frais. Etape 5 Chauffer de l huile dans une poêle et y dorer les boulettes de poulet de tous côtés, jusqu à ce qu elles soient cuites à l intérieur. Etape 6 Servir avec la sauce yaourt-menthe. J accompagne souvent cette recette avec du riz et une salade. C est léger et rafraîchissant ! Bon appétit !', '3', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Riz sauté à l ananas', '1', '45', ' Etape 1 Plonger le riz dans une casserole d eau bouillante salée. Eplucher et hacher finement l ail, ciseler les cébettes. Etape 2 Ouvrir l ananas en 2 dans le sens de la longueur et en récupérer la chair. Attention à ne pas trop creuser pour ne pas percer la peau du fruit. Etape 3 Couper la chair en cubes. Etape 4 Préparer la sauce en mélangeant l huile de sésame, la sauce soja, le gingembre moulu et le piment coupé en petits morceaux. Etape 5 Dans une sauteuse, faire revenir les crevettes décortiquées avec un peu d huile de sésame. Elles doivent devenir roses. Etape 6 Retirer les crevettes de la poêle et faire revenir à la place l oignon rouge et l ail haché. Etape 7 Ajouter le maïs et l ananas et laisser revenir 5 à 7 minutes. Etape 8 Ajouter le riz et faire rissoler 3 minutes à feu vif. Etape 9 Ajouter les crevettes et faire revenir 5 minutes avant de servir bien chaud.', '2.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Bananes flambées', '1', '10', 'Etape 1 Faites chauffer une poêle, faites-y fondre le beurre et ajoutez-y les bananes coupées en long, faites dorer de chaque côté. Etape 2 Saupoudrez de sucre vanillé, versez le rhum et faites flamber : lorsqu il n y aura plus de flammes, servez !', '3.5', '3');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Aubergines farcies', '1', '55', 'Etape 1 Coupez l aubergine eu deux dans le sens de la longueur. Avec un couteau, fendez la chair de l aubergine en faisant des X (cest pour que çà cuise à l intérieur). Etape 2 Faites coulez un filez d huile d olive sur la surface, et enfournez à 250° pendant une demi heure. Etape 3 Avec une cuillère à soupe, retirez la chair des aubergines et coupez la finement. Etape 4 Faites blanchir les oignons à feu doux pendant un bon quart  heure sans les faire griller... au bout de 5 min, ajouter de la chair à saucisse si vous aimez la viande (c est très bon aussi sans…) Etape 5 Puis ajouter la tomate coupée en petits dés et l ail, en laissant à feu très doux. Etape 6 Ajoutez la chair d aubergine et assaisonner. Ajouter le persil et le basilic. Etape 7 Et aussi l oeuf battu. Etape 8 Mélangez bien le tout et remplissez les demi-aubergines. recouvrez de gruyère râpé. Etape 9 Replacez au four pendant 5 à 10 mn dans le four encore chaud. Etape 10 Faites refroidir un peu, c est bon chaud ou froid.', '3.5', '2');

INSERT INTO `cook_book`.`recette` (`nom_recette`, `nb_pers`, `temps_min`, `instruction`, `note`, `ID_cat`) VALUES ('Osso bucco de veau', '1', '65', 'Etape 1 Fariner la viande, tapoter pour retirer l excédent. Les faire dorer sur toutes les faces dans une cocotte-minute avec un fond d huile. Etape 2 Peler et couper les carottes en rondelles épaisses, émincer les oignons, hacher l ail. Les ajouter dans la cocotte, ainsi que les tomates et le vin blanc. Saler, poivrer, ajouter le bouquet garni et fermer la cocotte. Etape 3 Laisser cuire 45 min à partir de la mise en rotation de la soupape, à feu doux.', '4', '2');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Riz', 'Féculent');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poulet', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chorizo', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Lardon fumé', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oignon', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ail', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon de poule', 'Bouillon');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sel', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Piment de cayenne', 'Epice');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Céleri', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poivron rouge', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('laurier', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Thym', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauge', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile d\'olive', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Coulis de tomate', 'Sauce');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chair de tomate', 'Fruit');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tomate', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vin Blanc', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouquet garni', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Poivre', 'Condiment');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Echalote', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Carotte', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pomme', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Beurre', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Crème fraiche', 'Laitier');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Moutarde', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Miel liquide', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Curry', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cumin', 'Condiment');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Avocat', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Truite', 'Poisson');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage frais', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Citron', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage ail et fine herbes', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ciboulette', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pot d\'oeuf de truite', 'Poisson');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Lait', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Levure chimique', 'Epicerie Sucré');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Yaourt nature', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre', 'Epicerie Sucré');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine', 'Epicerie Sucré');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oeuf', 'Frais');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Boeuf', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauce terryiaki', 'Sauce');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cheddar', 'Fromage');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Navet', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pâte Feuilletée', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jambon de Parme', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vinaigre', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jus d orange', 'Jus');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Aneth', 'Herbe');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tagliatelles', 'Féculent');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mascarpone', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Petit Pois', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Parmesan', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pommes de terre', 'Féculent');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Eau', 'Eau');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de friture', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Flocons d avoine', 'Céréale');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mascarpone', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Levure', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre vanillé', 'Sucre');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chocolat', 'Sucre');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre roux', 'Sucre');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Margarine', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Herbes de Provence', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vin Rouge', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Bouillon', 'Bouillon');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pain de campagne', 'Féculent');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jambon', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Gruyère râpé', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mozzarella', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Fromage de chèvre', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Origan', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Mont d or', 'Laitier');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Champignons', 'Champignon');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Salade', 'Salade');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Noix', 'Noix');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pêche', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('concombre', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Escalope de poulet', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de noix', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Vinaigre balsamique', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Farine fleur de Maïs', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sucre semoule', 'Sucre');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Eau de fleurs d oranger', 'Eau');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Raisins secs', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Pistaches', 'Noix');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Menthe', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Moutarde', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Panure', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Ananas', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Crevettes roses', 'Poisson');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Maïs', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cébettes', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Oignon rouge', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Sauce soja', 'Sauce');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile de sésame', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Gingembre moulu', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Coriandre', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Piment', 'Epice');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Banane', 'Fruit');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Rhum', 'Condiment');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Aubergine', 'Légume');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Chair à saucisse', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Persil', 'Herbe');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Basilic', 'Herbe');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Jarret de veau', 'Viande');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Huile', 'Huile');
INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Tomates concacassées', 'Fruit');

INSERT INTO `cook_book`.`ingredient` (`nom_ingr`, `type`) VALUES ('Cerfeuil', 'Herbe');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('58.5', 'g', '1', '1');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('58.5', 'g', '1', '2');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('33.5', 'g', '1', '3');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('33.5', 'g', '1', '4');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '1', '5');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'gousse', '1', '6');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('17', 'g', '1', '16');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '1', '17');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'cl', '1', '7');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '1', '8');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'cuillère à café', '1', '9');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.35', 'céleri', '1', '10');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '1', '11');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'Feuille', '1', '12');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '1', '13');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '1', '14');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cl', '1', '15');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '2', '2');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'kg', '2', '18');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '2', '11');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '2', '5');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'gousse', '2', '6');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3.5', 'cl', '2', '19');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '2', '20');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '2', '15');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '2', '8');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '2', '21');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'blanc', '3', '2');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'verre', '3', '15');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '22');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '3', '21');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('4', 'pincée', '3', '8');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '23');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '3', '24');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '3', '25');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1.5', 'escalope', '4', '2');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'gousse', '4', '6');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '4', '26');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '24');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '27');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '4', '18');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '4', '28');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '4', '29');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'cube', '4', '30');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '4', '31');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '5', '32');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'tranche', '5', '33');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '5', '34');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'NULL', '5', '35');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'g', '5', '36');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'brin', '5', '37');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '5', '38');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '6', '32');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'NULL', '6', '35');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '39');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '27');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '6', '15');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'paquet', '7', '40');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'pot', '7', '41');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.15', 'pot', '7', '15');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'pot', '7', '42');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pot', '7', '43');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '7', '44');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'zeste', '7', '35');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranches', '8', '45');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'tranches', '8', '47');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à soupe', '8', '46');
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'pincée', '8', '8');

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '9', '48'); -- 200g de navet
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '9', '49'); -- 1 pate feuilleté
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'bouquet', '9', '113'); -- 1 bouquet de cerfeuil
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'cl', '9', '19'); -- 5 cl bin blanc
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '9', '50'); -- 1 tranche jambon de parme
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.3', 'cuillère a soupe', '9', '51'); -- 1 CAS cuillère a soupe de vinaigre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.3', 'cuillère à soupe', '9', '52'); -- 1 CAS de jus d'orange
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('8.5', 'g', '9', '42'); -- 8.5g de sucre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('30', 'g', '9', '26'); -- 30 gramme de beurre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '9', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '9', '8'); -- 1 pincée de sel

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '18'); -- 1 tomate
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '44'); -- 1 Oeuf
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '10', '27'); -- 1 cuillere a café de creme fraiche
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '10', '53'); -- 1 branche d'aneth
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '10', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '10', '21'); -- 1 pincée de poivre

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '11', '54'); -- 75g tagliatelles
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('31.5', 'g', '11', '55'); -- 31.5g de mascarpone
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '11', '56'); -- 75g de petits pois frais
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '11', '5'); -- 1/4 oignon 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '11', '6'); -- 1/4 gousse ail
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('10', 'g', '11', '57'); -- 10g parmesan
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '11', '15'); -- 1 cuillère a café huilde d'olive
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '11', '21'); -- 1 pincée de poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '11', '8'); -- 1 pincée de sel

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('130', 'g', '12', '58'); -- 130g de pommes de terre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('31.5', 'g', '12', '23'); -- 31.5g de farine
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('19', 'g', '12', '26'); -- 19g de beurre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '12', '59'); -- 25g d'eau
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '12', '44'); -- 1 oeuf
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '12', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '12', '60'); -- 1 huile de friture

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '13', '61'); -- 120g flcons d avoine
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('240', 'g', '13', '23'); -- 31.5g de farine
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'NULL', '13', '44'); -- 2 oeufs
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'sachet', '13', '63'); -- 1 sachet de levure 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'sachet', '13', '64'); -- 1 sachet de sucre vanillé
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('120', 'g', '13', '65'); -- 120g de chocolat
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '13', '66'); -- 150g sucre roux
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '13', '26'); -- 75g de beurre 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('75', 'g', '13', '67'); -- 75g de margarine

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '14', '45'); -- 150g de boeuf
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'g', '14', '24'); -- 150 g de carottes
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '14', '4'); -- 50 g de lardon fumé
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '14', '5'); -- 1/2 oignon 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '14', '6'); -- 1/2 gousse d'ail
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '14', '21'); -- 1 pincée de poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '14', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à café', '14', '68'); -- Herbe de provence
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '14', '15'); -- Huile d'olive
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'mL', '14', '69'); -- 3/20 vin rouge
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('150', 'mL', '14', '70'); -- 3/20 bouillon

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '15', '71'); -- 1 tranche de pain de campagne
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '15', '72'); -- 1 tranche de jambon cuit ou speck (type jambon cru)
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '15', '18'); -- 1/2 tomate
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '73'); -- Gruyère râpé
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '74'); -- Mozzarella
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '15', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '15', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '15', '76'); -- Origan
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '15', '15'); -- Huile d'olive

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1.8', 'kg', '16', '2'); -- 1/5 poulet (au moins 1,8 kg)
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.2', 'NULL', '16', '77'); -- 1/5 mont d'or
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '16', '78'); -- 50 g de champignons surgelés (mélange forestier, cèpes, girolles...)

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '17', '79'); -- 1/4 salade (type feuille de chêne rouge
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'poignée', '17', '80'); -- 1/4 poignée de noix (ou de pignons)
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '17', '81'); -- 1 pêche fraîches (ou au sirop)
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '17', '82'); -- 1/4 concombre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '17', '83'); -- 1 escalope de poulet
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'cuillère à soupe', '17', '84'); -- 1/4 cuillère à soupe d'huile de noix
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '17', '85'); -- 1/2 cuillère à soupe de vinaigre balsamique
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '17', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '17', '8'); -- 1 pincée de sel

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'cl', '18', '39'); -- 50cl lait
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '86'); -- 50g farine fleur de mais
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('125', 'g', '18', '87'); -- 125g sucre semoule
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '18', '88'); -- 1 CAS fleur d'oranger
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '89'); -- 50g raisins secs
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '18', '90'); -- 50g pistache

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'tranche', '19', '83'); -- 1 tranche d'escalope de poulet
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '19', '35'); -- 1/4 citron
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'feuille', '19', '91'); -- 1 feuille de menthe
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '19', '92'); -- Moutarde
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '19', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '19', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'jaune', '19', '44'); -- 1 jaune d'oeuf
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'cuillère à soupe', '19', '93'); -- 1 CAS de panure
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '19', '41'); -- 1/4 Yaourt nature

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '94'); -- 1/4 ananas
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '20', '1'); -- 100g de riz
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('3', 'NULL', '20', '95'); -- 3 crevettes roses crues
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '20', '96'); -- 25g de maïs 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '20', '97'); -- 0.5 Cébette
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '98'); -- 1/4 oigon rouge
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '20', '6'); -- 0.5 gousse ail
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '20', '99'); -- 1 CAS de sauce soja
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'cuillère à soupe', '20', '100'); -- 1 cas huile de sesame
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2', 'cuillère à café', '20', '101'); -- 3/20 cuillère de gingembre moulu
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'bouquet', '20', '102'); -- 1/4 bouquet coriandre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '20', '103'); -- 1/4 piment

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '21', '104'); -- 1 banane 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'sachet', '21', '64'); -- 1/2 sachet de sucre vanillé
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'verre', '21', '105'); -- 1/2 verre de rhum
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'noisette', '21', '26'); -- 1 noisette de beurre

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '106'); -- 1/2 aubergine
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '5'); -- 1 oignon
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '18'); -- 1/2 tomate
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '44'); -- 1 oeuf 
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '22', '107'); -- 50g de chair à saucisse
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '22', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '22', '8'); -- 1 pincée de sel
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '108'); -- 1 persil
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.5', 'NULL', '22', '6'); -- 1 ail
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '22', '109'); -- basilic
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'cuillère à soupe', '22', '15'); -- 1 CAS de huile d'olive
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('12.5', 'g', '22', '73'); -- 12.5g de gruyere rapé

INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('200', 'g', '23', '110'); -- 200g de veau
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('2.5', 'cl', '23', '111'); -- 2.5cl huile
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'NULL', '23', '6'); -- 1 ail
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('100', 'g', '23', '112'); -- 100 g de tomates concassés
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('50', 'g', '23', '24'); -- 50g de carottes
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('25', 'g', '23', '5'); -- 25g d'oignon
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('5', 'cl', '23', '19'); -- 5cl de vin blanc
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('0.25', 'NULL', '23', '20'); -- 1 bouquet garni
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '23', '21'); -- Poivre
INSERT INTO `cook_book`.`possede_rc_ing` (`quantite`, `mesure`, `ID_recette`, `ID_ingr`) VALUES ('1', 'pincée', '23', '8'); -- 1 pincée de sel

INSERT INTO `cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Cooper', 'Travis', '0', '1', '0', 'CooperTravis@gmail.com');
INSERT INTO `cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Bobo', 'marc', '1', '0', '0', 'marctheBobo@gmail.com');
INSERT INTO `cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Boby', 'Patrick', '1', '0', '0', 'BobyandPatrick@gmail.com');
INSERT INTO `cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'Boukbouk', 'Remrem', '0', '1', '0', 'remi.boukeloua@efrei.net');
INSERT INTO `cook_book`.`utilisateur` (`mot_d_passe`, `nom_utilis`, `prenom_utilis`, `vegetarien`, `halal`, `vegan`, `ad_mail`) VALUES ('123123', 'huang', 'Claire', '0', '0', '0', 'claire.huang@efrei.net');

INSERT INTO `cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('1', 'A ne jamais refaire', '2018-02-10', '5', '5');
INSERT INTO `cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('2', 'n\'a pas assez de goûts', '2018-02-8', '6', '4');
INSERT INTO `cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('3', 'Pas mal', '2018-02-7', '20', '3');
INSERT INTO `cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('4', 'Une tuerie', '2018-02-17', '19', '2');
INSERT INTO `cook_book`.`note_util_rc` (`note`, `description`, `date_note`, `ID_recette`, `ID_utilis`) VALUES ('5', 'c\'est excellent, je recommande', '2018-02-15', '13', '1');

INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Gluten');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Crustacé');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Oeuf');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Poisson');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Arachide');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Soja');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Lait');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Fruit à coques');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Céleri');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Moutarde');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Graines de sésame');
INSERT INTO `cook_book`.`allergene` (`nom_allerg`) VALUES ('Mollusque');

INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '23');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '43');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '86');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '71');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '49');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '99');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('1', '61');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('3', '44');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('2', '95');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('4', '33');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('4', '38');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '90');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '80');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '84');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('5', '89');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('6', '99');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '26');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '27');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '34');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '36');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '39');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '41');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '55');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '57');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '62');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '73');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '74');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '75');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('7', '77');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('9', '10');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('10', '23');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('10', '92');
INSERT INTO `cook_book`.`compose_ing_all` (`ID_all`, `ID_ingr`) VALUES ('11', '100');

INSERT INTO `cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('2', '1');
INSERT INTO `cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('3', '2');
INSERT INTO `cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('4', '3');
INSERT INTO `cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('8', '4');
INSERT INTO `cook_book`.`est_allergique_all_util` (`ID_all`, `ID_utilis`) VALUES ('6', '5');
