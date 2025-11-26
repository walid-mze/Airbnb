<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.3.0/font/bootstrap-icons.css">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/image/favicon.ico" />
	<title>Booking web app</title>
</head>
<%@include file="header.jsp"%>
<body>
	<div class="d-flex justify-content-center" style="margin-top: 8em;">
		<h1>Oups!</h1>
	</div>
	<div class="d-flex justify-content-center">
	    <h5>Une erreur est survenue</h5>
	 </div>      
	 <div class="d-flex justify-content-center" style="margin-top: 1em;">       
	    <div>
	    	<a href="${pageContext.request.contextPath}/home">
				<button type="button" class="btn btn-primary"><span class="bi bi-house-door-fill"></span> Page d'accueil </button>
			</a>		
		</div>
	</div>

</body>
</html>