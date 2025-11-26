<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<!DOCTYPE html>
<html>
<head>
<title>Connexion</title>
</head>
<style>
.form-group  {
	margin-bottom: 1em;
}

label {
	margin-bottom: 0.3em;
}
</style>
<%@include file="/WEB-INF/header.jsp"%>
<body>
<%@include file="/WEB-INF/alertMessage.jsp"%>
<div class="card" style="margin:2em; margin-left:20em; margin-right:20em">
	<div class="card-header" style="text-align: center">
 		<h4>Connexion</h4>
	</div>
  
	<div class="card-body" style="padding:1em">
		<form action="${pageContext.request.contextPath}/login" method="post">
		
  			<div class="form-group">
	  			<label for="inputMail">Adresse de courriel</label>
	  			<input type="email" class="form-control" id="inputMail" name="mail" placeholder="example@example.com" required>
			</div>
			
			<div class="form-group">
		  		<label for="inputPassword">Mot de passe</label>
	  			<input type="password" class="form-control" id="inputPassword" name="pass" required>
			</div>
			
			<div class="text-center">
				<button class="btn btn-outline-success" type="submit">Se connecter</button>
			</div>
			
		</form>
 	</div> 	
</div>
</body>
</html>