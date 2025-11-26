<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<!DOCTYPE html>
<html>
<head>
<title>S'enregistrer</title>
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
<% User editUser = (User)request.getAttribute("user"); %>

<div class="card" style="margin:2em; margin-left:20em; margin-right:20em">

	<div class="card-header" style="text-align: center">
	  	<% if (editUser == null) { %>
    		<h4>Créer un compte</h4>
    			
    	<% } else { %>
    		<h4>Modification d'un utilisateur</h4>
    	<% } %>
	</div>
  
	<div class="card-body" style="padding:1em">
		<form action="${pageContext.request.contextPath}/register" method="post" oninput='pass2.setCustomValidity(pass2.value != pass.value ? "Les mots de passe ne sont pas identiques." : "")'>

  			<div class="form-group">
	  			<label for="inputMail">Adresse de courriel</label>
	  			<input type="email" class="form-control" id="inputMail" name="mail"
	  			<% if (editUser == null) { out.print("placeholder=\"example@example.com\" required"); } 
	  			else { out.print("value=\"" + editUser.getMailAddress() + "\" readonly"); }%>>
			</div>
			
			<div class="form-group">
	  			<label for="inputName">Nom</label>
	  			<input type="text" class="form-control" id="inputName" name="name" placeholder="Robert" 
	  			value="<% if (user != null) { out.print( editUser.getName() ); } %>" required>
			</div>
			
			<div class="form-group">
	  			<label for="inputFirstname">Prénom</label>
	  			<input type="text" class="form-control" id="inputFirstname" name="firstname" placeholder="André" 
	  			value="<% if (user != null) { out.print( editUser.getFirstname() ); } %>" required>
			</div>
			
			<div class="form-group">
	  			<label for="inputPhone">Numéro de téléphone</label>
	  			<input type="text" class="form-control" id="inputPhone" name="phone" placeholder="01 23 45 67 89" 
	  			value="<% if (user != null) { out.print( editUser.getPhoneNumber() ); } %>" required>
			</div>
			
			<% if (editUser == null) { %>
			<div class="form-group">
		  		<label for="inputPassword">Mot de passe</label>
	  			<input type="password" class="form-control" id="inputPassword" name="pass" required>
			</div>
			
			<div class="form-group">
		  		<label for="inputPassword2">Confirmer le mot de passe</label>
	  			<input type="password" class="form-control" id="inputPassword2" name="pass2" required>
			</div>
			<% } %>
			
			<div class="text-center">
				<button class="btn btn-outline-success" type="submit">Enregistrer</button>
			</div>
			
		</form>
 	</div> 	
</div>
</body>
</html>