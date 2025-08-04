<!--
  Copyright © 2025 Infinite Computer Solution. All rights reserved.

  @Author: Sourav Kumar Das

  Description: JSF Login Page using Tailwind CSS for styling.
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
<title>Login</title>
<script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>

<!-- Prevent browser cache -->
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="0" />

</head>
<body class="bg-gray-100 font-sans">

	<div class="flex items-center justify-center min-h-screen">
		<h:form
			styleClass="bg-white p-8 rounded-lg shadow-md w-full max-w-md space-y-6"
			prependId="false">

			<!-- Bold and centered Login heading -->
			<h2 class="text-center text-2xl font-bold text-gray-800">Login</h2>

			<div class="space-y-4">
				<!-- Username Field -->
				<div>
					<h:outputLabel for="username" value="Username or Email:"
						styleClass="block text-sm font-medium text-gray-700" />
					<h:inputText id="username" value="#{adminController.user.username}"
						styleClass="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500" />
					<h:message for="username" styleClass="text-red-500 text-sm mt-1" />
				</div>

				<!-- Password Field -->
				<div class="relative">
					<h:outputLabel for="password" value="Password:"
						styleClass="block text-sm font-medium text-gray-700" />

					<h:inputSecret id="password"
						value="#{adminController.user.password}"
						styleClass="mt-1 block w-full pr-10 px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
						redisplay="true" />
					<h:message for="password" styleClass="text-red-500 text-sm mt-1" />

					<!-- Show/Hide Toggle Icon -->
					<span class="absolute right-3 top-9 cursor-pointer text-gray-500"
						onclick="togglePasswordVisibility()"> 👁️ </span>
				</div>

				<!-- Forget Password Link aligned right -->
				<div class="flex justify-end text-sm">
					<h:outputLink value="ForgetPassword.jsf"
						styleClass="text-red-500 hover:underline font-semibold">
          Forget Password
        </h:outputLink>
				</div>

				<!-- Login Button -->
				<h:commandButton value="Login" action="#{adminController.login}"
					styleClass="w-full bg-blue-600 text-white py-2 px-4 rounded-md hover:bg-blue-700 transition" />

				<!-- Global Messages -->
				<h:messages globalOnly="true" layout="table"
					styleClass="text-green-600 text-center font-medium mt-4" />

				<!-- Signup Prompt -->
				<div class="text-center text-sm text-gray-600 mt-4">
					<h:outputLabel value="Don't have an account?" />
					<h:outputLink value="SignUp.jsf"
						styleClass="text-blue-600 hover:underline font-medium ml-1">
          Signup
        </h:outputLink>
				</div>
		</h:form>
	</div>
	
	<script>
  function togglePasswordVisibility() {
    const pwdInput = document.getElementById("password");
    const icon = event.currentTarget;
    
    if (pwdInput.getAttribute("type") === "password") {
      pwdInput.setAttribute("type", "text");
      icon.textContent = "🙈";
    } else {
      pwdInput.setAttribute("type", "password");
      icon.textContent = "👁️";
    }
  }
</script>
</body>
	</html>
</f:view>



