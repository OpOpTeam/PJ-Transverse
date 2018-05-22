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


 function affichage_chiffres($conn){
 	try{
		/* Affichage dans l'index pour les meilleures recettes limite à 6 recettes*/
		$reponse = $conn->prepare("SELECT (
				    SELECT COUNT(*)
				    FROM recette
				    ) AS countRecette,
				    (SELECT COUNT(*)
				    FROM ingredient
				    ) AS countIngredient,
				    (SELECT COUNT(*)
				    FROM note_util_rc
				    ) AS countNote,
				    (SELECT COUNT(*)
				    from utilisateur
				    ) AS countUtilisateur");
		$reponse->execute();
		
		// result est un tableau deux dimensions result[, nom]
		// echo $result[3]['ID_recette']; 
		
		while ($row = $reponse->fetch(PDO::FETCH_ASSOC))
		{
			?>
			<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInUp">
				<div class="feature-center">
					<span class="counter js-counter" data-from="0" data-to="<?php echo $row['countRecette']?>" data-speed="5000" data-refresh-interval="50">1</span>
					<span class="counter-label">Recettes</span>
				</div>
			</div>
			<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInUp">
				<div class="feature-center">
					<span class="counter js-counter" data-from="0" data-to="<?php echo $row['countIngredient']?>" data-speed="5000" data-refresh-interval="50">1</span>
					<span class="counter-label">Ingrédients</span>
				</div>
			</div>
			<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInUp">
				<div class="feature-center">
					<span class="counter js-counter" data-from="0" data-to="<?php echo $row['countUtilisateur']?>" data-speed="5000" data-refresh-interval="50">1</span>
					<span class="counter-label">Utilisateurs</span>
				</div>
			</div>	
			<div class="col-md-3 col-sm-6 animate-box" data-animate-effect="fadeInUp">
				<div class="feature-center">
					<span class="counter js-counter" data-from="0" data-to="<?php echo $row['countNote']?>" data-speed="5000" data-refresh-interval="50">1</span>
					<span class="counter-label">Avis</span>
				</div>
			</div>
			<?php   
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
 }
/**
*	Selectionne les 10 meilleures recettes à notre client qui lui ont plû à tout le monde à ces notes
**/
function affichage_meilleures_notes_global($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes limite à 6 recettes*/
		$reponse = $conn->prepare("SELECT count(*), AVG(n.note), r.temps_min, r.nom_recette, r.ID_recette
			FROM note_util_rc n
			JOIN recette r ON r.ID_recette = n.ID_recette
			GROUP BY nom_recette 
			HAVING AVG(n.note) > 3
			ORDER BY AVG(n.note)
			DESC LIMIT 6");
		$reponse->execute();
		
		// result est un tableau deux dimensions result[, nom]
		// echo $result[3]['ID_recette']; 
		
		while ($row = $reponse->fetch(PDO::FETCH_ASSOC))
		{
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							<?php						
							for($star = 0; $star < round($row['AVG(n.note)'], 0); $star++){
								?>
									<i class="icon-star2"></i>
								<?php
							}
							for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
								?>
									<i class="icon-star-outlined"></i>
								<?php
							}
							echo $row['count(*)'];?> avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
		}
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
		$reponse = $conn->prepare("SELECT ID_recette, note FROM note_util_rc Where ID_utilis = ".$id_util." ORDER BY note DESC Limit 10");
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

function recherche_nombre_recette($conn){
	try{
        if (isset($_GET['recette'])){
            $recherche =  $_GET['recette'];
            /* Affichage des recettes contenant le mot saisie par l'utilisateur dans le titre de la recette */
            $reponse = $conn->prepare("SELECT count(DISTINCT ID_recette) FROM recette			
            Where nom_recette LIKE '%".$recherche."%'
            ORDER BY nom_recette");

            $reponse->execute();

            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
            	return $row['count(DISTINCT ID_recette)'];
            }
            
		}
	}
	catch(PDOException $e){
		echo "Error: " . $e->getMessage();
	}
}

function recherche_nombre_recette_avec_ingredient($conn){
	try{
        if (isset($_GET['recherche_ingr'])){
    		$recherche_ingr = $_GET['recherche_ingr'];
    		/*
    		*	liste_ingr correspond à la liste de tous les ingrédients présents dans  
    		*/
    		$liste_ingr = explode(",", $recherche_ingr);
    		/*
    		*	Creation de la query 
    		*/
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$query = " select count(DISTINCT recette.ID_recette) from recette inner join possede_rc_ing on possede_rc_ing.ID_recette = recette.ID_recette 
											   					   join ingredient on Ingredient.ID_ingr = possede_rc_ing.ID_ingr ";
    			else {
    				$query.=  " join possede_rc_ing possede_rc_ing".$i." on possede_rc_ing".$i.".ID_recette = recette.ID_recette
                                join ingredient ingredient".$i." on ingredient".$i.".ID_ingr = possede_rc_ing".$i.".ID_ingr ";
    			}
    		}
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$where_query = "WHERE ingredient.nom_ingr LIKE '%".$liste_ingr[0]."%'";
    			else {
    				$where_query .= " AND ";
    				$where_query .= " Ingredient".$i.".nom_ingr LIKE '%".$liste_ingr[$i]."%' ";
    			}
    		}
			/* Affichage des recettes contenant les ingrédients de la liste */
			$reponse = $conn->prepare($query.$where_query);
			$reponse->execute();
			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
            $reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
            	return $row['count(DISTINCT recette.ID_recette)'];              
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}


function recherche_nom_recette_sans_note($conn){

    try{
        if (isset($_GET['recette'])){

            $recherche =  $_GET['recette'];
            /* Affichage des recettes contenant le mot saisie par l'utilisateur dans le titre de la recette */
            $reponse = $conn->prepare("SELECT r.nom_recette, r.temps_min, r.ID_recette
			FROM recette r
            LEFT JOIN note_util_rc n ON r.ID_recette = n.ID_recette
			Where nom_recette LIKE '%".$recherche."%'
            AND n.ID_recette IS NULL
			GROUP BY r.nom_recette");

            $reponse->execute();

            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							Aucun avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function recherche_nom_recette_avec_note($conn){

    try{
        if (isset($_GET['recette'])){

            $recherche =  $_GET['recette'];
            /* Affichage des recettes contenant le mot saisie par l'utilisateur dans le titre de la recette */
            $reponse = $conn->prepare("SELECT count(*), AVG(n.note), r.temps_min, r.nom_recette, r.ID_recette 
			FROM recette r
            JOIN note_util_rc n ON r.ID_recette = n.ID_recette
			Where nom_recette LIKE '%".$recherche."%'            
			GROUP BY r.ID_recette
            ORDER BY AVG(n.note) DESC");

            $reponse->execute();

            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							<?php						
							for($star = 0; $star < round($row['AVG(n.note)'], 0); $star++){
								?>
									<i class="icon-star2"></i>
								<?php
							}
							for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
								?>
									<i class="icon-star-outlined"></i>
								<?php
							}
							echo $row['count(*)']?> avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}
function recherche_nom_ingredient_sans_note($conn){
	try{
		if (isset($_GET['recherche_ingr'])){
    		$recherche_ingr = $_GET['recherche_ingr'];
    		/*
    		*	liste_ingr correspond à la liste de tous les ingrédients présents dans  
    		*/
    		$liste_ingr = explode(",", $recherche_ingr);
    		/*
    		*	Creation de la query 
    		*/
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$query = " select distinct recette.nom_recette, recette.temps_min, recette.ID_recette from recette inner join possede_rc_ing on possede_rc_ing.ID_recette = recette.ID_recette LEFT JOIN note_util_rc n ON recette.ID_recette = n.ID_recette
											   					   join ingredient on Ingredient.ID_ingr = possede_rc_ing.ID_ingr ";
    			else {
    				$query.=  " join possede_rc_ing possede_rc_ing".$i." on possede_rc_ing".$i.".ID_recette = recette.ID_recette
                                join ingredient ingredient".$i." on ingredient".$i.".ID_ingr = possede_rc_ing".$i.".ID_ingr ";
    			}
    		}
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$where_query = "WHERE ingredient.nom_ingr LIKE '%".$liste_ingr[0]."%' AND n.ID_recette IS NULL";
    			else {
    				$where_query .= " AND ";
    				$where_query .= " Ingredient".$i.".nom_ingr LIKE '%".$liste_ingr[$i]."%' ";
    			}
    		}
    		$qry = " GROUP BY recette.ID_recette";
			/* Affichage des recettes contenant les ingrédients de la liste */
			$reponse = $conn->prepare($query.$where_query.$qry);
			$reponse->execute();
			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							Aucun avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function recherche_nom_ingredient_avec_note($conn){
	try{
		if (isset($_GET['recherche_ingr'])){
    		$recherche_ingr = $_GET['recherche_ingr'];
    		/*
    		*	liste_ingr correspond à la liste de tous les ingrédients présents dans  
    		*/
    		$liste_ingr = explode(",", $recherche_ingr);
    		/*
    		*	Creation de la query 
    		*/
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$query = " select distinct count(*), AVG(n.note), recette.nom_recette, recette.temps_min, recette.ID_recette from recette inner join possede_rc_ing on possede_rc_ing.ID_recette = recette.ID_recette JOIN note_util_rc n ON recette.ID_recette = n.ID_recette
											   					   join ingredient on Ingredient.ID_ingr = possede_rc_ing.ID_ingr ";
    			else {
    				$query.=  " join possede_rc_ing possede_rc_ing".$i." on possede_rc_ing".$i.".ID_recette = recette.ID_recette
                                join ingredient ingredient".$i." on ingredient".$i.".ID_ingr = possede_rc_ing".$i.".ID_ingr ";
    			}
    		}
    		for ($i = 0 ;$i < count($liste_ingr); $i++){
    			if ($i == 0)$where_query = "WHERE ingredient.nom_ingr LIKE '%".$liste_ingr[0]."%' ";
    			else {
    				$where_query .= " AND ";
    				$where_query .= " Ingredient".$i.".nom_ingr LIKE '%".$liste_ingr[$i]."%' ";
    			}
    		}
    		$qry = " GROUP BY recette.ID_recette
            ORDER BY AVG(n.note) DESC";
			/* Affichage des recettes contenant les ingrédients de la liste */
			$reponse = $conn->prepare($query.$where_query.$qry);
			$reponse->execute();
			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							<?php						
							for($star = 0; $star < round($row['AVG(n.note)'], 0) ; $star++){
								?>
									<i class="icon-star2"></i>
								<?php
							}
							for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
								?>
									<i class="icon-star-outlined"></i>
								<?php
							}
							echo $row['count(*)']?> avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function information_recette($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];    		
    		$reponse = $conn->prepare("SELECT count(*), AVG(n.note), r.temps_min, r.nom_recette, r.ID_recette 
			FROM recette r
            LEFT JOIN note_util_rc n ON r.ID_recette = n.ID_recette
			Where r.ID_recette LIKE ".$recette."");            
		    $reponse->execute();		   
            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);            
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
			<div class="row animate-box" data-animate-effect="fadeInUp">
				<div class="col-md-8 col-md-offset-2 text-center gtco-heading">
					<h2 class="cursive-font primary-color"><?php echo $row['nom_recette']?> !</h2>
				</div>
			</div>
			<div class="col-md-offset-3 col-md-6 animate-box" data-animate-effect="fadeIn">
				<a href="images/recette_<?php echo $row['ID_recette']?>.jpg" class="fh5co-card-item image-popup">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
					</div>
				</a>					
			</div>

			<div class="row">
				<div class="col-md-offset-2 col-md-2 col-sm-12 animate-box" align="center" data-animate-effect="fadeIn">
					<h3 class="btn btn-primary btn-sm">
						<div class="cursive-font">	
						<i class="icon-star2"></i>				
						<?php 
						if (empty($row['AVG(n.note)'])){
							if(isset($_SESSION['nom_utilis'])){
							?>
								<a href="review.php?recette=<?php echo $_GET['recette']?>" id="review">
									Aucun avis
								</a>
							<?php
							}	
							else{
							?>
								<a href="#" id="review">
								Aucun avis
								</a>
							<?php
							}
						}
						else {
							?>
							<a href="recette-review?recette=<?php echo $row['ID_recette'];?>" id="review">
							<?php
								echo round($row['AVG(n.note)'], 1)?>/5  <?php echo $row['count(*)']
						?> avis 
							</a>
						<?php
						}?>
					</div>
					</h3>
				</div>
				<div class="col-md-offset-1 col-md-2 col-sm-12 animate-box" align="center" data-animate-effect="fadeIn">
					<h3 class="cursive-font primary-color padding-top-12px">
						<i class="icon-clock"></i>
						<?php echo $row['temps_min']?> minutes						
					</h3>
				</div>	
				<div class="col-md-offset-1 col-md-2 col-sm-12 animate-box" align="center" data-animate-effect="fadeIn">
					<div class="row">
						<h3 class="cursive-font primary-color padding-top-12px">
							<i class="ti-user"></i>	
							1 personne						
						</h3>
					</div>			
				</div>			
			</div>
			<?php			
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function affichage_ingredient($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];

    		$reponse = $conn->prepare( "SELECT possede_rc_ing.quantite, possede_rc_ing.mesure, ingredient.nom_ingr  FROM ingredient join possede_rc_ing on ingredient.ID_ingr = possede_rc_ing.ID_ingr Where ID_recette = ".$recette);
			$reponse->execute();
			// Set the resulting array to associative
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
			while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
				if ($row['mesure'] == 'NULL'){
					echo $row['quantite']." ".$row['nom_ingr'];
				}
				else{
					echo $row['quantite']." ".$row['mesure']." ".$row['nom_ingr'];
				}
			?>
				<hr>
			<?php			
			}


		    /*$reponse = $conn->prepare( "SELECT instruction FROM recette Where ID_recette = ".$id_rec);
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
			echo "nb etape".$nb_etape;*/
			
		    
			
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function affichage_preparation($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];

    		$reponse = $conn->prepare( "SELECT instruction FROM recette Where ID_recette = ".$recette);
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
			$liste_etape = explode("/", $descrip);
			$etape = 0;
			foreach( $liste_etape as $key => $val)
			{	
				if($etape != 0){
				?>
				<h3 class="cursive-font primary-color">Etape <?php echo $etape;?></h3>
				</h3>
				<?php
					echo $val;
				?>
				<hr>
				<?php }	
				$etape++;					
			}
			
		    
			
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function affichage_note_moyenne($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];    		
    		$reponse = $conn->prepare("SELECT count(*), AVG(n.note), r.nom_recette, r.ID_recette 
			FROM recette r
            LEFT JOIN note_util_rc n ON r.ID_recette = n.ID_recette
			Where r.ID_recette LIKE ".$recette."");            
		    $reponse->execute();		   
            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);            
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
            $nbreAvis = $row['count(*)'];
			?>
			<h1 class="cursive-font text-center"><?php echo $row['nom_recette']?></h1>
			<br>
			<div class="row">
				<div class="col-sm-6">
					<div class="rating-block">
						<h2 class="cursive-font primary-color">Note moyenne de notre communauté</h2>
						<div class = "row">
							<div class="col-sm-2" align="center">
								<h2 class="bold padding-bottom-7"><?php echo round($row['AVG(n.note)'], 1)?><small>/ 5</small></h2>
							</div>
							<div class="col-sm-2" align="center">
								<h2 class="bold padding-bottom-7"> <?php echo $row['count(*)'];?> <small>avis</small></h2>
							</div>
							<div class="col-md-5" align="center">
								<?php
								for($star = 0; $star < round($row['AVG(n.note)'], 0); $star++){
									?>
									<button type="button" class="btn-primary btn-md">
									  <i class="icon-star2"></i>
									</button>
									<?php
								}
								for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
									?>
									<button type="button" class="btn-primary btn-md sans-etoile">
									  	<i class="icon-star2"></i>
									</button>
									<?php
								}
								?>
							</div>
						</div>
						<br>
						<div class="row">
							<?php
							if(isset($_SESSION['nom_utilis'])){
							?>
							<div class="col-md-4" align="center">
								<a href="review.php?recette=<?php echo $_GET['recette']?>">
									<button class="btn btn-primary btn-sm">Donnez votre avis</button>
								</a>
							</div>
							<?php
							}
							?>
						</div>
					</div>
				</div>
				<div class="col-md-offset-1 col-sm-5 ">
					<h1 class="cursive-font primary-color">Leurs avis</h1>
					<div class="col-sm-12">						

				

				<?php
				$reponse2 = $conn->prepare("SELECT count(*), note
							FROM note_util_rc
							Where ID_recette LIKE ".$recette."
				            GROUP BY note
				            ORDER BY note DESC");            
			    $reponse2->execute();		   
	            // Set the resulting array to associative
	            $reponse2->setFetchMode(PDO::FETCH_ASSOC);
	            $row = $reponse2->fetch(PDO::FETCH_ASSOC);
	            for ($star = 5; $star >= 1; $star--){			

				?>
					
					<div class="row">
						<div class="pull-left etoile-barre-avis">
							<div class="etoile-barre-avis2">
								<?php echo $star; ?><span class="glyphicon glyphicon-star"></span>
							</div>
						</div>
						<div class="pull-left barre-avis">
							<div class="progress barre-progression">
							  	
							
						<?php					
						if((int)$row['note'] == $star){
							?>
								<div class="progress-bar progress-bar-warning" style="width: <?php echo intval($row['count(*)']*100/$nbreAvis,0)?>%" role="progressbar"></div>							
							</div>
						</div>
							<?php echo $row['count(*)'];?>
							<?php
							
							$row = $reponse2->fetch(PDO::FETCH_ASSOC);
						}
						else{
							?>
								<div class="progress-bar progress-bar-warning" style="width: 0%" role="progressbar"></div>
							</div>
						</div>
							<?php
							echo '0';
						}
						?>					
						<span class="glyphicon glyphicon-user"></span>					
					</div>						
			<?php
				}				
			?> 
				</div>
			</div> <?php		
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function affichage_commentaire($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];    		
    		$reponse = $conn->prepare("SELECT n.note, n.description, n.date_note, u.nom_utilis, u.prenom_utilis
			FROM note_util_rc n
            JOIN utilisateur u ON u.ID_utilis = n.ID_utilis
			Where n.ID_recette LIKE ".$recette."
			ORDER BY n.note DESC");            
		    $reponse->execute();		   
            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);            
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
			?>
				<div class="row">
					<div class="col-sm-3">
						<img src="images/logo_chef.png" class="img-rounded image-resize-100px">
						<div class="review-block-name"><?php echo ucwords(strtolower($row['prenom_utilis']))." ". ucwords(strtolower($row['nom_utilis']));?></div>
						<div class="review-block-date"><?php echo $row['date_note'];?></div>
					</div>
					<div class="col-sm-9">
						<div class="review-block-rate">
						<?php
						for ($star = 0; $star < $row['note']; $star++){
							?>
							<button type="button" class="btn-primary btn-xs">
							  <i class="icon-star2"></i>
							</button>
							<?php
						}
						for ($star = $row['note']; $star < 5; $star++){
							?>
							<button type="button" class="btn-primary btn-xs sans-etoile">
							  <i class="icon-star2"></i>
							</button>
							<?php
						}
						?>
						</div>
						<br>
						<p>
							<?php echo $row['description'];
							?>
						</p>
					</div>
				</div>
				<hr>
			<?php		
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}


function get_recette_nom($conn){
	try{
		if (isset($_GET['recette'])){
    		$recette = $_GET['recette'];    		
    		$reponse = $conn->prepare("SELECT nom_recette 
			FROM recette
			Where ID_recette LIKE ".$recette."");            
		    $reponse->execute();		   
            // Set the resulting array to associative
            $reponse->setFetchMode(PDO::FETCH_ASSOC);            
            while ($row = $reponse->fetch(PDO::FETCH_ASSOC)){
				return $row['nom_recette'];	
			}
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function nouveaute_recette($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
		$reponse = $conn->prepare("SELECT id_recette, nom_recette, temps_min, datediff(date(NOW()), recette.date) FROM recette Where datediff(date(NOW()), recette.date)<35 Limit 2");
		$reponse->execute();
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		while ($row = $reponse->fetch(PDO::FETCH_ASSOC))
		{
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['id_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['id_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function nouveaute_les_mieux_note($conn){
	try{
		/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
		$reponse = $conn->prepare("SELECT distinct count(*), recette.id_recette, recette.temps_min, nom_recette, datediff(date(NOW()), recette.date), AVG(note_util_rc.note) 
			FROM recette join note_util_rc on recette.id_recette = note_util_rc.id_recette
			Where datediff(date(NOW()), recette.date)<35
			GROUP BY recette.id_recette
			Limit 2");
		$reponse->execute();
		// Set the resulting array to associative
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		while ($row = $reponse->fetch(PDO::FETCH_ASSOC))
		{
			?>
			<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
				<a href="recette.php?recette=<?php echo $row['id_recette'];?>" class="fh5co-card-item">
					<figure>
						<div class="overlay"><i class="ti-plus"></i></div>
						<img src="images/recette_<?php echo $row['id_recette'];?>.jpg" alt="Image" class="img-responsive">
					</figure>
					<div class="fh5co-text">
						<div class="row">
							<?php						
							for($star = 0; $star < round($row['AVG(note_util_rc.note)'], 0); $star++){
								?>
									<i class="icon-star2"></i>
								<?php
							}
							for($star = round($row['AVG(note_util_rc.note)'], 0); $star < 5; $star++){
								?>
									<i class="icon-star-outlined"></i>
								<?php
							}
							echo $row['count(*)'];?> avis
							<div class="row">
								<i class="icon-clock"></i>
								<?php echo $row['temps_min']; ?> minutes
							</div>
							<div class="row row-mt-1em">
								<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
							</div>
						</div>
					</div>
				</a>
			</div>
			<?php   
		}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function recherche_meilleure_recette_ing_fav($conn){
	try{
		if (isset($_SESSION['ID_utilis'])){
    		$id_util = $_SESSION['ID_utilis'];
		// L'utilisateur est-il vegetarien ou vegan
		$rep = $conn->prepare("SELECT vegetarien, vegan  from utilisateur WHERE ID_utilis = ".$id_util);
		$rep->execute();
		
		// Set the resulting array to associative
		$rep->setFetchMode(PDO::FETCH_ASSOC);
		$vege_vega = $rep->fetchAll();
		
		/* Recupère tous les ingrédients dans toutes les recettes*/
		
		$reponse = $conn->prepare("SELECT ID_recette,ID_ingr FROM possede_rc_ing 
															 WHERE (ID_recette NOT IN (SELECT DISTINCT p.ID_recette FROM  est_allergique_all_util est_all
												 																	 	   join compose_ing_all c On c.ID_all = est_all.ID_all
												 																		   Join possede_rc_ing p on p.ID_ingr = c.ID_ingr 
																													WHERE est_all.ID_utilis = ".$id_util.")

																					AND ID_recette NOT IN (SELECT DISTINCT id_recette FROM note_util_rc where id_utilis = ".$id_util.") )"

								.(($vege_vega[0]['vegan'] == 1)? " AND ID_recette NOT IN (SELECT DISTINCT ID_recette FROM possede_rc_ing, Ingredient 
															WHERE (Ingredient.ID_ingr = possede_rc_ing.ID_Ingr) AND ((type = 'Viande') OR (type = 'Laitier') OR (type = 'Poisson') OR (type = 'Fromage')))":
								(($vege_vega[0]['vegetarien'] == 1)? " AND ID_recette NOT IN (SELECT DISTINCT ID_recette FROM possede_rc_ing, Ingredient 
															WHERE (Ingredient.ID_ingr = possede_rc_ing.ID_Ingr) AND (type = 'Viande')) ": 
															""))." ORDER BY ID_recette");
		// Set the resulting array to associative
		$reponse->execute();
		$reponse->setFetchMode(PDO::FETCH_ASSOC);
		$table_ingr = $reponse->fetchAll();
		
		
	/* Recupère tous les ingrédients dans toutes les recettes*/
		$reponse2 = $conn->prepare("SELECT DISTINCT ID_ingr FROM ((SELECT ID_recette
														FROM note_util_rc 
														Where ID_utilis = ".$id_util." ORDER BY note DESC Limit 3 )AS BestRecipies, possede_rc_ing)
												  WHERE BestRecipies.ID_recette = possede_rc_ing.ID_recette ");
		$reponse2->execute();
		// Set the resulting array to associative
		$reponse2->setFetchMode(PDO::FETCH_ASSOC);
		$count = $reponse2->fetchColumn();
		$table_util_fav = $reponse2->fetchAll();
	    if(!empty ($count)){
	    	?>
	    	<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center gtco-heading">
					<h2 class="cursive-font primary-color">Vous allez aimer...</h2>
				</div>
			</div>
			<div class="row">
	    	<?php	       
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
									// recettes succeptibles de plaire au monsieur 😀 
									//array_push($table_util_fav,$temp_id);
									$reponse3 = $conn->prepare("SELECT count(*), AVG(n.note), r.temps_min, r.nom_recette, r.ID_recette
										FROM note_util_rc n
										JOIN recette r ON r.ID_recette = n.ID_recette
										WHERE r.ID_recette = ".$temp_id."
										GROUP BY nom_recette
										ORDER BY AVG(n.note)
										");
									$reponse3->execute();

									// result est un tableau deux dimensions result[, nom]
									// echo $result[3]['ID_recette']; 
									
									while ($row = $reponse3->fetch(PDO::FETCH_ASSOC))
									{
										?>
										<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
											<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
												<figure>
													<div class="overlay"><i class="ti-plus"></i></div>
													<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
												</figure>
												<div class="fh5co-text">
													<div class="row">
														<?php						
														for($star = 0; $star < round($row['AVG(n.note)'], 0); $star++){
															?>
																<i class="icon-star2"></i>
															<?php
														}
														for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
															?>
																<i class="icon-star-outlined"></i>
															<?php
														}
														echo $row['count(*)'];?> avis
														<div class="row">
															<i class="icon-clock"></i>
															<?php echo $row['temps_min']; ?> minutes
														</div>
														<div class="row row-mt-1em">
															<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
														</div>
													</div>
												</div>
											</a>
										</div>
										<?php   
									}
								}
							}
						}
					}
				}
			}
		?>
		</div>
		<br>
		<hr>
		<br>
		<?php
		}
		else{
			?>
			<div class="row">
				<div class="col-md-12 text-center gtco-heading">
					<h2 class="cursive-font primary-color">Donnez des avis pour avoir des recettes à votre image</h2>
					<img src="images/logo-chef-triste.png" alt="logo-chef-triste" class="text-center">
					<p>Nous sommes désolés, aucune recette n'a été trouvée...</p>				
				</div>
			</div>
			<br>
			<hr>
			<br>
			<?php
		}
	}
	}
	catch(PDOException $e){
	echo "Error: " . $e->getMessage();
	}
}

function affichage_recette_notee($conn){
	try{
		if (isset($_SESSION['ID_utilis'])){
    		$id_util = $_SESSION['ID_utilis'];
			/* Affichage dans l'index pour les meilleures recettes de l'utilisateur limite à 10 recettes*/
			$reponse = $conn->prepare("SELECT count(*), AVG(n.note), r.temps_min, r.nom_recette, r.ID_recette
										FROM note_util_rc n
										JOIN recette r ON r.ID_recette = n.ID_recette
										WHERE n.ID_utilis = ".$id_util."
										GROUP BY nom_recette
										ORDER BY AVG(n.note)");
			$reponse->execute();
			$reponse->setFetchMode(PDO::FETCH_ASSOC);
			
		    if(!empty ($reponse)){
		    	?>
		    	<div class="row">
					<div class="col-md-8 col-md-offset-2 text-center gtco-heading">
						<h2 class="cursive-font primary-color">Vous avez donné votre avis...</h2>
					</div>
				</div>
				<div class="row">
				<?php
				while ($row = $reponse->fetch(PDO::FETCH_ASSOC))
				{
					?>
					<div class="col-lg-6 col-md-6 col-sm-6 animate-box" data-animate-effect="fadeIn">				
						<a href="recette.php?recette=<?php echo $row['ID_recette'];?>" class="fh5co-card-item">
							<figure>
								<div class="overlay"><i class="ti-plus"></i></div>
								<img src="images/recette_<?php echo $row['ID_recette'];?>.jpg" alt="Image" class="img-responsive">
							</figure>
							<div class="fh5co-text">
								<div class="row">
									<?php						
									for($star = 0; $star < round($row['AVG(n.note)'], 0); $star++){
										?>
											<i class="icon-star2"></i>
										<?php
									}
									for($star = round($row['AVG(n.note)'], 0); $star < 5; $star++){
										?>
											<i class="icon-star-outlined"></i>
										<?php
									}
									echo $row['count(*)'];?> avis
									<div class="row">
										<i class="icon-clock"></i>
										<?php echo $row['temps_min']; ?> minutes
									</div>
									<div class="row row-mt-1em">
										<h3 class="cursive-font"><?php echo $row['nom_recette'];?></h3>					
									</div>
								</div>
							</div>
						</a>
					</div>
					<?php   
				}
				?>
				</div>
				<br>
				<hr>
				<br>
				<?php
			}
			else{
			?>
				<div class="row">
					<div class="col-md-12 text-center gtco-heading">
						<h2 class="cursive-font primary-color">Vous n'avez toujours pas donné d'avis !</h2>
						<img src="images/logo-chef-triste.png" alt="logo-chef-triste" class="text-center">
						<p>Nous sommes désolés, aucune recette n'a été trouvée...</p>				
					</div>
				</div>
				<br>
				<hr>
				<br>
			<?php
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