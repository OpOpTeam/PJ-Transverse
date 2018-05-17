

<!DOCTYPE html>
<html>

<head>
    <title>Database add products</title>
    <meta charset = "utf-8" />
    <script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script type = "text/javascript" src = "indexScript.js"></script>
</head>

<body>

<?php
	    require_once("db.php");
	    $conn = db_connect("localhost", "cook_book","root", "Claire97");

		affichage_meilleures_notes_global($conn);
		affichage_meilleures_notes_utilisateur($conn,5);
		recherche_meilleure_recette_ing_fav($conn, 5);
		
?>

</body>

</html>