<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@page import="java.util.ArrayList, java.util.List,model.Offer,model.Accommodation,model.User,model.Picture,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">
</head>
<%@include file="header.jsp"%>
<body>


<%
SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");	
Calendar calendar = new GregorianCalendar();
%> 	
                

<div class="container-fluid px-1 px-sm-4 mx-auto" style="background-image: url('${pageContext.request.contextPath}/image/background<% out.print((int)(Math.random() * ((8 - 1) + 1)) + 1); %>.jpg'); background-size: cover; background-position: center; width: 100%; height: auto; padding-top: 12em; padding-bottom: 10em; padding-left: 2em; padding-right:2em;">
    <div class="row d-flex justify-content-center">
        <div class="col-md-10 col-lg-9 col-xl-8">
            <div class="card shadow-lg p-3 mb-5 rounded">
                <div class="card-header bg-white">
                    <h4 class="mb-1">Trouvez l'hébergement de vos rêves</h4> 
                    <small class="text-muted">Du gîte champêtre cosy à l'appartement citadin design</small>
                </div>
                
		        <form action="${pageContext.request.contextPath}/displaySearch" method="get">
			        <div class="row g-3">
			        	<div class="col-md-3">	
			        		<label style="margin: 0.2em;">Adresse</label>
			               	<input type="text" class="form-control" name="ville" placeholder="Où allez-vous ?" required>
			            </div>
						
			            <div class="col-md-3">
			                <label style="margin: 0.2em;">Arrivée</label>
				    		<input type="date" class="form-control" name="startStay" min="<% out.print(sdf1.format(calendar.getTime())); %>" required>
			            </div>
			            
			            <div class="col-md-3">
				      		<label style="margin: 0.2em;">Départ</label>
				      		<input type="date" class="form-control" name="endStay" min="<% out.print(sdf1.format(calendar.getTime())); %>" required>
			            </div>
			            
			            <div class="col-md-2">
			               	<label style="margin: 0.2em;">Voyageurs</label>
							<input type="number" min="1" max="10" step="1" class="form-control" name="capacity" placeholder="1" required>
						</div>
			            
			            <div class="col-md-1 d-grid gap-2">
			            	<label> </label>
			                <button type="submit" class="btn btn-success"><span class="bi bi-search"></span></button>
			            </div>
			        </div>
		        </form>
    		</div>
        </div>
    </div>
</div>

<%
SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");	
 
@SuppressWarnings("unchecked")
List<Offer> offers = (List<Offer>) request.getAttribute("offers");
	
String searchType = (String) request.getAttribute("searchType"); 
%>

<div class="album py-5 bg-light">
    <div class="container">
    
    <% if( searchType.equals("default") ) { %>
    	<h2>Dernières offres publiées</h2>
    	
    <% } else if( searchType.equals("new") ) { %>
    	<h2>Offres correspondantes à votre recherche</h2>
    <% } %>  
    
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
      	
      	<% 
      	
      		for (Offer offer : offers) { 
      			List<Picture> pictures = offer.getAccommodation().getPictures();
      			%>
      	
		        <div class="col">
		          <div class="card shadow-sm">
		          	<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
						<div class="carousel-indicators">
						<% 	
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
						      	<img src="<% out.print(request.getContextPath() + "/imgServ?filename=" + picture.getUrl()); %>" class="d-block w-100 card-img-top" style="object-fit: cover; width: 100%; height: 15em;" alt="...">
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
		            <a href="${pageContext.request.contextPath}/offer?id=<% out.print(offer.getId()); %>" style="color: black; text-decoration: none;">
		            	<h4 class="mb-1"><% out.print( offer.getAccommodation().getAddress().getCity() ); %></h4>
		            </a>	
		              <p class="card-text">
		              Déposée par <a href="${pageContext.request.contextPath}/profile?mailAddress=<% out.print(offer.getUser().getMailAddress()); %>" 
		              	style="color: black; text-decoration: none; font-weight: bold;">
		              	<% out.print( offer.getAccommodation().getUser().getFirstname() );%> <% out.print( offer.getAccommodation().getUser().getName() );%>
		              	</a>
		              </p>
		              <p>Disponible du <% out.print( sdf2.format(offer.getStartAvailability().getTime()) ); %> au <% out.print( sdf2.format(offer.getEndAvailability().getTime()) ); %></p>
		              <div class="d-flex justify-content-between align-items-center">
		                <div class="btn-group">
		                	<a href="${pageContext.request.contextPath}/offer?id=<% out.print(offer.getId()); %>" class="btn btn-sm btn-outline-secondary">
		                  		Voir l'offre
		                  	</a>
		                </div>
		                <div class="btn-group">
		                	<a href="${pageContext.request.contextPath}/profile?mailAddress=<% out.print(offer.getUser().getMailAddress()); %>" class="btn btn-sm btn-outline-secondary">
		                  		Profil de l'hôte
		                  	</a>
		                </div>
		                <small class="text-muted"><% out.print( offer.getPricePerNight() );  %> ¤/nuit</small>
		              </div>
		            </div>
		          </div>
		        </div>
		        
       		<% } %> 
       
      </div>
    </div>
  </div>

</body>
</html>