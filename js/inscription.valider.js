var frmvalidator  = new Validator("inscription");
frmvalidator.EnableOnPageErrorDisplay();
frmvalidator.EnableMsgsTogether();
frmvalidator.addValidation("nom","req","Veuillez renseigner votre nom");
frmvalidator.addValidation("prenom","req","Veuillez renseigner votre prénom");
frmvalidator.addValidation("email","req","Veuillez renseigner votre adresse email");
frmvalidator.addValidation("email","email","Veuillez renseigner une adresse email valide");
frmvalidator.addValidation("mdp","req","Veuillez renseigner un mot de passe");

