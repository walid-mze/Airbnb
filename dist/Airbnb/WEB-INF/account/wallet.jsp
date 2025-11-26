<%@ page language="java" contentType="text/html; charset=ISO-8859-15"%>
<!DOCTYPE html>
<html>
<head>
<title>Mon portefeuille</title>
</head>
<style>
.form-group  {
	margin-bottom: 1em;
}

label {
	margin-bottom: 0.3em;
}
</style>
<%@include file="/WEB-INF/header.jsp"%>
<body>
<%@include file="/WEB-INF/alertMessage.jsp"%>
<div class="card" style="margin:2em; margin-left:40em; margin-right:40em">
	<div class="card-header">
    	<h4>Solde du compte : <% out.print(user.getBalance()); %> ¤</h4>
  	</div>
  	
  	<div class="card-body" style="padding:1em">
  		<form action="${pageContext.request.contextPath}/wallet" class="form-inline" method="post">
			<label class="sr-only" for="inputAmount">Montant</label>
			<div class="input-group mb-2 mr-sm-2">
				<div class="input-group-prepend">
	          		<div class="input-group-text">¤</div>
	        	</div>
				<input class="form-control mb-2 mr-sm-2" id="inputAmount" type="number" min="10" step="10" placeholder="10" name="amount" required>
			</div>
			<div class="text-center">
				<button class="btn btn-outline-success" type="submit">Créditer</button>
			</div>
		</form>
	</div>
</div>

</body>
</html>