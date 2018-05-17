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