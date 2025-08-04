<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.

  @Author: Sourav Kumar Das

  Description: JSF Admin Profile Page displaying logged-in admin details.
-->
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Admin Profile</title>
<link rel="stylesheet"
	href="/HealthSureClient/resources/css/profile.css" />
</head>

<body>

	<f:view>
		<!-- 🌐 Navigation -->
		<jsp:include page="./../navbar/NavAdmin.jsp" />

		<div class="container">
			<!-- 👋 Greeting -->
			<h1 class="heading-primary">
				Welcome,
				<h:outputText value="#{sessionScope.loggedInUser.firstName}" />
				<h:outputText value="#{sessionScope.loggedInUser.lastName}" />
			</h1>

			<!-- 🧾 Details -->
			<div class="details-box">
				<p>
					<strong>Admin ID:</strong>
					<h:outputText value="#{sessionScope.loggedInUser.userId}" />
				</p>
				<p>
					<strong>Username:</strong>
					<h:outputText value="#{sessionScope.loggedInUser.username}" />
				</p>
				<p>
					<strong>Email:</strong>
					<h:outputText value="#{sessionScope.loggedInUser.email}" />
				</p>
				<p>
					<strong>Created At:</strong>
					<h:outputText value="#{sessionScope.loggedInUser.createdAt}" />
				</p>
				<p>
					<strong>Last Updated:</strong>
					<h:outputText value="#{sessionScope.loggedInUser.updatedAt}" />
				</p>
			</div>

			<!-- 🚪 Controls -->
			<div class="button-group">
				<h:form>
					<h:commandButton value="Logout" action="#{adminController.logout}"
						styleClass="button-red" />
				</h:form>
				
			</div>
		</div>

		<!-- 📎 Footer -->
		<jsp:include page="/footer/Footer.jsp" />
	</f:view>

</body>
</html>