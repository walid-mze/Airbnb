<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="model.Offer,model.Accommodation,model.Room,model.Amenity,model.Picture,java.text.SimpleDateFormat,java.util.Calendar,function.textTools"%>

<!DOCTYPE html>
<html>
	<head>
		<title>Offre logement</title>
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
		
		<style>
		.form-group  {
			margin-bottom: 1em;
		}
		
		label {
			margin-bottom: 0.3em;
		}
		</style>

	</head>
	
	<%@include file="/WEB-INF/header.jsp"%>

	<body>
	
		<%@include file="/WEB-INF/alertMessage.jsp"%>
		
		<div class="card" style="margin:2em; margin-left:10em; margin-right:10em">
		
			<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
			
				<div class="carousel-indicators">
				<%
				Offer offer = (Offer)request.getAttribute("offer");
				Accommodation accommodation = offer.getAccommodation();
				
				List<Picture> pictures = accommodation.getPictures();
				
				boolean firstItem = true;
				
				for (int i = 0; i < pictures.size(); i++) { %>
				   	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to=" <% out.print(i); %>" <% out.print("class=\"active\" aria-current=\"true\""); %> aria-label="Slide"></button>
				<% } %>
				</div>
				  
				<div class="carousel-inner">
				<%
				firstItem = true;
				
				for (Picture picture : pictures) { %>
				    <div class="carousel-item <% if(firstItem) { 
				    	firstItem = false;
				    	out.print("active"); 
				    	} %>">
				      	<img src="<% out.print(request.getContextPath() + "/imgServ?filename=" + picture.getUrl()); %>" class="d-block w-100 card-img-top" style="object-fit: cover; width: 100%; height: 450px;" alt="...">
				    </div>   
				<% } %>
				</div>
				  
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators"  data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				</button>
			</div>
			
			  
			<div class="card-body">
			
				<%				
				@SuppressWarnings("unchecked")
				List<Room> rooms = (List<Room>)request.getAttribute("rooms");
				
				@SuppressWarnings("unchecked")
				List<List<Amenity>> allAmenity = (List<List<Amenity>>)request.getAttribute("allAmenity");
				
				%>
    					
				<div class="container">
					<div class="row">
					
				    	<div class="col-sm-8">
				    		<h3 class="card-title">
				    			<% out.print(accommodation.getName()); %>
				    		</h3>
				    		
				    		<hr class="solid">
				    		
				    		<div class="d-grid gap-1">
							  	<div class="p-1">
							  		<h5 style="display:inline;"><i class="bi bi-house-door"></i></h5>
				    				<h6 style="display:inline;"><% out.print(accommodation.getType()); %></h6>
				    			</div>
				    			
								<div class="p-1">
							  		<h5 style="display:inline;"><i class="bi bi-geo-alt"></i></h5>
				    				<h6 style="display:inline;">Paris, France</h6>
				    			</div>
				    			
				    			<div class="p-1">
							  		<h5 style="display:inline;"><i class="bi bi-file-text"></i></h5>
				    				<p class="card-text" style="display:inline;"><% out.print(accommodation.getDescription()); %></p>
				    			</div>
							</div>
						

						
						<% if(rooms != null && allAmenity != null) { %>
						
							<hr class="solid">
							<h4>Pièces (<% out.print(rooms.size()); %>) :</h4>
								
							<%
							// Get iterators in order to do two foreach at the same time
							Iterator<Room> roomsIterator = rooms.iterator();
							Iterator<List<Amenity>> allAmenityIterator = allAmenity.iterator();
							
							while(roomsIterator.hasNext() && allAmenityIterator.hasNext()) {
								Room room = roomsIterator.next();
								List<Amenity> amenities = allAmenityIterator.next(); %>
							
								<div class="card" style="margin-bottom:1em;">
								  <div class="card-body">
								    <h5 class="card-title">
					    				<img src="<% out.print(request.getContextPath() + "/svg/" + room.getType() + ".svg"); %>" alt="Bed icon" height="20px" width="20px" style="vertical-align: -3px;" />
					    				<% out.print(textTools.getTextFromDBEntry(room.getType())); %>
					    			</h5>
								    <p class="card-text"><b>Équipements: </b> 
								    
								    <% 
								    Iterator<Amenity> amenityIterator = amenities.iterator();
								    
									while (amenityIterator.hasNext()) {
										out.print(textTools.getTextFromDBEntry(amenityIterator.next().getName()));
										
										if (amenityIterator.hasNext()) { out.print(", "); }
									} %>
									
								  </div>
								</div>

							<% 
							} 
						} 
						%>
			    			
							<% if (accommodation.getHouseRules() != null) { %>
								<hr class="solid">
							
								<h4>Règlement du logement :</h4>
								
								<div class="d-grid gap-1">
								  	<div class="p-1">
								  		<img src="${pageContext.request.contextPath}/svg/clock.svg" alt="Clock icon" height="20px" width="20px" style="vertical-align: -4px; margin-right:3px;" />
					    				<h6 style="display:inline;">Heure d'arrivée : Après <% out.print(accommodation.getHouseRules().getArrivalHour()); %> - 
										Heure de départ : Avant <% out.print(accommodation.getHouseRules().getDepartureHour()); %></h6>
					    			</div>
					    			
									<div class="p-1">
								  		<img src="${pageContext.request.contextPath}/svg/pet.svg" alt="Pet icon" height="20px" width="20px" style="vertical-align: -4px; margin-right:3px;" />
					    				<h6 style="display:inline;">Animaux autorisés : <% out.print(textTools.getTextFromBool(accommodation.getHouseRules().isPetAllowed())); %></h6>
					    			</div>
					    			
									<div class="p-1">
								  		<img src="${pageContext.request.contextPath}/svg/party.svg" alt="Party icon" height="20px" width="20px" style="vertical-align: -4px; margin-right:3px;" />
					    				<h6 style="display:inline;">Fêtes autorisées : <% out.print(textTools.getTextFromBool(accommodation.getHouseRules().isPartyAllowed())); %></h6>
					    			</div>
					    			
					    			<div class="p-1">
								  		<img src="${pageContext.request.contextPath}/svg/smoke.svg" alt="Smoke icon" height="20px" width="20px" style="vertical-align: -4px; margin-right:3px;" />
					    				<h6 style="display:inline;">Logement fumeur : <% out.print(textTools.getTextFromBool(accommodation.getHouseRules().isSmokeAllowed())); %></h6>
					    			</div>
								</div>
							<% } %>
						
			    		</div>
			    	
				    	<div class="col-sm-4">
				    		<div class="card shadow p-3 mb-5 bg-body rounded">
				    		  		<div class="card-header">
				    		  			<h5 class="card-title">Réservation</h5>
  									</div>
						  		<div class="card-body">
						  		
						    		<div class="d-grid gap-1">
									  <div class="p-1">
									  	<h6 style="display:inline;"><i class="bi bi-cash"></i></h6>
						    			<h6 style="display:inline;">Prix par nuit : <% out.print(offer.getPricePerNight()); %> ¤</h6>
						    		</div>
						    		
									  <div class="p-1">
									  	<h6 style="display:inline;"><i class="bi bi-bucket"></i></h6>
						    			<h6 style="display:inline;">Frais de ménage : <% out.print(offer.getCleaningFee()); %> ¤</h6>
						    			</div>
									</div>
						
						  		
						  			<hr class="solid">
						  			
			  				  			<%
							  			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");	
							  		    Calendar startAvailability = offer.getStartAvailability();
							  		  	Calendar endAvailability = offer.getEndAvailability();
							  			%>
							  		
							    		<p class="card-text">Sélectionnez vos dates de réservations :</p>
						    		
						    		<form action="${pageContext.request.contextPath}/offer" method="post">
							    		<div class="row g-3" style="margin-bottom: 0.5em;">
											  <div class="col col-md-7">
											  	<label for="inputArrivalDate">Arrivé</label>
							      				<input type="date" class="form-control" id="inputArrivalDate" name="arrivalDate" 
							      					min="<% out.print(sdf.format(startAvailability.getTime())); %>"
							      					max="<% out.print(sdf.format(endAvailability.getTime())); %>" required>
											  </div>
											  
											  <div class="col col-md-5">
							      				<label for="inputArrivalTime">Heure</label>
							      				<input type="time" class="form-control" id="inputArrivalTime" name="arrivalTime" 
							      					min="<% if (accommodation.getHouseRules() != null) { 
							      								out.print(accommodation.getHouseRules().getArrivalHour()); 
							      							} else {
							      								out.print("00:00");
							      							}
							      					%>"
							      					max="23:59" required>
											  </div>
										</div>
										
										<div class="row g-3" style="margin-bottom: 0.5em;">
											  <div class="col col-md-7">
							      				<label for="inputDepartureDate">Départ</label>
							      				<input type="date" class="form-control" id="inputDepartureDate" name="departureDate" 
							      					min="<% out.print(sdf.format(startAvailability.getTime())); %>" 
							      					max="<% out.print(sdf.format(endAvailability.getTime())); %>" required>
											  </div>
											  
											  <div class="col col-md-5">
							      				<label for="inputDepartureTime">Heure</label>
							      				<input type="time" class="form-control" id="inputDepartureTime" name="departureTime" 
							      					min="00:00"
							      					max="<% if (accommodation.getHouseRules() != null) { 
							      								out.print(accommodation.getHouseRules().getDepartureHour()); 
							      							} else {
							      								out.print("23:59");
							      							}
							      					%>" required>
											  </div>
										</div>
							    			
							  			<div class="form-group">
							    			<label for="nbPersonSelector">Nombre de voyageur(s)</label>
							    			<select class="form-control" id="nbPersonSelector" name="nbPerson" required>
							    				<% for(int i = 1; i <= accommodation.getCapacity(); i++) { %>
							      					<option><% out.print(i); %></option>
							      				<% } %>
							    			</select>
							  			</div>
	  			
	  									<div class="d-grid gap-2">
											<button class="btn btn-success" type="submit">Réserver</button>
										</div>
						    		
						    		</form>


						  		</div>
							</div>		    
				    	</div>
				    	
					</div>
				</div>
			</div>
		
		</div>
		
	</body>
</html>