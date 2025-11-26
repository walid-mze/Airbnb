<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@page import="java.util.ArrayList, java.util.List,model.Offer,model.Accommodation,model.User,java.text.SimpleDateFormat,java.util.Calendar,java.util.GregorianCalendar"%>


<!DOCTYPE html>
<html>
<head>
<title>ProfilExterne</title>
</head>

<%@include file="/WEB-INF/header.jsp"%>
<body>
<%@include file="/WEB-INF/alertMessage.jsp"%>

<% 
SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy");
User extUser = (User)request.getAttribute("extUser");													 
%>

<div class="container" style="margin-top:2em;">
        <div class="row">
            <div class="col-12">
                <div class="card">

                    <div class="card-body">
                        <div class="card-title mb-4">
                            <div class="d-flex justify-content-start">
                                <div class="userData ml-3">
                                    <h2 class="d-block" style="font-size: 1.5rem; font-weight: bold"><% out.print( extUser.getFirstname() ); %> <% out.print( extUser.getName() ); %></h2>
                                    <h6 class="d-block">inscrit le <% out.print( sdf.format(extUser.getDate().getTime() )); %></h6>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-12">
                            
								<ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
								  <li class="nav-item" role="presentation">
								    <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#infos" type="button" role="tab" aria-controls="infos-tab" aria-selected="true">Informations personelles</button>
								  </li>
								  <li class="nav-item" role="presentation">
								    <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#offers" type="button" role="tab" aria-controls="offers-tab" aria-selected="false">Offres de l'utilisateur</button>
								  </li>
								</ul>
									<div class="tab-content" id="pills-tabContent">
										<div class="tab-pane fade show active" id="infos" role="tabpanel" aria-labelledby="infos-tab">
                                        
                                        <div class="row" style="margin-top:1em;">
                                            <div class="col-sm-3 col-md-2 col-5">
                                                <label style="font-weight:bold;">Adresse Mail</label>
                                            </div>
                                            <div class="col-md-8 col-6">
												<% out.print( extUser.getMailAddress() ); %>
                                            </div>
                                        </div>
                                        <hr />

                                        <div class="row">
                                            <div class="col-sm-3 col-md-2 col-5">
                                                <label style="font-weight:bold;">Téléphone</label>
                                            </div>
                                            <div class="col-md-8 col-6">
                                                <% out.print( extUser.getPhoneNumber() ); %>
                                            </div>
                                        </div>
                                        <hr />

                                    </div>
  										<div class="tab-pane fade" id="offers" role="tabpanel" aria-labelledby="offers-tab">
                                        				
						                  <table class="table table-striped">
											<thead>
												<tr>
													<th scope="col">Logement</th>
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
											List<Offer> offers = (List<Offer>)request.getAttribute("extUserOffers");
											 
						    					for(Offer offer : offers) { 
						    					%>
						    						<tr>
														<td><% out.print( offer.getAccommodation().getId() ); %></td>
														<td><% out.print( sdf.format(offer.getStartAvailability().getTime()) ); %></td>
														<td><% out.print( sdf.format(offer.getEndAvailability().getTime()) ); %></td>
														<td><% out.print( offer.getPricePerNight() );  %></td>
														<td><% out.print( offer.getCleaningFee() ); %></td>
														<td style="text-align:right; padding-right:1em;">
											                <div class="btn-group">
											                	<a href="${pageContext.request.contextPath}/offer?id=<% out.print(offer.getId()); %>" class="btn btn-sm btn-outline-secondary">
											                  		Voir l'offre
											                  	</a>
											                </div>
														</td>
													</tr>
													
													<% } %>
											</tbody>
										</table>			
                                    </div>
                                    
                                </div>
                            </div>
                        </div>


                    </div>

                </div>
            </div>
        </div>
    </div>
</body>
</html>