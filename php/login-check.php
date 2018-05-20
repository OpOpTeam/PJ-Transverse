<?php
function connexion($ad_mail,$mot_d_passe){
    $query = "SELECT ad_mail, mot_d_passe 
    		FROM utilisateur 
    		WHERE ad_mail='".$ad_mail."'
    		AND mot_d_passe='".$mot_d_passe."'";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute();
    // Set the resulting array to associative
    $count = $reponse->fetchColumn();   
    if(!empty ($count)){
        return true;
    }
    return false;
}

function initialisationSession($fieldname, $ad_mail){
	$query = "SELECT ".$fieldname." FROM utilisateur WHERE ad_mail ='".$ad_mail."'";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute();
    $reponse->setFetchMode(PDO::FETCH_ASSOC);
	$result = $reponse->fetchAll();
	foreach ($result as $value)
	{
		foreach( $value as $key => $val)
		{
			return $val;
		}     
	}
}
?>