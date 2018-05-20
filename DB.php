<!DOCTYPE html>
<html>

<head>
	<title>db</title>
	<meta charset = "utf-8" />
</head>

<body>

<?php

function db_reset($conn, $file)
{
	try{
		$query = file_get_contents($file);
		$sql = $conn->prepare("$query");
		
		$sql->execute();
		echo "Database has been reset";
	}
	catch (PDOException $e) {
		echo "Error: " . $e->getMessage();
	}
}

/**
*	Permet la connexion à la DB 
**/
function db_connect($servername, $dbname, $username, $password) {
	try {
		$conn = new PDO("mysql:host=$servername;dbname=$dbname;charset=utf8", $username, $password); 
	
	// set the PDO error mode to exception
	
	$conn -> setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
	echo "Connected successfully<br>";
	return $conn;
	}
	catch (PDOException $e) {
		echo "Connection failed: " . $e->getMessage();
	}
}

function CloseCon($conn)
 {
	 $conn -> close();
 }

/**
*	Selectionne les 10 meilleures recettes à notre client qui lui ont plû à tout le monde à ces notes
**/
function affichage_meilleures_notes_global($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes limite à 4 recettes*/
		$reponse = $conn->prepare("SELECT ID_recette, AVG(note) FROM note_Util_Rc GROUP BY ID_recette ORDER BY AVG(note) DESC LIMIT 4");
		$reponse->execute();

		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$result = $reponse->fetchAll();

		// result est un tableau deux dimensions result[, nom]
		// echo $result[3]['ID_recette']; 
		
		echo "<table border=1>";
		
		echo "<tr> <td>ID RECETTE</td> <td>Note</td>";
		foreach ($result as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";

	}

	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

/**
*	Selectionne les 10 meilleures recettes à notre client qui lui ont plû  à lui 
**/
function affichage_meilleures_notes_utilisateur($conn, $id_util){
	try{
		/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
		$reponse = $conn->prepare("SELECT ID_recette, note FROM note_Util_Rc Where ID_utilis = ".$id_util." ORDER BY note DESC Limit 10");
		$reponse->execute();

		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$result = $reponse->fetchAll();
		
		echo "<table border=1>";
		
		echo "<tr> <td>ID RECETTE</td> <td>Note</td>";
		foreach ($result as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";
	}

	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

/**
*	Cette fonction permet de trouver les meilleures recettes pour un internaute
*	en fonction de ses ingrédients favoris ! 
**/
function recherche_meilleure_recette_ing_fav($conn, $id_util){
	try{
		/* Recupère tous les ingrédients dans toutes les recettes*/
		$reponse = $conn->prepare("SELECT ID_recette,ID_ingr  FROM possede_Rc_Ing ORDER BY ID_recette");
		$reponse->execute();

		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$table_ingr = $reponse->fetchAll();

		
		echo "<table border=1>";
		
		echo "<tr> <td>ID Recette</td> <td>ID Ingredient</td>";
		foreach ($table_ingr as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";


	/* Recupère tous les ingrédients dans toutes les recettes*/
		$reponse2 = $conn->prepare("SELECT DISTINCT ID_ingr FROM ((SELECT ID_recette
														FROM note_Util_Rc 
														Where ID_utilis = ".$id_util." ORDER BY note DESC Limit 3 )AS BestRecipies, possede_Rc_Ing)
												  WHERE BestRecipies.ID_recette = possede_Rc_Ing.ID_recette");

		$reponse2->execute();

		// Set the resulting array to associative
		$reponse2->setFetchMode(PDO::FETCH_ASSOC);
		$table_util_fav = $reponse2->fetchAll();

		
		echo "<table border=1>";
		
		echo "<tr> <td>ID Ingredient</td>";
		foreach ($table_util_fav as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";

		//$tab_ID_rec_conseil[] = array('' => , );
		$temp_id = 0;
		$cpt_similitude = 0;
		foreach ($table_ingr as $value)
		{
			
			foreach( $value as $key => $val)
			{
				if ($key == "ID_recette"){
					if ($val != $temp_id){
						$temp_id = $val;
						$cpt_similitude = 0;
					}
				}
				else {
					
					foreach($table_util_fav as $value2){
						foreach( $value2 as $kk => $ingr_fav){
							if ($ingr_fav == $val){
								$cpt_similitude++;
								
							}
							if ($cpt_similitude == 1){
								$cpt_similitude++;
								echo $temp_id." "; // recettes succeptibles de plaire au monsieur :D 
								//array_push($table_util_fav,$temp_id);
							}
						}
					}
				}
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function recherche_nom_recette($conn){

	try{
		if (isset($_GET['recherche'])){

    		$recherche =  $_GET['recherche'];
			/* Affichage des recettes contenant le mot saisie par l'utilisateur dans le titre de la recette */
			$reponse = $conn->prepare("SELECT nom_recette, ID_recette FROM recette Where nom_recette LIKE '%".$recherche."%' ORDER BY nom_recette");

			$reponse->execute();

			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
			$result = $reponse->fetchAll();
			
			echo "<table border=1>";
			
			echo "<tr> <td>nom</td> <td>id</td>";
			foreach ($result as $value)
			{
				echo "<tr>";
				foreach( $value as $key => $val)
				{
					echo ("<td> $val<br> </td>");
				}
				echo"</tr>";      
			}
			echo "</table>";
  		}
  	}
	catch(PDOException $e){
		echo "Error: " . $e->getMessage();
	}
}


/**
*	Cette fonction permet la recherche des noms des recettes possédant les ingrédients entrés par l'utilisateur séparé d'une ',' sans espace
**/

function recherche_nom_ingredient($conn){

	try{
		if (isset($_GET['recherche_ingr'])){

    		$recherche_ingr =  $_GET['recherche_ingr'];

    		/*
    		*	liste_ingr correspond à la liste de tous les ingrédients présents dans  
    		*/
    		$liste_ingr = explode(",", $recherche_ingr);
    		echo count($liste_ingr);

    		/*
    		*	Creation de la query 
    		*/
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			echo $liste_ingr[$i];
    			if ($i == 0)$query = " select distinct nom_recette from recette inner join possede_rc_ing on possede_Rc_Ing.ID_recette = recette.ID_recette
											   					   join ingredient on Ingredient.ID_ingr = possede_Rc_Ing.ID_ingr ";
    			else {
    				$query.=  " join possede_rc_ing possede_rc_ing".$i." on possede_Rc_Ing".$i.".ID_recette = recette.ID_recette
                                join ingredient ingredient".$i." on ingredient".$i.".ID_ingr = possede_Rc_Ing".$i.".ID_ingr ";
    			}
    		}
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$where_query = "WHERE ingredient.nom_ingr LIKE '%".$liste_ingr[0]."%' ";
    			else {
    				$where_query .= " AND ";
    				$where_query .= " Ingredient".$i.".nom_ingr LIKE '%".$liste_ingr[$i]."%' ";
    			}
    		}

    		echo $query.$where_query;
			/* Affichage des recettes contenant les ingrédients de la liste */
			$reponse = $conn->prepare($query.$where_query);
			$reponse->execute();

			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
			$result = $reponse->fetchAll();
			
			echo "<table border=1>";
			
			echo "<tr> <td>nom_recette</td>";
			foreach ($result as $value)
			{
				echo "<tr>";
				foreach( $value as $key => $val)
				{
					echo ("<td> $val<br> </td>");
				}
				echo"</tr>";      
			}
			echo "</table>";
  		}
  	}
	catch(PDOException $e){
		echo "Error: " . $e->getMessage();
	}
}

function affichage_recette($conn, $id_rec){

	/*
	*	récupération puis transformation en tableau d'étape les inscriptions.
	*/
    $reponse = $conn->prepare( "SELECT instruction FROM recette Where ID_recette = ".$id_rec);
	$reponse->execute();

	// Set the resulting array to associative
	$reponse->setFetchMode(PDO::FETCH_ASSOC);
	$result = $reponse->fetchAll();

	foreach ($result as $value) {
		foreach( $value as $key => $val)
				{
					$descrip = $val;
				}
	}

	// $liste_etape[0] n'a pas de valeur
	// donc si besoin de l'étape 1 => $liste_etape[1] directement.
	$liste_etape = explode("/", $descrip);
	$nb_etape =  count($liste_etape)-1;
	echo "nb etape".$nb_etape;

	/*
	*  ingrédients pour l'affichage 
	*/
    $reponse2 = $conn->prepare( "SELECT ingredient.ID_ingr FROM ingredient join possede_Rc_Ing on ingredient.ID_ingr = possede_Rc_Ing.ID_ingr Where ID_recette = ".$id_rec);
	$reponse2->execute();
	// Set the resulting array to associative
	$reponse2->setFetchMode(PDO::FETCH_ASSOC);
	$table_ingr = $reponse2->fetchAll();


	/*
	*  calcul de la note moyenne
	*/
    $reponse3 = $conn->prepare( "SELECT AVG(note) FROM note_Util_Rc Where ID_recette = ".$id_rec);
	$reponse3->execute();
	// Set the resulting array to associative
	$reponse3->setFetchMode(PDO::FETCH_ASSOC);
	$result3 = $reponse3->fetchAll();

	foreach ($result as $value) {
		foreach( $value as $key => $val)
		{
			$note = $val;
		}
	}

	/*
	*	récupération puis transformation en tableau d'étape les inscriptions.
	*/
    $reponse4 = $conn->prepare( "SELECT temps_min, nb_pers FROM recette Where ID_recette = ".$id_rec);
	$reponse4->execute();

	// Set the resulting array to associative
	$reponse4->setFetchMode(PDO::FETCH_ASSOC);
	$result4 = $reponse4->fetchAll();

	echo "<table border=1>";
			
	echo "<tr> <td>minutes</td><td>nb de personne</td>";
	foreach ($result4 as $value)
	{
		echo "<tr>";
		foreach( $value as $key => $val)
		{
			echo ("<td> $val<br> </td>");
		}
		echo"</tr>";      
	}
	echo "</table>";

}

function nouveaute_recette($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
		$reponse = $conn->prepare("SELECT id_recette, nom_recette, datediff(date(NOW()), recette.date) FROM recette Where datediff(date(NOW()), recette.date)<35 ");

		$reponse->execute();

		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$result = $reponse->fetchAll();
		
		echo "<table border=1>";
		
		echo "<tr> <td>ID RECETTE</td> <td>Note</td>";
		foreach ($result as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";
	}

	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function nouveaute_les_mieux_note($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
		$reponse = $conn->prepare("SELECT distinct recette.id_recette, nom_recette, datediff(date(NOW()), recette.date), AVG(note_util_rc.note) FROM recette join note_util_rc on recette.id_recette = note_util_rc.id_recette Where datediff(date(NOW()), recette.date)<35 ");
		$reponse->execute();

		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$result = $reponse->fetchAll();
		
		echo "<table border=1>";
		
		echo "<tr> <td>ID RECETTE</td> <td>Note</td>";
		foreach ($result as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";
	}

	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}


function retrieve_product_id($conn, $id)
{
	try{
		// Connect first: $conn is the database instance
		$id = -1;
		$stmt = $conn->prepare("SELECT id, description, weight, cost, quantity FROM products WHERE id = :id");
		$stmt->bindParam(':id', $id);
		$stmt->execute();
		
		// Set the resulting array to associative
		$stmt->setFetchMode(PDO::FETCH_ASSOC);
		$result = $stmt->fetchAll();
		
		echo "<table border=1>";
		
		foreach ($result as $value)
		{
			echo "<tr>";
			foreach( $value as $key => $val)
			{
				echo ("<td> $val<br> </td>");
			}
			echo"</tr>";      
		}
		echo "</table>";
	}
	catch(PDOException $e){
		echo "Error: " . $e->getMessage();
	}
}
	

?>

</body>

</html>