<?PHP
require_once("db-config.php");
if(!isset($_POST['submitted']))
{
   return false;
}

$formvars = array();    
$formvars['note'] = test_input($_POST['optradio']);
$formvars['description'] = test_input($_POST['avis']);
$formvars['ID_recette'] = test_input($_POST['recette_id']);
$formvars['ID_utilis'] = test_input($_POST['utilisateur_id']);





if(avisEstUnique($formvars, 'ID_utilis', 'ID_recette') == false){
    updateReviewIntoDB($formvars);
    header("Location: ../remerciement.php");
}
else{
    insertReviewIntoDB($formvars);
    header("Location: ../remerciement.php");
}



function avisEstUnique($formvars,$fieldname, $fieldname2){
    $query = "SELECT ".$fieldname." FROM note_util_rc WHERE ".$fieldname."='".$formvars[$fieldname]."' AND ".$fieldname2."='".$formvars[$fieldname2]."'";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute();
    // Set the resulting array to associative
    $count = $reponse->fetchColumn();   
    if(!empty ($count)){
        return false;
    }
    return true;
}


function insertReviewIntoDB($formvars){
    $query = "INSERT INTO note_util_rc (
            note,
            description,
            date_note,
            ID_recette,
            ID_utilis
            )
            VALUES
            (
            :note,
            :description,
            CAST(NOW() AS DATE),
            :ID_recette,
            :ID_utilis
            )";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute(array(
            "note" => $formvars['note'],
            "description" => $formvars['description'],
            "ID_recette" => (int)$formvars['ID_recette'],
            "ID_utilis" => (int)$formvars['ID_utilis']
        ));    
}

function updateReviewIntoDB($formvars){
    $query = "UPDATE note_util_rc
            SET
            note = :note,
            description = :description,
            date_note = CAST(NOW() AS DATE)
            WHERE ID_recette = :ID_recette AND ID_utilis = :ID_utilis";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute(array(
            "note" => $formvars['note'],
            "description" => $formvars['description'],
            "ID_recette" => $formvars['ID_recette'],
            "ID_utilis" => $formvars['ID_utilis']));    
}
?>
