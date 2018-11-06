<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="en">


<head>
	<title>List Customers</title>
	
	<!-- reference our style sheet -->
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link type="text/css"
		  rel="stylesheet"
		  href="${pageContext.request.contextPath}/resources/css/style.css" />

</head>

<body>
	
	
	<nav class="navbar navbar-default">
  		<div class="container-fluid">
    		<div class="navbar-header">
      			<a class="navbar-brand" href="#">CRM - Customer Relationship Manager</a>
   			</div>
   			<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
    		<ul class="nav navbar-nav">
      			<li class="active" onclick="window.location.href='showFormForAdd'; return false;"><a href="#">Add Customer</a></li>
     			<li><a href="#">TBA</a></li>
      			<li><a href="#">TBA</a></li>
     			<li><a href="#">TBA</a></li>
    		</ul>
    		</security:authorize>
  		</div>
	</nav>

		
	
   
  			<div class="well well-sm">
				<p>
					User: <security:authentication property="principal.username" />, Role(s): <security:authentication property="principal.authorities" />
				</p>
			</div>

			
			<!--  add our html table here -->
		
			<table class="table">
				<thead class="thead-inverse">
				<tr>
				 	<th scope="col">#</th>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Email</th>
					
					<%-- Only show "Action" column for managers or admin --%>
					<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
					
						<th>Action</th>
					
					</security:authorize>
					
				</tr>
				</thead>
				
				<!-- loop over and print our customers -->
				<c:forEach var="tempCustomer" items="${customers}" varStatus="theCount">
				
					<!-- construct an "update" link with customer id -->
					<c:url var="updateLink" value="/customer/showFormForUpdate">
						<c:param name="customerId" value="${tempCustomer.id}" />
					</c:url>					

					<!-- construct an "delete" link with customer id -->
					<c:url var="deleteLink" value="/customer/delete">
						<c:param name="customerId" value="${tempCustomer.id}" />
					</c:url>					
				<tbody>
						<thead class="thead-inverse">
							<tr>
								<th scope="row" > ${theCount.count}  </th>
								<td> ${tempCustomer.firstName} </td>
								<td> ${tempCustomer.lastName} </td>
								<td> ${tempCustomer.email} </td>
							</tr>
						</thead>
						

						<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
						
							<td>
								<security:authorize access="hasAnyRole('MANAGER', 'ADMIN')">
									<!-- display the update link -->
									<a href="${updateLink}">Update</a>
								</security:authorize>
	
								<security:authorize access="hasAnyRole('ADMIN')">
									|
									<a href="${deleteLink}"
									   onclick="if (!(confirm('Are you sure you want to delete this customer?'))) return false">Delete</a>
								</security:authorize>
							</td>

						</security:authorize>
												
				</tbody>
				</c:forEach>
			 		
			</table>
				
	
	
	<p></p>
		
	<!-- Add a logout button -->
	<form:form action="${pageContext.request.contextPath}/logout" 
			   method="POST">
	
		<input type="submit" value="Logout" class="add-button" />
	
	</form:form>

</body>

</html>









