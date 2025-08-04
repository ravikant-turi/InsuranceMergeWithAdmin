<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.

  Author: Sourav Kumar Das

  Description: JSF Reset Password Page using Tailwind CSS for styling.
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h"%>

<f:view>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password</title>
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
</head>
<body class="bg-gray-100 font-sans">

    <div class="flex items-center justify-center min-h-screen">
        <h:form id="resetPasswordForm" styleClass="bg-white p-8 rounded-lg shadow-md w-full max-w-md space-y-6" prependId="false">

            <!-- Heading -->
            <h2 class="text-center text-2xl font-bold text-gray-800">Reset Your Password</h2>

            <!-- New Password -->
            <div>
                <h:outputLabel for="newPassword" value="New Password:" styleClass="block text-sm font-medium text-gray-700" />
                <h:inputSecret id="newPassword" value="#{adminController.newPassword}" required="true"
                               requiredMessage="New Password is required."
                               styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
                <h:message for="newPassword" styleClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Confirm Password -->
            <div>
                <h:outputLabel for="confirmPassword" value="Confirm Password:" styleClass="block text-sm font-medium text-gray-700" />
                <h:inputSecret id="confirmPassword" value="#{adminController.confirmPassword}" required="true"
                               requiredMessage="Please confirm your password."
                               styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
                <h:message for="confirmPassword" styleClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Submit Button -->
            <h:commandButton value="Reset Password"
                             action="#{adminController.resetPasswordAfterOtp}"
                             styleClass="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition" />

            <!-- Global Messages -->
            <h:messages globalOnly="true" layout="table"
                        styleClass="text-green-600 text-center font-medium mt-4" />

            <!-- Back to login -->
            <div class="text-center text-sm text-gray-600 mt-4">
                <h:outputLabel value="Back to" />
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
