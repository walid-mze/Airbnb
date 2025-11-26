<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@page import="java.util.List,model.Accommodation"%>
<!DOCTYPE html>
<html>
<head>
<title>Ajout de pièces</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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
	
  		<div class="card-header">
    		<h4>Ajouter une pièce</h4>
  		</div>
  
 		<div class="card-body" style="padding:1em">
 			<h5>Informations générales</h5>
 			  			
	    	<form action="${pageContext.request.contextPath}/addRooms" method="post">
	    	
	    		<script>
	    			var rooms = ["bedroom", "bathroom", "kitchen"]
		    		function showOnly(id) {
	    	        	var state = document.getElementById(id).style.display;
    	        		if (state == 'none') {
    	        			for (i=0 ; i<rooms.length ; i++) {
    	        				if (rooms[i] !== id) {
    	        					document.getElementById(rooms[i]).style.display = 'none';
    	        				}
    	        			}
    	        			document.getElementById(id).style.display = '';
    	        		}
		    	    } 
	  			</script>
	  			
	  			<div class="form-group">
	    			<label for="accommodationTypeSelector">Vos logements</label>
	    			<select class="form-control" id="accommodationSelector" name="accommodationIndex">
	    			<% 
					@SuppressWarnings("unchecked")
					List<Accommodation> accommodations = (List<Accommodation>)request.getAttribute("accommodations");
 
    					for(Accommodation accommodation : accommodations) {
    					%>
	      				<option value="<% out.print(accommodations.indexOf(accommodation)); %>"><% out.print(accommodation.getName()); %></option>
	      				<%
    					} 
    					%>
	    			</select>
	  			</div>
	  			
				<div class="form-group">
	    			<label for="roomTypeSelector">Type de pièce</label>
	    			<select class="form-control" id="roomTypeSelector" name="type" onchange="showOnly(value);" required>
	      				<option value="bedroom">Chambre</option>
	      				<option value="bathroom">Salle de bain</option>
	      				<option value="kitchen">Cuisine</option>
	    			</select>
	  			</div>
	  			
	  			<h5>Equipements</h5>
	  			
	  			<div id="bedroom">
	  				<div class="row row-cols-lg-auto g-3 align-items-center">
	  					<div class="col-12">
	      					<label class="sr-only" for="inputSingleBedNumber">Nombre de couchage 1 place</label>
	      					<input type="number" class="form-control" id="inputSingleBedNumber" name="singleBedNumber" min="0" step="1" value=0>
	    				</div>
						<div class="col-12">
	      					<label class="sr-only" for="inputDoubleBedNumber">Nombre de couchage 2 places</label>
	      					<input type="number" class="form-control" id="inputDoubleBedNumber" name="doubleBedNumber" min="0" step="1" value=0>
	    				</div>
	  				</div>
	  				
	  				<br />
	  				
    				<div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="checkbox" id="tvCheckbox" value="tv" name="bedroomAmenities">
						  <label class="form-check-label" for="tvCheckbox">TV</label>
						</div>
						<div class="form-check form-check-inline">
						  <input class="form-check-input" type="checkbox" id="closetCheckbox" value="closet" name="bedroomAmenities">
						  <label class="form-check-label" for="tvCheckbox">Penderie</label>
						</div>
    				</div>
	  			</div>
	  			
	  			<div id="bathroom" style="display:none;">
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="bathtubCheckbox" value="bathtub" name="bathroomAmenities">
					  <label class="form-check-label" for="bathtubCheckbox">Baignoire</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="showerCheckbox" value="shower" name="bathroomAmenities">
					  <label class="form-check-label" for="showerCheckbox">Douche</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="washingMachineCheckbox" value="washingMachine" name="bathroomAmenities">
					  <label class="form-check-label" for="washingMachineCheckbox">Machine à laver</label>
					</div>
	  			</div>
	  			
	  			<div id="kitchen" style="display:none;">
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="ovenCheckbox" value="oven" name="kitchenAmenities">
					  <label class="form-check-label" for="ovenCheckbox">Four</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="freezerCheckbox" value="freezer" name="kitchenAmenities">
					  <label class="form-check-label" for="freezerCheckbox">Congélateur</label>
					</div>
					<div class="form-check form-check-inline">
					  <input class="form-check-input" type="checkbox" id="coffeeMakerCheckbox" value="coffeeMaker" name="kitchenAmenities">
					  <label class="form-check-label" for="coffeeMakerCheckbox">Cafetière</label>
					</div>
	  			</div>
	  			
	  			<br />
	
	  			<button class="btn btn-outline-success d-flex justify-content-end" type="submit">Ajouter</button>
			</form>			
  		</div>	
	</div>
	
	<div class="text-center">
		<a href="${pageContext.request.contextPath}/accommodationCRUD" class="btn btn-outline-info my-2 my-sm-0 mr-sm-2" role="button">Terminer</a>
	</div>
</body>
</html>