<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<title>Profil</title>
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
<%
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
%>
<div class="card" style="margin:2em; margin-left:20em; margin-right:20em">
	<div class="card-header">
    	<h4>Inscrit depuis le <% out.print(sdf.format(user.getDate().getTime())); %></h4>
  	</div>
  	
  	<div class="card-body" style="padding:1em">
  		<form action="${pageContext.request.contextPath}/profile" method="post">
  			<input type="hidden" name="type" value="info">
			<div class="row form-group">
				<div class="col-md-6">
					<label for="inputName">Nom</label>
					<input type="text" class="form-control" id="inputName" name="name" placeholder="<% out.print(user.getName()); %>">
				</div>
			    			
				<div class="col-md-6">
					<label for="inputFirstname">Prénom</label>
					<input type="text" class="form-control" id="inputFirstname" name="firstname" placeholder="<% out.print(user.getFirstname()); %>">
				</div>
			</div>
			<div class="row form-group">
				<div>
					<label for="inputPhone">Numéro de téléphone</label>
					<input type="text" class="form-control" id="inputPhone" name="phone" placeholder="<% out.print(user.getPhoneNumber()); %>">
				</div>
			</div>
			<div class="text-center">
				<button class="btn btn-primary" type="submit">Enregistrer les changements</button>
			</div>
		</form>
	</div>
</div>

<div class="card" style="margin:2em; margin-left:20em; margin-right:20em">
	<div class="card-header">
    	<h4>Changer mon mot de passe</h4>
  	</div>
  	
  	<div class="card-body" style="padding:1em">
  		<form action="${pageContext.request.contextPath}/profile" method="post" oninput='newPass2.setCustomValidity(newPass2.value != newPass.value ? "Les mots de passe ne sont pas identiques." : "")'>
  			<input type="hidden" name="type" value="password">
			<div class="row form-group">
				<div>
					<label for="inputPassword">Mot de passe actuel</label>
					<input type="password" class="form-control" id="inputPassword" name="pass" required>
				</div>
			</div>
			<div class="row form-group">
				<div class="col-md-6">
					<label for="inputNewPassword">Nouveau mot de passe</label>
					<input type="password" class="form-control" id="inputNewPassword" name="newPass" required>
				</div>
				<div class="col-md-6">
					<label for="inputNewPassword2">Confirmer le nouveau mot de passe</label>
					<input type="password" class="form-control" id="inputNewPassword2" name="newPass2" required>
				</div>
			</div>
			<div class="text-center">
				<button class="btn btn-primary" type="submit">Changer</button>
			</div>
		</form>
	</div>
</div>
			
<br />

<div class="row" style="margin:2em; margin-left:20em; margin-right:20em">
	<div class="col-sm-4">
    	<div class="card">
    		<div class="card-body">
		        <h5 class="card-title" style="text-align:center">Gérer mes biens</h5>
		        <div class="text-center">
		        	<a href="${pageContext.request.contextPath}/accommodationCRUD" class="btn btn-primary">Aller</a>
		        </div>
      		</div>
    	</div>
  	</div>
  	<div class="col-sm-4">
    	<div class="card">
      		<div class="card-body">
        		<h5 class="card-title" style="text-align:center">Gérer mes offres</h5>
        		<div class="text-center">
        			<a href="${pageContext.request.contextPath}/offerCRUD" class="btn btn-primary">Aller</a>
        		</div>
      		</div>
    	</div>
  	</div>
  	<div class="col-sm-4">
    	<div class="card">
      		<div class="card-body">
        		<h5 class="card-title" style="text-align:center">Voir mes réservations</h5>
        		<div class="text-center">
        			<a href="${pageContext.request.contextPath}/bookingCRUD" class="btn btn-primary">Aller</a>
        		</div>
      		</div>
    	</div>
  	</div>
</div>
</body>
</html>