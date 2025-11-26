<html>
	<head>
		<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.css">
	</head>
	
	<body>
		<% 
			String alertType = (String)request.getAttribute("alertType");
			String alertMessage = (String)request.getAttribute("alertMessage");
			
			if (alertType != null && alertMessage != null) { %>
				
				<div class="alert <% out.print(alertType); %> alert-dismissible fade show" role="alert" style="margin:2em; margin-left:5em; margin-right:5em">
  					<strong><% out.print(alertMessage); %></strong>
  					<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
				</div>
				
			<% } %>
    					

	</body>
</html>
