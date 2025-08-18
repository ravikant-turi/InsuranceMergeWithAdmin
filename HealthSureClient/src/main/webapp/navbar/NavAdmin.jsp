<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<link rel="stylesheet" href="/HealthSureClient/resources/css/navbar.css" />
<nav id="navbar" class="navbar navbar-scrolled">
	<!-- Removed navbar-transparent -->
	<div class="navbar-container">

		<!-- LOGO + NAME -->
		<div class="navbar-logo">
			<a href="/HealthSureClient/home/Home.jsf" class="logo-link"> <h:graphicImage
					library="media" name="images/Logo.jpg" alt="HealthSure Logo"
					styleClass="logo-img" />
			</a> <span class="brand-name">HealthSure</span>
		</div>

		<!-- PROVIDER NAV LINKS -->
		<ul class="nav-links">
			<li><a href="/HealthSureClient/admin/AdminDashBoard.jsf"
				class="nav-link">Dashboard</a></li>
			<li><a href="/HealthSureClient/admin/Approval.jsf"
				class="nav-link">Review Pharmacy</a></li>

			<li><a
				href="/HealthSureClient/admin/insuranceAdminDashBoard.jsf"
				class="nav-link">Insurance</a></li>
			<!--   
						<li><a href="appointments.jsf" class="nav-link">Provider</a></li>
			
			 <li><a href="patients.jsf" class="nav-link">Review Pharmacy</a></li>
            <li><a href="services.jsf" class="nav-link">Recepient</a></li>
            <li><a href="reports.jsf" class="nav-link">Claims</a></li>
            <li><a href="reports.jsf" class="nav-link">Payments</a></li>
             -->
		</ul>

		<div class="profile-section">
			<h:graphicImage library="media" name="images/defaultProfile.jpg"
				alt="Profile Avatar" styleClass="profile-avatar" />
			<a href="Profile.jsf" class="view-profile-btn">View Profile</a>
		</div>
	</div>
</nav>