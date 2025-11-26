<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.util.ArrayList, java.util.List,model.Accommodation,model.Offer,model.Booking,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
	<title>Admin - Recherche Avancée</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

</head>
<%@include file="/WEB-INF/header.jsp"%>
	<body>
	
		<%@include file="/WEB-INF/alertMessage.jsp"%>
	
		<div class="card shadow p-3 mb-5 bg-body rounded" style="margin-top: 2em; margin-left: 6em; margin-right: 6em;">
			<div class="card-body table-responsive">
				<div class="card-header">
					<h3>Recherche tous les élements associés à un utilisateur :</h3>	
				</div>
				
				<form class="row g-3" action="${pageContext.request.contextPath}/adminSearch" method="post" style="padding: 1em;">		
						<div class="col col-md-10">
							<div class="form-floating">
						  		<input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="searchInput" required>
						  		<label for="floatingInput">Adresse mail</label>
							</div>
						</div>
												  
						<div class="col col-md-2 d-grid gap-2">
							<button type="submit" class="btn btn-primary btn-lg"><span class="bi bi-search" style="margin-right: 1em;"></span> Rechercher </button>
						</div>

				</form>
				
			</div>
		</div>	
		
		<% 					
		@SuppressWarnings("unchecked")
		List<Accommodation> accommodations = (List<Accommodation>)request.getAttribute("accommodations");
		
		if (accommodations != null && accommodations.size() != 0) { 
		%>
			<div class="card " style="margin:3em;">
				<div class="card-body table-responsive">
					<div class="card-header">
						<div class="row align-items-center">
							<div class="col">
								<h2>Logement</h2>				
							</div>
						</div>
					</div>
	
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col">Utilisateur</th>
								<th scope="col">Nom</th>
								<th scope="col">Adresse</th>
								<th scope="col">Type</th>
								<th scope="col">Capacité</th>
								<th scope="col">Pièce(s)</th>
								<th scope="col">Description</th>
							</tr>
						</thead>
	
						<tbody id="resultTable">
						
						<% for(Accommodation accommodation : accommodations) { %>
	    					<tr>
								<th scope="row"><% out.print(accommodation.getId()); %></th>
								<td><% out.print(accommodation.getUser().getMailAddress()); %></td>
								<td><% out.print(accommodation.getName()); %></td>
								<td><% out.print(accommodation.getAddress()); %></td>
								<td><% out.print(accommodation.getType()); %></td>
								<td><% out.print(accommodation.getCapacity()); %></td>
								<td><% out.print(accommodation.getNumberOfRooms()); %></td>
								<td><% out.print(accommodation.getDescription()); %></td>
							</tr>
						<% } %>
					</tbody>
				</table>	
			</div>
		</div>
		<% }
		
		@SuppressWarnings("unchecked")
		List<Offer> offers = (List<Offer>)request.getAttribute("offers");
					
		SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
		
		if (offers != null && offers.size() != 0) {
		%>
			<div class="card" style="margin:3em;">
			<div class="card-body table-responsive">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">
							<h2>Offre</h2>
						</div>
					</div>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">Logement</th>
							<th scope="col">Utilisateur</th>
							<th scope="col">Début disponiblité</th>
							<th scope="col">Fin disponibilité</th>
							<th scope="col">Prix / Nuit</th>
							<th scope="col">Frais de ménage</th>
						</tr>
					</thead>

					<tbody id="resultTable">
					
					<% for(Offer offer : offers) { %>
    						<tr>
								<th scope="row"><% out.print(offer.getId()); %></th>
								<td><% out.print( offer.getAccommodation().getId() ); %></td>
								<td><% out.print( offer.getUser().getMailAddress() ); %></td>
								<td><% out.print( sdf.format(offer.getStartAvailability().getTime()) ); %></td>
								<td><% out.print( sdf.format(offer.getEndAvailability().getTime()) ); %></td>
								<td><% out.print( offer.getPricePerNight() );  %></td>
								<td><% out.print( offer.getCleaningFee() ); %></td>
							</tr>
							
							<% } %>
					</tbody>
				</table>
			</div>
		</div>	
		
		<% }
		@SuppressWarnings("unchecked")
		List<Booking> bookings = (List<Booking>)request.getAttribute("bookings");
		
		sdf = new SimpleDateFormat("'Le' dd/MM/yyyy 'à' hh:mm");
		
		if (bookings != null && bookings.size() != 0) {
		%>
		
		<div class="card" style="margin:3em;">
			<div class="card-body table-responsive">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">
							<h2>Réservation</h2>				
						</div>
					</div>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">ID</th>
							<th scope="col">ID Offre</th>
							<th scope="col">Utilisateur</th>
							<th scope="col">Date Réservation</th>
							<th scope="col">Date Arrivé</th>
							<th scope="col">Date Départ</th>
							<th scope="col">Personne(s)</th>
							<th scope="col">Prix Total</th>
						</tr>
					</thead>

					<tbody id="resultTable">
					
					<% for(Booking booking : bookings) { %>
    						<tr>
								<th scope="row"><% out.print(booking.getId()); %></th>
								<td><% 
								if (booking.getOffer() != null) {
									out.print(booking.getOffer().getId()); 
								} else {
									out.print("Offre supprimée");
								}%></td>
								<td><% out.print(booking.getUser().getMailAddress()); %></td>
								<td><% out.print(sdf.format(booking.getBookingDate())); %></td>
								<td><% out.print(sdf.format(booking.getArrivalDate())); %></td>
								<td><% out.print(sdf.format(booking.getDepartureDate())); %></td>
								<td><% out.print(booking.getNbPerson()); %></td>
								<td><% out.print(booking.getTotalPrice() + " ¤");
									if (booking.getTransaction() != null) { %>
										<span class="badge rounded-pill bg-success" style="margin-left: 4px;">Payée</span>
									<% } else { %>
										<span class="badge rounded-pill bg-danger" style="margin-left: 4px;">Non payée</span>
									<% } %>

								</td>
							</tr>
							<% } %>
					</tbody>
				</table>
			</div>
		</div>
		
		<% } %>	
		
	</body>
</html>