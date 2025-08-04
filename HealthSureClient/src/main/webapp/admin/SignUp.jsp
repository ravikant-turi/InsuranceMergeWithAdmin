<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.

  Author: Sourav Kumar Das

  Description: JSF Sign Up Page using Tailwind CSS for styling.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>

<f:view>
	<!DOCTYPE html>
	<html>
<head>
<meta charset="UTF-8">
<title>Signup</title>
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
<script>
    function startResendCountdown() {
        const button = document.getElementById('resendOtpBtn');
        const countdown = document.getElementById('countdownText');

        let seconds = 30;
        button.disabled = true;
        countdown.classList.remove('hidden');
        countdown.innerText = `Please wait ${seconds} seconds...`;

        const timer = setInterval(() => {
            seconds--;
            countdown.innerText = `Please wait ${seconds} seconds...`;

            if (seconds <= 0) {
                clearInterval(timer);
                button.disabled = false;
                countdown.classList.add('hidden');
            }
        }, 1000);
    }
</script>

</head>
<body class="bg-gray-100 font-sans">

	<div class="flex items-center justify-center min-h-screen">
		<h:form
			styleClass="bg-white p-8 rounded-lg shadow-md w-full max-w-xl space-y-6"
			prependId="false">

			<!-- Heading -->
			<h2 class="text-center text-2xl font-bold text-gray-800">User
				Signup with OTP</h2>

			<div class="grid grid-cols-1 md:grid-cols-2 gap-4">
				<!-- First Name -->
				<div>
					<h:outputLabel for="firstName" value="First Name:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="firstName"
						value="#{adminController.user.firstName}"
						disabled="#{adminController.otpSent}" 
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="firstName" styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Last Name -->
				<div>
					<h:outputLabel for="lastName" value="Last Name:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="lastName" value="#{adminController.user.lastName}"
						disabled="#{adminController.otpSent}" 
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="lastName" styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Username -->
				<div>
					<h:outputLabel for="username" value="Username:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="username" value="#{adminController.user.username}"
						disabled="#{adminController.otpSent}" 
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="username" styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Password -->
				<div>
					<h:outputLabel for="password" value="Password:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputSecret id="password" 
						value="#{adminController.user.password}"
						disabled="#{adminController.otpSent}"
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="password" styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Email (Full width on both columns) -->
				<div class="md:col-span-2">
					<h:outputLabel for="email" value="Email:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="email" value="#{adminController.user.email}"
						disabled="#{adminController.otpSent}" 
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="email" styleClass="text-red-500 text-sm mt-1" />
				</div>
			</div>

			<!-- Send OTP Button -->
			<h:commandButton value="Send OTP"
				action="#{adminController.sendOtpToEmail}"
				rendered="#{!adminController.otpSent}"
				styleClass="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition" />

			<!-- OTP Entry -->
			<h:panelGroup rendered="#{adminController.otpSent}">
				<div class="mt-4">
					<h:outputLabel for="otp" value="Enter OTP:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="otp" value="#{adminController.otp}"
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
				</div>

				<h:commandButton value="Verify & Register"
					action="#{adminController.verifyOtpAndSignUp}"
					styleClass="w-full bg-green-600 text-white py-2 px-4 mt-4 rounded-md hover:bg-green-700 transition" />
				<!-- ✅ Resend OTP Button with JavaScript Countdown -->
				<div class="w-full mt-2 relative">
					<h:commandButton id="resendOtpBtn" value="Resend OTP"
						action="#{adminController.resendOtp}"
						styleClass="w-full bg-yellow-500 text-white py-2 px-4 rounded-md hover:bg-yellow-600 transition" />


					<p id="countdownText"
						class="text-sm text-gray-600 text-center mt-1 hidden"></p>
				</div>
			</h:panelGroup>


			<!-- Global Messages -->
			<h:messages globalOnly="true" layout="table"
				styleClass="text-green-600 text-center font-medium mt-4" />

			<!-- Already have account -->
			<div class="text-center text-sm text-gray-600 mt-4">
				<h:outputLabel value="Already have an account?" />
				<h:outputLink value="Login.jsf"
					styleClass="text-blue-600 hover:underline font-medium ml-1">
                    Login
                </h:outputLink>
			</div>

		</h:form>
	</div>

</body>
	</html>
</f:view>
