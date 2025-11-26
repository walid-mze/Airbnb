<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@page import="java.util.ArrayList, java.util.List,model.Accommodation,model.Offer,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar"%>

<!DOCTYPE html>
<html>
<head>
<title>Ajout d'une offre</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
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
	Offer offer = (Offer)request.getAttribute("offer"); 
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
	Calendar calendar = new GregorianCalendar();
	System.out.println(sdf.format(calendar.getTime()));
	%>
	
	<div class="card" style="margin:2em; margin-left:5em; margin-right:5em">
  		<div class="card-header">
  		  	<% if (offer == null) { %>
    			<h4>Ajouter une nouvelle offre de location</h4>
    			
    		<% } else { %>
    			<h4>Modification d'une offre de location</h4>
    		<% } %>
  		</div>
  
 		<div class="card-body" style="padding:1em">
	    	<form action="${pageContext.request.contextPath}/addOffer" method="post">	  			
				<div class="form-group">
					<% if (offer == null) { %>
		    			<label for="accommodationTypeSelector">Vos logements</label>
		    			<select class="form-control" id="accommodationSelector" name="accommodationIndex">
		    			<% 
						@SuppressWarnings("unchecked")
						List<Accommodation> accommodations = (List<Accommodation>)request.getAttribute("accommodations");
	 
	    				for(Accommodation accommodation : accommodations) { %>
		      				
		      				<option value="<% out.print(accommodations.indexOf(accommodation)); %>"><% out.print(accommodation.getName()); %></option>
		      			<% } %>
		    			</select>
		    		<% } else { %>
		    		
		    			<div class="form-group">
	    					<label for="inputName">Nom du logement</label>
	    					<input type="text" class="form-control" id="inputName" name="name" value="<% out.print(offer.getAccommodation().getName()); %>" readonly>
	  					</div>
		    		<% } %>
	  			</div>

	  			<div class="row form-group">
	    			<div class="col">
	      				<label for="inputStartAvailability">Date début de disponibilité</label>
	      				<input type="date" class="form-control" id="inputStartAvailability" name="startAvailability" 
	      					min="<% out.print(sdf.format(calendar.getTime())); %>" 
	      					value="<% if (offer != null) { out.print( sdf.format(offer.getStartAvailability().getTime())); } %>" required>
	    			</div>
	    			<div class="col">
	      				<label for="inputEndAvailability">Date fin de disponibilité</label>
	      				<input type="date" class="form-control" id="inputEndAvailability" name="endAvailability" 
	      					min="<% out.print(sdf.format(calendar.getTime())); %>" 
	      					value="<% if (offer != null) { out.print( sdf.format(offer.getEndAvailability().getTime())); } %>" required>
	    			</div>
	  			</div>
	  			
	  			<div class="form-group">
	    			<label for="inputPricePerNight">Prix par nuit</label>
	    			<input type="number" min="0" step="0.01" class="form-control" id="inputPricePerNight" name="pricePerNight" placeholder="25 ¤" 
	    			value="<% if (offer != null) { out.print( offer.getPricePerNight() ); } %>" required>
	  			</div>
	  			
	  			<div class="form-group">
	    			<label for="inputCleaningFee">Frais de ménage (Facturés une seule fois)</label>
	    			<input type="number" min="0" step="0.01" class="form-control" id="inputCleaningFee" name="cleaningFee" placeholder="20 ¤" 
	    			value="<% if (offer != null) { out.print( offer.getCleaningFee() ); } %>" required>
	  			</div>
	  			
	  			<button class="btn btn-outline-success justify-content-end" type="submit">Enregistrer</button>
			</form>
  		</div>	
	</div>
</body>
</html>