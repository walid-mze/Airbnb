<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="model.Accommodation"%>

<!DOCTYPE html>
<html>
<head>
<title>Ajout d'un logement</title>
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
	Accommodation accommodation = (Accommodation)request.getAttribute("accommodation"); 
	
	if (request.getAttribute("pictureForm") == null) {
	%>
	
	<div class="card" style="margin:2em; margin-left:5em; margin-right:5em">
	
  		<div class="card-header">
  			<% if (accommodation == null) { %>
    			<h4>Ajouter un nouveau logement (1/2)</h4>
    			
    		<% } else { %>
    			<h4>Modification d'un logement</h4>
    		<% } %>
  		</div>
  
 		<div class="card-body" style="padding:1em">
 			<h5>Informations générales :</h5>
 			  			
	    	<form action="${pageContext.request.contextPath}/addAccommodation" method="post">
	    		<div class="form-group">
	    			<label for="inputName">Nom du logement</label>
	    			<input type="text" class="form-control" id="inputName" name="name" placeholder="Studio entier à Paris proche de Nation"
					value="<% if (accommodation != null) { out.print(accommodation.getName()); } %>" required>
	  			</div>
	  			
				<div class="form-group">
	    			<label for="accommodationTypeSelector">Type de logement</label>
	    			<select class="form-control" id="accommodationTypeSelector" name="type" required>
	      				<option
	      				<% if (accommodation != null) { out.print( accommodation.getType().equals("Appartement") ? "selected" : "" ); } %>>Appartement</option>
	      				
	      				<option
	      				<% if (accommodation != null) { out.print( accommodation.getType().equals("Maison")  ? "selected" : "" ); } %>>Maison</option>
	      				
	      				<option
	      				<% if (accommodation != null) { out.print( accommodation.getType().equals("Chambre dans un appartement")  ? "selected" : "" ); } %>>Chambre dans un appartement</option>
	      				
	      				<option
	      				<% if (accommodation != null) { out.print(accommodation.getType().equals("Chambre dans une maison")  ? "selected" : "" ); } %>>Chambre dans une maison</option>
	    			</select>
	  			</div>
	  			
	  			<div class="row form-group">
	    			<div class="col">
	      				<label for="inputCapacity">Capacité (nombre de couchages)</label>
	      				<input type="number" min="1" step="1" class="form-control" id="inputCapacity" name="capacity" placeholder="1"
	      				value="<% if (accommodation != null) { out.print(accommodation.getCapacity()); } %>" required>
	    			</div>
	    			<div class="col">
	      				<label for="inputRoomNumber">Nombre de pièces</label>
	      				<input type="number" min="1" step="1" class="form-control" id="inputRoomNumber" name="numberOfRooms" placeholder="1" 
	      				value="<% if (accommodation != null) { out.print(accommodation.getNumberOfRooms()); } %>" required>
	    			</div>
	  			</div>
	  			
	  			<div class="form-group">
	    			<label for="inputAddress">Numéro et voie</label>
	    			<input type="text" class="form-control" id="inputAddress" name="address" placeholder="92 Boulevard de Prague" 
	    			value="<% if (accommodation != null) { out.print(accommodation.getAddress().getStreetAndNumber()); } %>" required>
	  			</div>
	  			
	  			<div class="form-group">
	    			<label for="inputAddress2">Complément d'adresse</label>
	    			<input type="text" class="form-control" id="inputAddress2" name="addressComplement" placeholder="Appartement 116"
	    			value="<% if (accommodation != null && accommodation.getAddress().getComplement() != null) {
	    				out.print(accommodation.getAddress().getComplement()); 
	    			} %>">
	  			</div>	
	  			
	  			<div class="row form-group">
	    			<div class="col-md-6">
	      				<label for="inputCity">Ville</label>
	      				<input type="text" class="form-control" id="inputCity" name="city" placeholder="Paris"
	      				value="<% if (accommodation != null) { out.print(accommodation.getAddress().getCity()); } %>" required>
	    			</div>
	    			
	    			<div class="col-md-2">
	      				<label for="inputZipCode">Code postal</label>
	      				<input type="text" class="form-control" id="inputZipCode" name="zipCode" placeholder="75001" 
	      				value="<% if (accommodation != null) { out.print(accommodation.getAddress().getPostalCode()); } %>" required>
	    			</div>
	    			
	   				<div class="col-md-4">
	      				<label for="inputCountry">Pays</label>
	      				<input type="text" class="form-control" id="inputCountry" name="country" placeholder="France" 
	      				value="<% if (accommodation != null) { out.print(accommodation.getAddress().getCountry()); } %>" required>
	    			</div>
	  			</div>
	  			
	  			<div class="form-group">
	    			<label for="descriptionTextArea">Description</label>
	    			<textarea class="form-control" id="descriptionTextArea" name="description" rows="3" required><% if (accommodation != null) { out.print(accommodation.getDescription()); } %></textarea>
	  			</div>
	  			
	  			<hr class="solid">
	  			<h5>Règlement intérieur :</h5>
	  			
	  			<div class="row form-group">
	    			<div class="col">
	      				<label for="inputArrivalHour">Heure minimum d'arrivée</label>
	      				<input type="time" class="form-control" id="inputArrivalHour" name="arrivalHour" 
	      				value="<% if (accommodation != null) { out.print(accommodation.getHouseRules().getArrivalHour()); } %>" required>
	    			</div>
	    			<div class="col">
	      				<label for="inputDepartureHour">Heure maximum de départ</label>
	      				<input type="time" class="form-control" id="inputDepartureHour" name="departureHour"
	      				value="<% if (accommodation != null) { out.print(accommodation.getHouseRules().getDepartureHour()); } %>" required>
	    			</div>
	  			</div>
	  			
	  			<div class="form-check form-check-inline">
	  				<input class="form-check-input" type="checkbox" id="petAllowedCheckbox" name="petAllowed"
	  				<% if (accommodation != null) { out.print( accommodation.getHouseRules().isPetAllowed() ? "checked" : "" ); } %>>
	  				<label class="form-check-label" for="petAllowedCheckbox">Animaux autorisés</label>
				</div>
				<div class="form-check form-check-inline">
  					<input class="form-check-input" type="checkbox" id="partyAllowedCheckbox" name="partyAllowed"
  					<% if (accommodation != null) { out.print( accommodation.getHouseRules().isPartyAllowed() ? "checked" : "" ); } %>>
  					<label class="form-check-label" for="partyAllowedCheckbox">Fêtes autorisées</label>
				</div>
				<div class="form-check form-check-inline">
  					<input class="form-check-input" type="checkbox" id="smokeAllowedCheckbox" name="smokeAllowed"
  					<% if (accommodation != null) { out.print( accommodation.getHouseRules().isSmokeAllowed() ? "checked" : "" ); } %>>
  					<label class="form-check-label" for="smokeAllowedCheckbox">Logement fumeur</label>
				</div>

	  			<button class="btn btn-outline-success d-flex justify-content-end" type="submit">Enregistrer</button>
			</form>
  		</div>	
	</div>
	
	<% } else { %>
	      
	<div class="card" style="margin:2em; margin-left:5em; margin-right:5em">
  		<div class="card-header">
  			<h4>Ajouter un nouveau logement (2/2)</h4>
  		</div>
  
 		<div class="card-body" style="padding:1em">
 			<h5>Photos du logement :</h5> 	
 			
	        <form method="post" action="${pageContext.request.contextPath}/addAccommodation" enctype="multipart/form-data">
	            <label for="formFileMultiple" class="form-label">Sélectionner les images (Minimum 1) :</label>
	            <input type="file" class="form-control" name="multiPartServlet" accept="image/*" id="formFileMultiple" multiple required/>
	            <button type="submit" class="btn btn-outline-success d-flex justify-content-end" style="margin-top: 1em;">Enregistrer</button>    
	        </form>
  		</div>	
	</div>
	<% } %>
	
</body>
</html>