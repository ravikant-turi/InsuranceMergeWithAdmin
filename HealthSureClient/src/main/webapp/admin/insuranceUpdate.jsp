<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>
<f:view>
	<!DOCTYPE html>
	<html>
<head>
<title>Insurance Plan and Coverage Options</title>
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: #f4f6f8;
	margin: 0;
	padding: 20px;
}

.main-container {
	max-width: 1200px;
	margin: auto;
}

.form-box, .coverage-box {
	background-color: #ffffff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
	margin-bottom: 30px;
}
/* Main Container */
.form-box {
	background-color: #ffffff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
	max-width: 1100px;
	margin: auto;
}

.form-row {
	display: flex;
	gap: 20px;
	margin-bottom: 15px;
	flex-wrap: wrap;
}

.form-group {
	flex: 1;
	min-width: 200px;
}

label {
	font-weight: 600;
	display: block;
	margin-bottom: 5px;
	color: #34495e;
}

input[type="text"], textarea, select {
	width: 100%;
	padding: 8px 10px;
	border: 1px solid #ccc;
	border-radius: 6px;
	box-sizing: border-box;
	font-size: 14px;
	background-color: #fdfdfd;
}

textarea {
	resize: vertical;
}

.submit-button {
	background-color: #3498db;
	color: white;
	padding: 10px;
	border: none;
	border-radius: 6px;
	font-size: 15px;
	cursor: pointer;
	width: 100%;
	margin-top: 10px;
}

.submit-button:hover {
	background-color: #2980b9;
}

.section-title {
	background-color: #3498db;
	color: white;
	padding: 10px 15px;
	border-radius: 8px;
	text-align: center;
	margin-bottom: 20px;
	height: 40px;
}

.center-button-container {
	display: flex;
	justify-content: center;
	margin-top: 1px;
}

.action-btn {
	background-color: #3498db;
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 4px;
	cursor: pointer;
	font-size: 14px;
	width: 90px; /* Fixed width for uniform size */
	text-align: center;
}

.button-row {
	display: flex;
	justify-content: space-between;
	margin-top: 10px;
}

.action-btn {
	padding: 10px 20px;
	font-size: 14px;
	cursor: pointer;
}

.action-btn:hover {
	background-color: #2980b9;
}

h3 {
	text-align: center;
	color: #2c3e50;
	margin-bottom: 20px;
}

.section-title {
	font-size: 22px;
	font-weight: bold;
	margin: 0;
}

form {
	margin-top: 50px;
}

.error {
	color: red;
	font-size: 12px;
}

.coverage-table {
	width: 90%;
	margin: 20px auto;
	border-collapse: collapse;
	font-family: Arial, sans-serif;
}

.coverage-table th {
	background-color: #2980b9;
	color: white;
	padding: 8px;
	text-align: center;
}

.coverage-table td {
	background-color: #ecf0f1;
	padding: 8px;
	text-align: center;
}

.coverage-table tr:nth-child(even) td {
	background-color: #d0e4f7;
}

.coverage-table tr:hover td {
	background-color: #b2bec3;
}

.coverage-table, .coverage-table th, .coverage-table td {
	border: 1px solid #34495e;
}

.h-panelgroup {
	display: flex;
	align-items: center;
	justify-content: center;
	gap: 6px;
}
</style>

</head>
<body>
	<script>
  window.onload = function () {
    const fields = document.querySelectorAll('.readonly-field');
    fields.forEach(field => {
      field.setAttribute('title', 'This field is read-only');
    });
  };
</script>

	<div class="main-container">

		<!-- Add Insurance Plan Form -->
		

		<h:form id="companyForm">

			<div class="form-box">
				<h3 class="section-title">Update Insurance Plan</h3>

				<h3>Plan Details</h3>

				<!-- Row 1 -->
				<div class="form-row">
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Company Name :" />
						<h:inputText id="companyId" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.insuranceCompany.name}" />
						<br />
						<h:message for="companyId" styleClass="error" />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:green'>*</span>Plan Name :" />
						<h:inputText id="planName"
							value="#{createInsuranceController.insurancePlan.planName}" />
						<h:message for="planName" styleClass="error" />
						<br />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value=" <span style='color:red'>*</span>PlanType: " />
						<h:inputText id="planType" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.planType}" />
						<br />
						<h:message for="planType" styleClass="error" />

					</div>


				</div>

				<!-- Row 2 -->
				<div class="form-row">
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Max Age: " />
						<h:inputText id="maxAge" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.maxEntryAge}" />
						<h:message for="maxAge" styleClass="error" />
						<br />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Min Age: " />
						<h:inputText id="minAge" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.minEntryAge}" />
						<h:message for="minAge" styleClass="error" />
						<br />

					</div>

					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:green'>*</span>Description: " />
						<h:inputTextarea id="description" title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.description}"
							rows="2" cols="20" />
						<h:message for="description" styleClass="error" />
						<br />

					</div>
				</div>

				<!-- Row 3 -->
				<div class="form-row">
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Available Amount: " />
						<h:inputText id="cover" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.availableCoverAmounts}" />
						<h:message for="cover" styleClass="error" />
						<br />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Waiting Period: " />
						<h:inputText id="waitingPeriod" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.waitingPeriod}" />
						<h:message for="waitingPeriod" styleClass="error" />
						<br />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>Active On: " />
						<h:inputText id="activeOn" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.activeOn}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:inputText>
						<h:message for="activeOn" styleClass="error" />
						<br />

					</div>
				</div>
				<!-- Row new -->
				<div class="form-row">
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>MaximumMemberAllowed: " />
						<h:inputText id="maximumMemberAllowed" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.maximumMemberAllowed}" />
						<h:message for="maximumMemberAllowed" styleClass="error" />
						<br />

					</div>
					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>minimumMeberAllowed: " />
						<h:inputText id="minimumMeberAllowed" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.minimumMeberAllowed}" />
						<h:message for="minimumMeberAllowed" styleClass="error" />
						<br />

					</div>

					<div class="form-group">
						<h:outputLabel escape="false"
							value="<span style='color:red'>*</span>createdOn: " />
						<h:inputText id="createdOn" readonly="true"
							title="This field is read-only"
							value="#{createInsuranceController.insurancePlan.createdOn}">
							<f:convertDateTime pattern="yyyy-MM-dd" />
						</h:inputText>

						<h:message for="createdOn" styleClass="error" />
						<br />

					</div>

				</div>


				<br />
				<!-- Multiple selected for Members -->
				<div>
					<h3>
						<h:outputLabel id="memberValidation">Members Allowed In The Plan 
						 </h:outputLabel>
					</h3>


					<br />

					<div
						style="padding-left: 35px; display: flex; flex-wrap: wrap; justify-content: space-evenly; width: 100%;">
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['DAUGHTER1']}" />
								Daughter1</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['DAUGHTER2']}" />
								Daughter2</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['SON1']}" />
								Son1</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['SON2']}" />
								Son2</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['FATHER']}" />
								Father</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['MOTHER']}" />
								Mother</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['HUSBAND']}" />
								Husband</label>
						</div>
						<div style="flex: 1; min-width: 120px;">
							<label><h:selectBooleanCheckbox disabled="true"
									title="This field is read-only"
									value="#{createInsuranceController.relationMap['WIFE']}" />
								Wife</label>
						</div>


					</div>
					<br />
				</div>
				<h:message for="memberValidation" styleClass="error" />
				<br />
				<h3>Coverage Options</h3>

				<h:dataTable
					value="#{createInsuranceController.planwithCovrageDetailsList}"
					var="coverage" styleClass="coverage-table" border="1">
					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block" styleClass="h-panelgroup">
								<h:outputText value="Coverage Type" />
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{coverage.coverageType}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block" styleClass="h-panelgroup">
								<h:outputText value="Premium Amount" />
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{coverage.premiumAmount}" />
					</h:column>

					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block" styleClass="h-panelgroup">
								<h:outputText value="Coverage Amount" />
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{coverage.coverageAmount}" />
					</h:column>
					<h:column>
						<f:facet name="header">
							<h:panelGroup layout="block" styleClass="h-panelgroup">
								<h:outputText value="Coverage status" />
							</h:panelGroup>
						</f:facet>
						<h:outputText value="#{coverage.status}" />
					</h:column>
				</h:dataTable>

				<br />


				<!-- Submit Button -->

				<div class="button-row">

					<h:commandButton value="Cancel"
						action="insuranceAdminDashBoard.jsf"
						styleClass="action-btn right-btn" />
					<h:commandButton value="Update"
						action="#{createInsuranceController.updateInsurancePlanHelper(createInsuranceController.insurancePlan)}"
						styleClass="action-btn" />
				</div>
			</div>
		</h:form>

	</div>
	<h:messages globalOnly="true" style="color:red" />
</body>

	</html>
</f:view>


