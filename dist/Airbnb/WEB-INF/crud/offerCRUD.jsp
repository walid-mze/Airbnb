<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.util.ArrayList, java.util.List,model.Offer,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
	<title>CRUD - Offre</title>
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
	
</head>
<%@include file="/WEB-INF/header.jsp"%>
	<body>
	
		<div class="card" style="margin:2em;">
			<div class="card-body table-responsive">
				<div class="card-header">
					<div class="row align-items-center">
						<div class="col">
							<h2>Offre</h2>
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
								<th scope="col">Utilisateur</th>
								<th scope="col">ID Logement</th>
								
							<% } else { %>
								<th scope="col">Nom Logement</th>
							<% } %>
							
							<th scope="col">Début disponiblité</th>
							<th scope="col">Fin disponibilité</th>
							<th scope="col">Prix / Nuit</th>
							<th scope="col">Frais de ménage</th>
							<th scope="col" style="text-align:right; padding-right:1em;">Actions</th>
						</tr>
					</thead>

					<tbody id="resultTable">
					
					<% 
					@SuppressWarnings("unchecked")
					List<Offer> offers = (List<Offer>)request.getAttribute("offers");
					
					SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
 
    					for(Offer offer : offers) { 
    					%>
    						<tr>
    							<% if (user.getUserType().equals("Admin")) { %>
									<th scope="row"><% out.print(offer.getId()); %></th>
									<td><% out.print( offer.getUser().getMailAddress() ); %></td>
									<td><% out.print( offer.getAccommodation().getId() ); %></td>
									
								<% } else { %>
								
									<td><% out.print( offer.getAccommodation().getName() ); %></td>
								<% } %>

								<td><% out.print( sdf.format(offer.getStartAvailability().getTime()) ); %></td>
								<td><% out.print( sdf.format(offer.getEndAvailability().getTime()) ); %></td>
								<td><% out.print( offer.getPricePerNight() + " ¤" ); %></td>
								<td><% out.print( offer.getCleaningFee() + " ¤" ); %></td>
								<td style="text-align:right; padding-right:1em;">
								
									<a href="${pageContext.request.contextPath}/offer?id=<% out.print(offer.getId()); %>" class="text-decoration-none">
										<i class="bi bi-eye-fill" style="color: dodgerblue; padding-right:1em;"></i>
									</a>
									
									<form action="${pageContext.request.contextPath}/offerCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="edit">
										<input type="hidden" name="index" value="<% out.print(offers.indexOf(offer)); %>">
										<button style="background: none; padding: 0px; border: none;" type="submit">
											<i class="bi bi-pencil-fill" style="color:orange"></i>
										</button>
									</form>
									
									<form action="${pageContext.request.contextPath}/offerCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="delete">
										<input type="hidden" name="index" value="<% out.print(offers.indexOf(offer)); %>">
										<button  style="background: none; padding: 0px; border: none;" type="submit">
											<i class="bi bi-trash-fill" style="color:red; padding-left:1em;"></i>
										</button>
									</form>
								</td>
							</tr>
							
							<% } %>
					</tbody>
				</table>
				
				<div>
					<div style="float: left;">
	  					<a href="${pageContext.request.contextPath}/addOffer">
							<button type="button" class="btn btn-success">
								<span class="bi bi-plus"></span> Ajouter
							</button>
						</a>			
					</div>
				</div>
			</div>
		</div>	
	</body>
</html>