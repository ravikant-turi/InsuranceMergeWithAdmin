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
:root {
	--primary-color: #3498db;
	--primary-dark: #2980b9;
	--secondary-color: #2c3e50;
	--accent-color: #16a085;
	--light-gray: #f4f6f8;
	--white: #ffffff;
	--border-color: #e0e0e0;
	--error-color: #e74c3c;
	--success-color: #2ecc71;
	--shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background-color: var(--light-gray);
	margin: 0;
	padding: 0;
	color: #333;
	line-height: 1.6;
}

.container {
	max-width: 1200px;
	margin: 20px auto;
	padding: 20px;
}

.card {
	background-color: var(--white);
	border-radius: 8px;
	box-shadow: var(--shadow);
	margin-bottom: 25px;
	overflow: hidden;
}

.card-header {
	background-color: var(--primary-color);
	color: var(--white);
	padding: 15px 20px;
	font-size: 1.2rem;
	font-weight: 600;
}

.card-body {
	padding: 20px;
}

.form-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
}

.form-group {
	margin-bottom: 15px;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 600;
	color: var(--secondary-color);
}

.form-control {
	width: 80%;
	padding: 10px 12px;
	background-color: #  e9e9e9;
	border: 1px solid var(--border-color);
	border-radius: 11px;
	font-size: 14px;
	transition: border 0.3s ease;
}

.form-control:focus {
	outline: none;
	border-color: var(--primary-color);
	box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
}

.required-field::after {
	content: " *";
	color: var(--error-color);
}

.btn {
	display: inline-block;
	padding: 10px 20px;
	background-color: var(--primary-color);
	color: white;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 15px;
	transition: background-color 0.3s ease;
}

.btn:hover {
	background-color: var(--primary-dark);
}

.btn-secondary {
	background-color: #95a5a6;
}

.btn-secondary:hover {
	background-color: #7f8c8d;
}

.error-message {
	color: var(--error-color);
	font-size: 12px;
	margin-top: 5px;
}

.global-message {
	position: fixed;
	top: 20px;
	left: 50%;
	transform: translateX(-50%);
	padding: 12px 24px;
	border-radius: 4px;
	z-index: 1000;
	font-weight: 600;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

.global-error {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
}

.coverage-options {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 20px;
	margin-top: 20px;
}

.coverage-card {
	border: 1px solid var(--border-color);
	border-radius: 8px;
	padding: 20px;
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.coverage-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
}

.coverage-card.silver {
	border-top: 4px solid #bdc3c7;
}

.coverage-card.gold {
	border-top: 4px solid #f1c40f;
}

.coverage-card.platinum {
	border-top: 4px solid #e74c3c;
}

.coverage-card h3 {
	color: var(--secondary-color);
	margin-top: 0;
	padding-bottom: 10px;
	border-bottom: 1px solid var(--border-color);
}

.checkbox-container {
	display: flex;
	align-items: center;
	margin-top: 15px;
}

.checkbox-container input[type="checkbox"] {
	margin-right: 10px;
}

.member-options {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
	gap: 15px;
	margin-top: 15px;
}

.member-option {
	display: flex;
	align-items: center;
}

.member-option label {
	margin-left: 8px;
	font-weight: normal;
}

.button-group {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
}

@media ( max-width : 768px) {
	.form-grid {
		grid-template-columns: 1fr;
	}
	.coverage-options {
		grid-template-columns: 1fr;
	}
	.button-group {
		flex-direction: column;
		gap: 10px;
	}
	.button-group .btn {
		width: 100%;
	}
}
</style>
<script>
	function selectOneMenu() {
		if (document.getElementById("companyForm:planType").value == 'FAMILY') {
			document.getElementById("individulMember").style.display = 'none';
			document.getElementById("memberDetail").style.display = 'block';
		} else if (document.getElementById("companyForm:planType").value == 'INDIVIDUAL') {
			document.getElementById("memberDetail").style.display = 'none';
			document.getElementById("individulMember").style.display = 'block';
		} else {
			document.getElementById("memberDetail").style.display = 'none';
			document.getElementById("individulMember").style.display = 'none';
		}
	}

	window.onload = function() {
		selectOneMenu();
		setTimeout(function() {
			var msg = document.getElementById('globalMsg');
			if (msg) {
				msg.style.display = 'none';
			}
		}, 5000);
	};

	window.addEventListener('DOMContentLoaded', function() {
		var inputs = document.querySelectorAll('input.date-input');
		for (var i = 0; i < inputs.length; i++) {
			inputs[i].setAttribute('type', 'date');
		}
	});
</script>
</head>
<body>
	<div class="container">
		<h:messages id="globalMsg" globalOnly="true" layout="table"
			styleClass="global-message global-error" />

		<!-- Insurance Plan Form -->
		<div class="card">
			<div class="card-header">Add Insurance Plan</div>
			<div class="card-body">
				<h:form id="companyForm">
					<div class="form-grid">
						<!-- Company Info -->
						<div class="form-group">
							<label for="companyId">Company Name</label>
							<h:inputText id="companyId" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.insuranceCompany.name}" />
							<h:message for="companyId" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="planName" class="required-field">Plan Name</label>
							<h:inputText id="planName" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.planName}" />
							<h:message for="planName" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="planType" class="required-field">Plan Type</label>
							<h:selectOneMenu id="planType" styleClass="form-control"
								onchange="selectOneMenu();"
								value="#{createInsuranceController.insurancePlan.planType}">
								<f:selectItem itemLabel="--Select--" itemValue="" />
								<f:selectItem itemLabel="INDIVIDUAL" itemValue="INDIVIDUAL" />
								<f:selectItem itemLabel="FAMILY" itemValue="FAMILY" />
							</h:selectOneMenu>
							<h:message for="planType" styleClass="error-message" />
						</div>

						<!-- Age Limits -->
						<div class="form-group">
							<label for="maxAge" class="required-field">Max Age</label>
							<h:inputText id="maxAge" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.maxEntryAge}">
								<f:convertNumber type="number" />
							</h:inputText>
							<h:message for="maxAge" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="minAge" class="required-field">Min Age</label>
							<h:inputText id="minAge" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.minEntryAge}">
								<f:convertNumber type="number" />
							</h:inputText>
							<h:message for="minAge" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="periodicDiseases" class="required-field">Periodic
								Diseases</label>
							<h:selectOneMenu id="periodicDiseases" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.periodicDiseases}">
								<f:selectItem itemLabel="--Select--" itemValue="" />
								<f:selectItem itemLabel="YES" itemValue="YES" />
								<f:selectItem itemLabel="NO" itemValue="NO" />
							</h:selectOneMenu>
							<h:message for="periodicDiseases" styleClass="error-message" />
						</div>

						<!-- Financial Details -->
						<div class="form-group">
							<label for="cover" class="required-field">Available
								Amount</label>
							<h:inputText id="cover" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.availableCoverAmounts}">
								<f:convertNumber type="number" />
							</h:inputText>
							<h:message for="cover" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="waitingPeriod" class="required-field">Waiting
								Period (Month)</label>
							<h:selectOneMenu id="waitingPeriod" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.waitingPeriod}">
								<f:selectItem itemLabel="-- Select --" itemValue="" />
								<f:selectItem itemLabel="1 Month" itemValue="1" />
								<f:selectItem itemLabel="2 Months" itemValue="2" />
								<f:selectItem itemLabel="3 Months" itemValue="3" />
							</h:selectOneMenu>
							<h:message for="waitingPeriod" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="yearsToAdd" class="required-field">Duration</label>
							<h:selectOneMenu id="yearsToAdd" styleClass="form-control"
								value="#{createInsuranceController.yearsToAdd}">
								<f:selectItem itemLabel="--Select--" itemValue="" />
								<f:selectItem itemLabel="1 Year" itemValue="1" />
								<f:selectItem itemLabel="2 Years" itemValue="2" />
								<f:selectItem itemLabel="3 Years" itemValue="3" />
								<f:selectItem itemLabel="5 Years" itemValue="5" />
								<f:selectItem itemLabel="10 Years" itemValue="10" />
								<f:selectItem itemLabel="12 Years" itemValue="12" />
							</h:selectOneMenu>
							<h:message for="yearsToAdd" styleClass="error-message" />
						</div>

						<!-- Date and Member Info -->
						<div class="form-group">
							<label for="activeOn" class="required-field">Active On</label>
							<h:inputText id="activeOn" styleClass="form-control date-input"
								value="#{createInsuranceController.insurancePlan.activeOn}">
								<f:convertDateTime pattern="yyyy-MM-dd" />
							</h:inputText>
							<h:message for="activeOn" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="maximumMemberAllowed" class="required-field">Maximum
								Members Allowed</label>
							<h:selectOneMenu id="maximumMemberAllowed"
								styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.maximumMemberAllowed}">
								<f:selectItem itemLabel="-- Select --" itemValue="" />
								<f:selectItem itemLabel="1" itemValue="1" />
								<f:selectItem itemLabel="2" itemValue="2" />
								<f:selectItem itemLabel="3" itemValue="3" />
								<f:selectItem itemLabel="4" itemValue="4" />
								<f:selectItem itemLabel="5" itemValue="5" />
								<f:selectItem itemLabel="6" itemValue="6" />
								<f:selectItem itemLabel="7" itemValue="7" />
								<f:selectItem itemLabel="8" itemValue="8" />
							</h:selectOneMenu>
							<h:message for="maximumMemberAllowed" styleClass="error-message" />
						</div>

						<div class="form-group">
							<label for="minimumMemberAllowed">Minimum Members Allowed</label>
							<h:selectOneMenu id="minimumMemberAllowed"
								styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.minimumMeberAllowed}">
								<f:selectItem itemLabel="-- Select --" itemValue="" />
								<f:selectItem itemLabel="1" itemValue="1" />
								<f:selectItem itemLabel="2" itemValue="2" />
							</h:selectOneMenu>
							<h:message for="minimumMemberAllowed" styleClass="error-message" />
						</div>

						<div class="form-group" style="grid-column: 1/-1;">
							<label for="description" class="required-field">Description</label>
							<h:inputTextarea id="description" styleClass="form-control"
								value="#{createInsuranceController.insurancePlan.description}"
								rows="4" />
							<h:message for="description" styleClass="error-message" />
						</div>
					</div>

					<!-- Member Details Section -->
					<div class="card" style="margin-top: 20px;">
						<div class="card-header">Member Details</div>
						<div class="card-body">
							<h:panelGroup>
								<div id="memberDetail">
									<h4>Multiple selection for Members</h4>
									<div class="member-options">
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['DAUGHTER1']}" />
											<label>Daughter1</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['DAUGHTER2']}" />
											<label>Daughter2</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['SON1']}" />
											<label>Son1</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['SON2']}" />
											<label>Son2</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['FATHER']}" />
											<label>Father</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['MOTHER']}" />
											<label>Mother</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['HUSBAND']}" />
											<label>Husband</label>
										</div>
										<div class="member-option">
											<h:selectBooleanCheckbox
												value="#{createInsuranceController.relationMap['WIFE']}" />
											<label>Wife</label>
										</div>
									</div>
									<h:message for="memberValidation" styleClass="error-message" />
								</div>
							</h:panelGroup>

							<h:panelGroup>
								<div id="individulMember">
									<h4>Individual Member</h4>
									<div style="display: flex; align-items: center; gap: 15px;">
										<label>Select Gender:</label>
										<h:selectOneRadio id="individualMemberGender"
											value="#{createInsuranceController.individualMemberGender}">
											<f:selectItem itemLabel="Male" itemValue="MALE" />
											<f:selectItem itemLabel="Female" itemValue="FEMALE" />
										</h:selectOneRadio>
									</div>
									<h:message for="individualMemberGender"
										styleClass="error-message" />
								</div>
							</h:panelGroup>
						</div>
					</div>

					<!-- Coverage Options Section -->
					<div class="card" style="margin-top: 20px;">
						<div class="card-header">Add Coverage Options</div>
						<div class="card-body">
							<div class="coverage-options">
								<!-- Silver Option -->
								<div class="coverage-card silver">
									<h3>Silver Option</h3>
									<div class="form-group">
										<label for="PremiumAmount" class="required-field">Premium
											Amount</label>
										<h:inputText id="PremiumAmount" styleClass="form-control"
											value="#{createInsuranceController.coverageOption1.premiumAmount}" />
										<h:message for="PremiumAmount" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="CoverageAmount" class="required-field">Coverage
											Amount</label>
										<h:inputText id="CoverageAmount" styleClass="form-control"
											value="#{createInsuranceController.coverageOption1.coverageAmount}" />
										<h:message for="CoverageAmount" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="coverageType" class="required-field">Coverage
											Type</label>
										<h:selectOneMenu id="coverageType" styleClass="form-control"
											value="#{createInsuranceController.coverageOption1.coverageType}">
											<f:selectItem itemLabel="SILVER" itemValue="SILVER" />
										</h:selectOneMenu>
									</div>

									<div class="checkbox-container">
										<h:selectBooleanCheckbox id="checkbox"
											value="#{createInsuranceController.silver}" />
										<label for="checkbox">Select this option</label>
									</div>
								</div>

								<!-- Gold Option -->
								<div class="coverage-card gold">
									<h3>Gold Option</h3>
									<div class="form-group">
										<label for="PremiumAmount2">Premium Amount</label>
										<h:inputText id="PremiumAmount2" styleClass="form-control"
											value="#{createInsuranceController.coverageOption2.premiumAmount}">
											<f:convertNumber type="number" />
										</h:inputText>
										<h:message for="PremiumAmount2" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="CoverageAmount2">Coverage Amount</label>
										<h:inputText id="CoverageAmount2" styleClass="form-control"
											value="#{createInsuranceController.coverageOption2.coverageAmount}">
											<f:convertNumber type="number" />
										</h:inputText>
										<h:message for="CoverageAmount2" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="coverageType2" class="required-field">Coverage
											Type</label>
										<h:selectOneMenu id="coverageType2" styleClass="form-control"
											value="#{createInsuranceController.coverageOption2.coverageType}">
											<f:selectItem itemLabel="GOLD" itemValue="GOLD" />
										</h:selectOneMenu>
										<h:message for="coverageType2" styleClass="error-message" />
									</div>

									<div class="checkbox-container">
										<h:selectBooleanCheckbox id="gold"
											value="#{createInsuranceController.gold}" />
										<label for="gold">Select this option</label>
									</div>
								</div>

								<!-- Platinum Option -->
								<div class="coverage-card platinum">
									<h3>Platinum Option</h3>
									<div class="form-group">
										<label for="PremiumAmount3">Premium Amount</label>
										<h:inputText id="PremiumAmount3" styleClass="form-control"
											value="#{createInsuranceController.coverageOption3.premiumAmount}">
											<f:convertNumber type="number" />
										</h:inputText>
										<h:message for="PremiumAmount3" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="CoverageAmount3">Coverage Amount</label>
										<h:inputText id="CoverageAmount3" styleClass="form-control"
											value="#{createInsuranceController.coverageOption3.coverageAmount}">
											<f:convertNumber type="number" />
										</h:inputText>
										<h:message for="CoverageAmount3" styleClass="error-message" />
									</div>

									<div class="form-group">
										<label for="coverageType3" class="required-field">Coverage
											Type</label>
										<h:selectOneMenu id="coverageType3" styleClass="form-control"
											value="#{createInsuranceController.coverageOption3.coverageType}">
											<f:selectItem itemLabel="PLATINUM" itemValue="PLATINUM" />
										</h:selectOneMenu>
										<h:message for="coverageType3" styleClass="error-message" />
									</div>

									<div class="checkbox-container">
										<h:selectBooleanCheckbox id="platinum"
											value="#{createInsuranceController.platinum}" />
										<label for="platinum">Select this option</label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Form Actions -->
					<div class="button-group">
						<h:commandButton value="Cancel"
							action="AInsuranceAdminDashBoard.jsp"
							styleClass="btn btn-secondary" />
						<h:commandButton value="Create"
							action="#{createInsuranceController.addSilverOnlyMendatory}"
							styleClass="btn" />
					</div>
				</h:form>
			</div>
		</div>
	</div>
</body>
	</html>
</f:view>
