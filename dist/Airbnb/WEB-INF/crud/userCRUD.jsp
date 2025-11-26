<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<%@ page import="java.util.ArrayList, java.util.List,model.User,java.text.SimpleDateFormat,java.util.GregorianCalendar"%>

<!DOCTYPE html>
<html>
<head>
	<title>CRUD - Utilisateurs</title>
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
							<h2>Utilisateur</h2>				
						</div>
						<div class="col-auto">
							<input id="searchInput" class="form-control" type="text" placeholder="Rechercher">
						</div>
					</div>
				</div>

				<table class="table table-striped">
					<thead>
						<tr>
							<th scope="col">Mail</th>
							<th scope="col">Prénom</th>
							<th scope="col">Nom</th>
							<th scope="col">Phone</th>
							<th scope="col">Type</th>
							<th scope="col">Date de création</th>
							<th scope="col" style="text-align:right; padding-right:1em;">Actions</th>
						</tr>
					</thead>

					<tbody id="resultTable">
	  			
					<% 
					@SuppressWarnings("unchecked")
					List<User> users = (List<User>)request.getAttribute("users");
					
		  			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");	
		  		    Calendar calendar = new GregorianCalendar();
 
    					for(User user1 : users) { 
    					%>
    						<tr>
								<th scope="row"><% out.print(user1.getMailAddress()); %></th>
								<td><% out.print(user1.getFirstname()); %></td>
								<td><% out.print(user1.getName()); %></td>
								<td><% out.print(user1.getPhoneNumber()); %></td>
								<td><% out.print(user1.getUserType()); %></td>
								<td><% out.print(sdf.format(user1.getDate().getTime())); %></td>
	
								<td style="text-align:right; padding-right:1em; ">
									<form action="${pageContext.request.contextPath}/userCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="edit">
										<input type="hidden" name="index" value="<% out.print(users.indexOf(user1)); %>">
										<button style="background: none; padding: 0px; border: none;" type="submit">
											<i class="bi bi-pencil-fill" style="color:orange"></i>
										</button>
									</form>
									
									<form action="${pageContext.request.contextPath}/userCRUD" method="post" style="display: inline-block;">
										<input type="hidden" name="action" value="delete">
										<input type="hidden" name="index" value="<% out.print(users.indexOf(user1)); %>">
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
	  					<a href="${pageContext.request.contextPath}/userCRUD">
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