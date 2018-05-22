<?php
require_once("php/db-config.php");
require_once("php/login-check.php");
require_once("php/init-session.php");
?>

<!DOCTYPE HTML>
<!--
	Aesthetic by gettemplates.co
	Twitter: http://twitter.com/gettemplateco
	URL: http://gettemplates.co
-->
<html>
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Ch'Efrei</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

  	<meta property="og:title" content=""/>
	<meta property="og:image" content=""/>
	<meta property="og:url" content=""/>
	<meta property="og:site_name" content=""/>
	<meta property="og:description" content=""/>
	<meta name="twitter:title" content="" />
	<meta name="twitter:image" content="" />
	<meta name="twitter:url" content="" />
	<meta name="twitter:card" content="" />

	<link href="https://fonts.googleapis.com/css?family=Lato:300,400,700" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css?family=Kaushan+Script" rel="stylesheet">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="css/icomoon.css">
	<!-- Themify Icons-->
	<link rel="stylesheet" href="css/themify-icons.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="css/bootstrap.css">

	<!-- Magnific Popup -->
	<link rel="stylesheet" href="css/magnific-popup.css">

	<!-- Bootstrap DateTimePicker -->
	<link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">

	<!-- Owl Carousel  -->
	<link rel="stylesheet" href="css/owl.carousel.min.css">
	<link rel="stylesheet" href="css/owl.theme.default.min.css">

	<!-- Theme style  -->
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/style2.css">

	<!-- Modernizr JS -->
	<script src="js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	</head>
	<body>
		
	<div class="gtco-loader"></div>
	
	<div id="page">

	
	<!-- <div class="page-inner"> -->
	<?php
		include ("include/navbar.php");
	?>
	
	<header id="gtco-header" class="gtco-cover gtco-cover-sm" role="banner" style="background-image: url(images/img_bg_2.jpg)" data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="gtco-container">
			<div class="row">
				<div class="col-md-12 col-md-offset-0 text-left">	
					<div class="row row-mt-14em">
						<div class="col-md-12 mt-text animate-box" data-animate-effect="fadeInUp">
							<h1 class="cursive-font text-center primary-color">Ch'Efrei</h1>
							<h1 class="cursive-font text-center">Rejoignez la communauté !</h1>		
						</div>
					</div>				
				</div>
			</div>
		</div>
	</header>

	
	
	<div class="gtco-section">
		<div class="gtco-container">
			<div class="col-md-offset-2 col-md-8 animate-box">
				<h1 class="primary-color cursive-font">Inscription</h1>
				<form id="inscription" action="php/inscription.php" method="post">
					<input type="hidden" name="submitted" id="submitted" value="1">
					<div class="row form-group">
						<div class="col-md-4">
							<label class="primary-color">Nom</label>
							<input type="text" name="nom" id="nom" class="form-control" placeholder="Votre nom" required>
						</div>
						<div class="col-md-8">
							<label class="primary-color">Prénom</label>
							<input type="text" name="prenom" id="prenom" class="form-control" placeholder="Votre prénom" required>
						</div>						
					</div>

					<div class="row form-group">
						<div class="col-md-12">
							<label class="primary-color">Email</label>
							<input type="email" name="email" id="email" class="form-control" placeholder="Votre adresse email" required>
							<span id="inscription_email_errorloc" class="insciption-erreur"></span>
						</div>
					</div>

					<div class="row form-group">
						<div class="col-md-12">
							<label class="primary-color">Mot de passe</label>
							<input type="password" name="mdp" id="mdp" class="form-control" placeholder="Votre mot de passe" required>
						</div>
					</div>

					<div class="row form-group">
						<div class="col-md-4">
							<label class="primary-color">Vos restrictions alimentaires</label>
						</div>
						<div class="col-md-8">
							<label class="checkbox-inline">
								<input type="checkbox" name="vegetarien" value="1">Végétarien<br>
							</label>
							<label class="checkbox-inline">
	  							<input type="checkbox" name="vegan" value="1">Vegan<br>
	  						</label>
	  						<label class="checkbox-inline">
	  							<input type="checkbox" name="halal" value="1">Halal<br>
	  						</label>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-md-4">
							<label class="primary-color">Vos allergies</label>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="gluten" value="1">Gluten<br>
							</label>
						</div>
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="crustace" value="2">Crustacé<br>
							</label>
						</div>	
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="oeuf" value="3">Oeuf<br>
							</label>
						</div>					
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="poisson" value="4">Poisson<br>
							</label>
						</div>
					</div>
					<div class="row form-group">
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="arachide" value="5">Arachide<br>
							</label>
						</div>	
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="soja" value="6">Soja<br>
							</label>
						</div>
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="lait" value="7">Lait<br>
							</label>
						</div>
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="fruit-a-coques" value="8">Fruit à coques<br>
							</label>
						</div>
					</div>
					<div class="row form-group">	
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="celeri" value="9">Céleri<br>
							</label>
						</div>
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="moutarde" value="10">Moutarde<br>
							</label>
						</div>
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="sesame" value="11">Sésame<br>
							</label>
						</div>	
						<div class="col-md-3">
							<label class="checkbox-inline">
								<input type="checkbox" name="mollusque" value="12">Mollusque<br>
							</label>
						</div>						
					</div>

					<div class="form-group">
						<input type="submit" value="S'inscrire" class="btn btn-primary">
					</div>
				</form>					
			</div>

		</div>
	</div>
	
	<?php
		include ("include/container-valeurs.php");
	?>

	<?php
		include ("include/footer.php");
	?>

	<?php
		include ("include/modal-login-form.php");
	?>

	</div>

	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	
	<!-- jQuery -->
	<script src="js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="js/jquery.waypoints.min.js"></script>
	<!-- Carousel -->
	<script src="js/owl.carousel.min.js"></script>
	<!-- countTo -->
	<script src="js/jquery.countTo.js"></script>

	<!-- Stellar Parallax -->
	<script src="js/jquery.stellar.min.js"></script>

	<!-- Magnific Popup -->
	<script src="js/jquery.magnific-popup.min.js"></script>
	<script src="js/magnific-popup-options.js"></script>
	
	<script src="js/moment.min.js"></script>
	<script src="js/bootstrap-datetimepicker.min.js"></script>


	<!-- Main -->
	<script src="js/main.js"></script>

	</body>
	
</html>

