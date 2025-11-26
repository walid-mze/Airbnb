<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.util.ArrayList, java.util.List,model.Booking,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
	<title>CRUD - Réservation</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js"></script>
	
	<script>
		$(document).ready(function(){
		  $("#searchInput").on("keyup", function() {
		    var value = $(this).val().toLowerCase();
		    $("#resultTable tr").filter(function() {
		      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
		    });
		  });
		});
	</script>
	
	<style type="text/css">
	
	.btn-group-xs > .btn, .btn-xs {
	  padding: .25rem .4rem;
	  font-size: .875rem;
	  line-height: .5;
	  border-radius: .2rem;
	}

	</style>

</head>
<%@include file="/WEB-INF/header.jsp"%>
	<body>
		<%@include file="/WEB-INF/alertMessage.jsp"%>
		
		<div class="card" style="margin:2em;">
			<div class="card-body table-responsive">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">
							<h2>Réservation</h2>				
						</div>
						<div class="col-auto">
							<input id="searchInput" class="form-control" type="text" placeholder="Rechercher">
						</div>
					</div>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<% if (user.getUserType().equals("Admin")) { %>
								<th scope="col">ID</th>
								<th scope="col">ID Offre</th>
								<th scope="col">Utilisateur</th>
								
							<% } else { %>
								<th scope="col">Nom du logement</th>
							<% } %>
							
							<th scope="col">Date de réservation</th>
							<th scope="col">Date d'arrivée</th>
							<th scope="col">Date de départ</th>
							<th scope="col">Personne(s)</th>
							<th scope="col">Prix Total</th>
						</tr>
					</thead>

					<tbody id="resultTable">
					
					<% 
					@SuppressWarnings("unchecked")
					List<Booking> bookings = (List<Booking>)request.getAttribute("bookings");
					
					SimpleDateFormat sdf = new SimpleDateFormat("'Le' dd/MM/yyyy 'à' hh:mm");
 
    				for(Booking booking : bookings) { 
    				%>
    						<tr>
    							<% if (user.getUserType().equals("Admin")) { %>
									<th scope="row"><% out.print(booking.getId()); %></th>
									
									<td><% 
										if (booking.getOffer() != null) {
											out.print(booking.getOffer().getId()); 
										} else {
											out.print("Offre supprimée");
										} %>
									</td>
									
									<td><% 
										if (booking.getUser() != null) {
											out.print(booking.getUser().getMailAddress()); 
										} else {
											out.print("Utilisateur suprimé");
										} %>
									</td>
									
								<% } else { %>
								<th>
								
									<% if (booking.getOffer() != null && booking.getOffer().getAccommodation() != null) {
											out.print(booking.getOffer().getAccommodation().getName());
										} else {
											out.print("Offre suprimée");
										}
									%>
									</th>
								<% } %>
								
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
	</body>
</html>