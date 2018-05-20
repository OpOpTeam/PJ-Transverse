<?php
require_once("db.php");

function dbLogin(){
	$dbservername = 'localhost';
	$dbusername = 'root';
	$dbpassword = '';
	$dbname = 'cook_book';
	return db_connect($dbservername, $dbname, $dbusername, $dbpassword);
}

function test_input($data){
    $data = trim($data);
    $data = stripslashes($data);
    $data = htmlspecialchars($data);
    return $data;
}
?>