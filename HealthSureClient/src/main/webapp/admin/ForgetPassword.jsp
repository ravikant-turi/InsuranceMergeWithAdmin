<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.

  Author: Sourav Kumar Das

  Description: JSF Forgot Password Page with OTP verification using Tailwind CSS.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>
<script src="https://cdn.tailwindcss.com"></script>

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
	<f:view>

		<div class="flex items-center justify-center min-h-screen">
			<h:form id="forgotPasswordForm"
				styleClass="bg-white p-8 rounded-lg shadow-md w-full max-w-md space-y-6"
				prependId="false">

				<!-- Heading -->
				<h2 class="text-center text-2xl font-bold text-gray-800">Forgot
					Password</h2>

				<!-- Username or Email input -->
				<div>
					<h:outputLabel for="usernameOrEmail" value="Username or Email:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="usernameOrEmail"
						value="#{adminController.usernameOrEmail}"
						disabled="#{adminController.otpSent}" required="true"
						requiredMessage="Username or Email is required."
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="usernameOrEmail"
						styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Send OTP button -->
				<h:commandButton value="Send OTP"
					action="#{adminController.sendOtpForForgotPassword}"
					rendered="#{!adminController.otpSent}"
					onclick="startResendCountdown()"
					styleClass="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition" />

				<!-- Global Messages -->
				<h:messages globalOnly="true" layout="table"
					styleClass="text-green-600 text-center font-medium" />

				<!-- OTP input shown only after OTP is sent -->
				<h:panelGroup rendered="#{adminController.otpSent}">
					<div class="mt-4">
						<h:outputLabel for="otp" value="Enter OTP:"
							styleClass="block text-sm font-medium text-gray-700" />
						<h:inputText id="otp" value="#{adminController.otp}"
							requiredMessage="OTP is required."
							styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
						<h:message for="otp" styleClass="text-red-500 text-sm mt-1" />
					</div>

					<!-- Verify OTP Button -->
					<h:commandButton value="Verify OTP"
						action="#{adminController.verifyOtpForForgotPassword}"
						styleClass="w-full bg-green-600 text-white py-2 px-4 mt-4 rounded-md hover:bg-green-700 transition" />

					<!-- Resend OTP Button with countdown -->
					<div class="w-full mt-2 relative">
						<h:commandButton id="resendOtpBtn" value="Resend OTP"
							action="#{adminController.sendOtpForForgotPassword}"
							styleClass="w-full bg-yellow-500 text-white py-2 px-4 rounded-md hover:bg-yellow-600 transition" />

						<p id="countdownText"
							class="text-sm text-gray-600 text-center mt-1 hidden"></p>
					</div>
				</h:panelGroup>

				<!-- Back to login -->
				<div class="text-center text-sm text-gray-600 mt-4">
					<h:outputLabel value="Remember your password?" />
					<h:outputLink value="Login.jsf"
						styleClass="text-blue-600 hover:underline font-medium ml-1">
                    Login
                </h:outputLink>
				</div>

			</h:form>
		</div>

	</f:view>
</body>
</html>

