<%@ page import="java.util.*" import="model.User" session ="true" %>
<%@ page language="java" pageEncoding="ISO-8859-15"%>
<head>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/image/favicon.ico" />
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
	<script src="${pageContext.request.contextPath}/js/bootstrap.js"></script>
	<title>Booking web app</title>
</head>

<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding:1em;">
    
    	<div class="container-fluid">
		    <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            	<img src="${pageContext.request.contextPath}/image/favicon.ico" width="30" height="30" class="d-inline-block align-top">
            		Booking web app
        	</a>
		    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
		      	<span class="navbar-toggler-icon"></span>
		    </button>
		    
		    <% User user = (User) request.getSession().getAttribute("user"); %>
		    		        
		    <div class="collapse navbar-collapse" id="navbarNavDropdown">
		      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
		      
		      		<% if (user != null) { %>
				        <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            CRUD
			          </a>
			          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/accommodationCRUD">Logement</a></li>
			            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/offerCRUD">Offre</a></li>
			            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/bookingCRUD">Réservation</a></li>
			          </ul>
			        </li>
			        
			        <% if (user.getUserType().equals("Admin")) { %>
		    		<li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			            Administration
			          </a>
			          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
			          	<li><a class="dropdown-item" href="${pageContext.request.contextPath}/userCRUD">CRUD Utilisateur</a></li>
			            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/adminSearch">Recherche Avancée Utilisateur</a></li>
			          </ul>
			        </li>
		    		<% } %>
			       
			       <% } %>
		      </ul>
		      
		        	<% if (user == null) { %>
			    		<div class="btn-group" role="group" aria-label="Basic example">
							<a href="${pageContext.request.contextPath}/login">
		       					<button class="btn btn-outline-success my-2 my-sm-0 mr-sm-2" type="submit">Connexion</button>
							</a>
				       		<a href="${pageContext.request.contextPath}/register">
				       			<button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="margin-left:1em;">Créer un compte</button>
							</a>
						</div>
		    		<% } else { %>   
		    			<% if (user.getUserType().equals("Admin")) { %>
		    				<span class="badge rounded-pill bg-danger" style="margin-right: 1em;">Admin</span>
		    			<% } %>
		    			<div class="btn-group" role="group" aria-label="Basic example">		    				
							<a href="${pageContext.request.contextPath}/profile">
								<button class="btn btn-outline-info my-2 my-sm-0 mr-sm-2" type="submit">Profil</button>
							</a>
							<a href="${pageContext.request.contextPath}/wallet">
								<button class="btn btn-outline-secondary my-2 my-sm-0 mr-sm-2" type="submit" style="margin-left:1em;"><% out.println(user.getBalance() + " ¤"); %></button>
							</a>
				       		<a href="${pageContext.request.contextPath}/logout">
				       			<button class="btn btn-outline-success my-2 my-sm-0" type="submit" style="margin-left:1em;">Déconnexion</button>
							</a>
						</div>
		    		<% } %> 
		    </div>
		  </div>
        
    </nav>
</body>