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


$allergies = array();
if (isset($_POST['gluten']) == true){
    $allergies[] = test_input($_POST['gluten']);
}
if (isset($_POST['crustace']) == true){
    $allergies[] = test_input($_POST['crustace']);
}
if (isset($_POST['oeuf']) == true){
    $allergies[] = test_input($_POST['oeuf']);
}
if (isset($_POST['poisson']) == true){
    $allergies[] = test_input($_POST['poisson']);
}
if (isset($_POST['arachide']) == true){
    $allergies[] = test_input($_POST['arachide']);
}
if (isset($_POST['soja']) == true){
    $allergies[] = test_input($_POST['soja']);
}
if (isset($_POST['lait']) == true){
    $allergies[] = test_input($_POST['lait']);
}
if (isset($_POST['fruit-a-coques']) == true){
    $allergies[] = test_input($_POST['fruit-a-coques']);
}
if (isset($_POST['celeri']) == true){
    $allergies[] = test_input($_POST['celeri']);
}
if (isset($_POST['moutarde']) == true){
    $allergies[] = test_input($_POST['moutarde']);
}
if (isset($_POST['sesame']) == true){
    $allergies[] = test_input($_POST['sesame']);
}
if (isset($_POST['mollusque']) == true){
    $allergies[] = test_input($_POST['mollusque']);
}

if(estUnique($formvars, 'ad_mail') == false){
    header("Location: ../existeDeja.php");
}
else{
    insertIntoDB($formvars, $allergies);
    //header("Location: ../bienvenue.php");
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


function insertIntoDB($formvars, $allergies){
    $pdo = dbLogin();
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
    $reponse = $pdo->prepare($query);
    $reponse->execute(array(
            "nom_utilis" => $formvars['nom_utilis'],
            "prenom_utilis" => $formvars['prenom_utilis'],
            "mot_d_passe" => $formvars['mot_d_passe'],
            "vegetarien" => $formvars['vegetarien'],
            "halal" => $formvars['halal'],
            "vegan" => $formvars['vegan'],
            "ad_mail" => $formvars['ad_mail']));
    $lastId = $pdo->lastInsertId();

    foreach ($allergies as $element) {
        $query2 = "INSERT INTO est_allergique_all_util (
            ID_all,
            ID_utilis)           
            VALUES
            (
            :ID_all,
            :ID_utilis 
            )";
            echo $query2;
        $reponse2 = dbLogin()->prepare($query2);
        $reponse2->execute(array(
            "ID_all" => $element,
            "ID_utilis" => $lastId));

    }
     
}
?>
