<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.util.ArrayList, java.util.List,model.Accommodation,model.Picture"%>

<!DOCTYPE html>
<html>
<head>
	<title>CRUD - Logement</title>
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
							<h2>Logement</h2>				
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
							<% } %>
							
							<th scope="col">Nom</th>
							<th scope="col">Adresse</th>
							<th scope="col">Type</th>
							<th scope="col">Capacité</th>
							<th scope="col">Pièce(s)</th>
							<th scope="col">Description</th>
							<th scope="col">Règlement</th>
							<th scope="col" style="text-align:right; padding-right:1em;">Actions</th>
						</tr>
					</thead>

					<tbody id="resultTable">
					
					<% 
					@SuppressWarnings("unchecked")
					List<Accommodation> accommodations = (List<Accommodation>)request.getAttribute("accommodations");
 
    					for(Accommodation accommodation : accommodations) { 
    						List<Picture> pictures = accommodation.getPictures();
    						
    						if (pictures == null) {
    							System.out.println("No pictures for " + accommodation.getId());
    							
    						} else {
        						System.out.println("Pictures for " + accommodation.getId() + " ");
    						}

    					%>
    						<tr>
    							<% if (user.getUserType().equals("Admin")) { %>
									<th scope="row"><% out.print(accommodation.getId()); %></th>
									<td><% out.print(accommodation.getUser().getMailAddress()); %></td>
								<% } %>
								
								<td><% out.print(accommodation.getName()); %></td>
								<td><% out.print(accommodation.getAddress()); %></td>
								<td><% out.print(accommodation.getType()); %></td>
								<td><% out.print(accommodation.getCapacity()); %></td>
								<td><% out.print(accommodation.getNumberOfRooms()); %></td>
								<td><% out.print(accommodation.getDescription()); %></td>
								<td><% out.print(accommodation.getHouseRules()); %></td>
								<td style="text-align:right; padding-right:1em;">

									<form action="${pageContext.request.contextPath}/accommodationCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="edit">
										<input type="hidden" name="index" value="<% out.print(accommodations.indexOf(accommodation)); %>">
										<button style="background: none; padding: 0px; border: none;" type="submit">
											<i class="bi bi-pencil-fill" style="color:orange"></i>
										</button>
									</form>
									
									<form action="${pageContext.request.contextPath}/accommodationCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="delete">
										<input type="hidden" name="index" value="<% out.print(accommodations.indexOf(accommodation)); %>">
											<button data-bs-toggle="tooltip" data-bs-placement="top" title="Supprime également les offres associées" style="background: none; padding: 0px; border: none;" type="submit">
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
	  					<a href="${pageContext.request.contextPath}/addAccommodation">
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