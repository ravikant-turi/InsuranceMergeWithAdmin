<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.
 
  Author: Ravikant turi
 
  Description:  Pharmacy Approval By Admin
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>

<f:view>
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8" />
<title>Pharmacy Review Table</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, #f0f4f8 0%, #d9e2ec 100%);
	padding: 40px;
	margin: 0;
	color: #2c3e50;
}

.table-container {
	display: flex;
	justify-content: center;
	flex-direction: column;
	margin: 40px auto;
	width: 95%;
	max-width: 1240px;
	background-color: #ffffff;
	border-radius: 16px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	padding: 50px;
	border: 2px solid #e0e0e0;
}

.table-container:hover {
	box-shadow: 0 12px 22px rgba(46, 61, 73, 0.25);
}

h\:dataTable {
	width: 100%;
	border-collapse: separate;
	border-spacing: 0 12px; /* Adds vertical space between rows */
	margin-top: 20px;
	margin-left: 10px;
}

h\:column, th, td {
	padding: 13px 11px;
	text-align: center;
	font-size: 15px;
	vertical-align: middle;
}

th {
	background-color: #e9ecef;
	color: black;
	font-weight: 500;
	text-transform: uppercase;
	letter-spacing: 1px;
	max-width: fit-content;
	border: 1px solid #ffff;
	border-radius: 5px;
	user-select: none;
	justify-content: center;
	align-items: center;
	gap: 5px;
	cursor: default;
	color: black;
}

td {
	background-color: #ffff; /* Very light blue-gray */
	color: #34495e; /* Darker text */
	border-radius: 6px;
	border: none;
	box-shadow: 0 1px 3px rgba(149, 157, 165, 0.2);
	transition: background-color 0.15s ease;
}

h\:dataTable tr:hover td {
	background-color: #e1e8f0;
	color: #1f2937;
}

.h-panelgroup {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
}

.sort-icons-container {
	display: flex;
	flex-direction: column; /* horizontal arrows */
	margin-left: 6px;
}

.sort-icons {
	cursor: pointer;
	height: 13px;
	width: 14px;
}

.action-button {
	background-color: #0052cc; /* Bright blue */
	border: none;
	color: white;
	padding: 12px 28px;
	font-size: 15px;
	border-radius: 10px;
	font-weight: 600;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.15s ease;
	box-shadow: 0 4px 10px rgba(0, 82, 204, 0.35);
	user-select: none;
}

.action-button:hover:not(:disabled) {
	background-color: #003d99; /* Darker blue */
}

.action-button:disabled {
	background-color: #a1a6b0;
	cursor: not-allowed;
	box-shadow: none;
	transform: none;
}

.message-box {
	background-color: #d0e8ff;
	color: #004080;
	padding: 18px 28px;
	border: 1.5px solid #83b0ff;
	border-radius: 12px;
	margin: 20px auto;
	font-size: 16px;
	width: 90%;
	max-width: 1200px;
	text-align: center;
	box-shadow: 0 6px 18px rgba(31, 65, 102, 0.1);
	font-weight: 500;
	user-select: none;
}

.table-container1 {
	display: flex;
	justify-content: center;
	align-items: center;
}

#loader {
	display: none;
	margin-bottom: 20px;
	text-align: center;
	position: fixed;
	top: 20px;
	left: 50%;
	transform: translateX(-50%);
	background-color: #0052cc;
	color: white;
	padding: 14px 28px;
	border-radius: 10px;
	font-size: 17px;
	font-weight: 600;
	box-shadow: 0 6px 20px rgba(0, 82, 204, 0.4);
	z-index: 9999;
	user-select: none;
}

th a, th a:visited {
	color: #f9fafb !important;
	text-decoration: none;
}

.page-nav-row, .page-nav-row table, .page-nav-row tbody, .page-nav-row tr,
	.page-nav-row td {
	display: flex;
	flex-direction: row;
	border: none;
	background: none;
	padding: 0;
	margin: 0;
}

.status-ACCEPTED {
	color: green;
	font-weight: 500;
}

.status-PENDING {
	color: orange;
	font-weight: 500;
}

.status-REJECTED {
	color: red;
	font-weight: 500;
}
</style>

<script>
	window.onload = function() {
		setTimeout(function() {
			var msg = document.getElementById('globalMessages');
			if (msg) {
				msg.style.display = 'none';
			}
		}, 5000); // 5000 milliseconds = 5 seconds
	};
</script>
</head>
<body>

	<!-- Include Fixed Navbar -->
	<!-- 🌐 Navigation -->
	<jsp:include page="./../navbar/NavAdmin.jsp" />

	<!-- Spacing below navbar -->
	<div style="margin-top: 100px;"></div>

	<!-- Loader Message -->
	<div id="loader"
		style="display: none; position: fixed; top: 20px; left: 50%; transform: translateX(-50%); background-color: #1976d2; color: white; padding: 12px 24px; border-radius: 8px; font-size: 16px; font-weight: bold; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); z-index: 9999;">
		Validating, please wait...</div>


	<h:messages id="globalMessages" globalOnly="true"
		style="position: fixed; top: 70px; left: 50%; transform: translateX(-50%);
           background-color: #e3f2fd; color: #0d47a1; padding: 12px 24px;
           border: 1px solid #90caf9; border-radius: 8px; font-size: 15px;
           z-index: 9999; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2); text-align: center;
           width: auto; max-width: 90%;" />

	<!-- ✅ JavaScript for loader and message -->

	<Script>
		function showLoader() {
			document.getElementById('loader').style.display = 'block';
		}

		window.onload = function() {
			setTimeout(function() {
				var msgBox = document.getElementById('globalMessages');
				if (msgBox) {
					msgBox.style.display = 'none';
				}
				document.getElementById('loader').style.display = 'none';
			}, 10000); // Hide loader and message after 10 seconds
		};
	</Script>

	<!-- Pharmacy Table -->
	<div class="table-container">
		<h:form>
			<h2 style="text-align: center;">PHARMACY REVIEW AND APPROVAL</h2>


			<div class="table-container1">

				<h:dataTable value="#{reviewPharmacyController.paginatedPharmacies}"
					var="pharmacy">



					<!-- Pharmacy ID Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="Pharmacy ID" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('pharmacyId')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'pharmacyId')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending"
											styleClass="backgroundcolor:transparent" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('pharmacyId')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'pharmacyId')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.pharmacyId}" />
					</h:column>

					<!-- Pharmacy Name Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="Name" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('pharmacyName')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'pharmacyName')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('pharmacyName')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'pharmacyName')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.pharmacyName}" />
					</h:column>

					<!-- Email Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="Email" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('email')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'email')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('email')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'email')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.email}" />
					</h:column>

					<!-- Aadhar Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="Aadhar" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('aadhar')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'aadhar')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('aadhar')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'aadhar')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.aadhar}" />
					</h:column>

					<!-- License No Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="License No" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('licenseNo')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'licenseNo')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('licenseNo')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'licenseNo')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.licenseNo}" />
					</h:column>

					<!-- GST Number Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="GST Number" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('gstNo')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'gstNo')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('gstNo')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'gstNo')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.gstNo}" />
					</h:column>

					<!-- Validation Column -->
					<h:column>
						<f:facet name="header">
							<h:outputLabel value="Validation" />
						</f:facet>
						<h:commandButton value="Validate"
							action="#{reviewPharmacyController.validatePharmacy(pharmacy)}"
							disabled="#{pharmacy.status eq 'ACCEPTED' or pharmacy.status eq 'REJECTED'}"
							onclick="showLoader()" styleClass="action-button" />

					</h:column>


					<!-- Status Column -->
					<h:column>
						<f:facet name="header">
							<h:panelGroup styleClass="h-panelgroup" layout="block">
								<h:outputText value="Status" />
								<h:panelGroup layout="block" styleClass="sort-icons-container">
									<h:commandLink
										action="#{reviewPharmacyController.sortByAsc('status')}"
										rendered="#{!(reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'status')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/up-arrow.png"
											width="10" height="10" title="Sort Ascending" />
									</h:commandLink>
									<h:commandLink
										action="#{reviewPharmacyController.sortByDesc('status')}"
										rendered="#{!(!reviewPharmacyController.ascending and reviewPharmacyController.sortField eq 'status')}"
										styleClass="sort-icons">
										<h:graphicImage value="/resources/media/images/down-arrow.png"
											width="10" height="10" title="Sort Descending" />
									</h:commandLink>
								</h:panelGroup>
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{pharmacy.status}"
							styleClass="status-#{pharmacy.status}" />

					</h:column>

				</h:dataTable>
			</div>

			<!-- Pagination Controls -->
			<div style="text-align: center; margin-top: 30px;">
				<h:outputText
					value="Page #{reviewPharmacyController.page + 1} of #{reviewPharmacyController.totalPages}"
					style="margin-right: 20px; font-weight: 600; color: #2c3e50;" />

				<h:commandButton value="Previous"
					action="#{reviewPharmacyController.previousPage}"
					disabled="#{reviewPharmacyController.page eq 0}"
					style="margin-right: 10px;" styleClass="action-button" />

				<h:commandButton value="Next"
					action="#{reviewPharmacyController.nextPage}"
					disabled="#{reviewPharmacyController.page + 1 ge reviewPharmacyController.totalPages}"
					style="margin-left: 10px;" styleClass="action-button" />
			</div>

			<div
				style="display: flex; justify-content: space-between; align-items: center; margin-top: 30px;">

				<!-- Left: Page Number Block with Row Prev/Next -->
				<div style="display: flex; align-items: center;">

					<!-- Row Previous Button -->
					<h:commandButton value="Prev Pages" title="Prev row"
						action="#{reviewPharmacyController.previousBlock}"
						disabled="#{reviewPharmacyController.currentBlock eq 0}"
						style="margin-right: 8px;" styleClass="action-button" />

					<h:dataTable value="#{reviewPharmacyController.pageNumbers}"
						var="pageNum" styleClass="page-nav-row">
						<h:column>
							<h:commandButton value="#{pageNum}"
								action="#{reviewPharmacyController.goToPage(pageNum)}"
								disabled="#{pageNum == reviewPharmacyController.page + 1}"
								style="margin-right: 5px;" styleClass="action-button" />
						</h:column>
					</h:dataTable>

					<!-- Row Next Button -->
					<h:commandButton value="Next Pages" title="Next row"
						action="#{reviewPharmacyController.nextBlock}"
						disabled="#{reviewPharmacyController.currentBlock + 1 ge (reviewPharmacyController.totalPages / reviewPharmacyController.pageBlockSize)}"
						style="margin-left: 8px;" styleClass="action-button" />
				</div>

				<!-- Right: Regular Prev/Next
				<div>
					<h:commandButton value="Previous"
						action="#{reviewPharmacyController.previousBlock}"
								disabled="#{pageNum == reviewPharmacyController.page + 1}"
						style="margin-right: 10px;" styleClass="action-button" />

					<h:commandButton value="Next"
						action="#{reviewPharmacyController.nextBlock}"
						disabled="#{reviewPharmacyController.currentBlock + 1 ge (reviewPharmacyController.totalPages / reviewPharmacyController.pageBlockSize)}"
						styleClass="action-button" />
				</div>
				 -->
			</div>

		</h:form>
	</div>

</body>
	</html>
</f:view>