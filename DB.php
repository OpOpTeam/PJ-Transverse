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

function retrieve_products($conn)
{
	try{
		// Connect first: $conn is the database instance
		$stmt = $conn->prepare("SELECT id, description, weight, cost, quantity FROM products");
		$stmt->execute();
		
		// Set the resulting array to associative
		$stmt->setFetchMode(PDO::FETCH_ASSOC);
		$result = $stmt->fetchAll();
		
		echo "<table border=1>";
		
		echo "<tr> <td>Product ID</td> <td>Description</td> <td>Weight</td> <td>Cost</td> <td>Quantity</td> </tr>";
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