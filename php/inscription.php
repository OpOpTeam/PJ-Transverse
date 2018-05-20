<?PHP
require_once("db-config.php");
if(!isset($_POST['submitted']))
{
   return false;
}

$formvars = array();    
$formvars['nom_utilis'] = test_input($_POST['nom']);
$formvars['prenom_utilis'] = test_input($_POST['prenom']);
$formvars['ad_mail'] = test_input($_POST['email']);
$formvars['mot_d_passe'] = test_input($_POST['mdp']);
if (isset($_POST['vegetarien']) == true){
    $formvars['vegetarien'] = test_input($_POST['vegetarien']);
}
else {
    $formvars['vegetarien'] = 0;
}
if (isset($_POST['halal']) == true){
    $formvars['halal'] = test_input($_POST['halal']);
}
else {
    $formvars['halal'] = 0;
}

if (isset($_POST['vegan']) == true){
    $formvars['vegan'] = test_input($_POST['vegan']);
}
else {
    $formvars['vegan'] = 0;
}


if(estUnique($formvars, 'ad_mail') == false){
    header("Location: ../existeDeja.php");
}
else{
    insertIntoDB($formvars);
    header("Location: ../bienvenue.php");
}



function estUnique($formvars,$fieldname){
    $query = "SELECT ".$fieldname." FROM utilisateur WHERE ".$fieldname."='".$formvars[$fieldname]."'";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute();
    // Set the resulting array to associative
    $count = $reponse->fetchColumn();   
    if(!empty ($count)){
        return false;
    }
    return true;
}


function insertIntoDB($formvars){
    $query = "INSERT INTO utilisateur (
            nom_utilis,
            prenom_utilis,
            mot_d_passe,
            vegetarien,
            halal,
            vegan,
            ad_mail)
            VALUES
            (
            :nom_utilis,
            :prenom_utilis,
            :mot_d_passe,
            :vegetarien,
            :halal,
            :vegan,
            :ad_mail
            )";
    $reponse = dbLogin()->prepare($query);
    $reponse->execute(array(
            "nom_utilis" => $formvars['nom_utilis'],
            "prenom_utilis" => $formvars['prenom_utilis'],
            "mot_d_passe" => $formvars['mot_d_passe'],
            "vegetarien" => $formvars['vegetarien'],
            "halal" => $formvars['halal'],
            "vegan" => $formvars['vegan'],
            "ad_mail" => $formvars['ad_mail']));    
}
?>
