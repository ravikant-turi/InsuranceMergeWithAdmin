/*
 * -----------------------------------------------------------------------------
 * Copyright © 2025 Infinite Computer Solution. All rights reserved.
 * -----------------------------------------------------------------------------
 * 
 * @Author  : Sourav Kumar Das
 * @Purpose : This class handles UI-layer interactions and business coordination 
 *            for user-related workflows including registration, OTP verification, 
 *            login, logout, and password reset. It communicates with the 
 *            AdminService layer to invoke validations. It also manages view state, error messages, 
 *            and navigation flows for the JSF frontend.
 * 
 * -----------------------------------------------------------------------------
 */
package com.infinite.jsf.admin.controller;

import java.util.Map;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;

import org.apache.log4j.Logger;

import com.infinite.jsf.admin.model.User;

import com.infinite.jsf.admin.service.AdminService;

public class AdminController {
	
	//Logger Instance for Controller
	private static final Logger logger = Logger.getLogger(AdminController.class);

	private User user;
	private String otp;
	private String newPassword;
	private String confirmPassword;
	private String usernameOrEmail;
	private String tempPassword;
	private AdminService service = new AdminService();
	private boolean otpSent = false;

	private boolean otpResendBlocked = false;

	public boolean isOtpResendBlocked() {
		return otpResendBlocked;
	}
	public void setOtpResendBlocked(boolean otpResendBlocked) {
		this.otpResendBlocked = otpResendBlocked;
	}

	public String getTempPassword() {
		return tempPassword;
	}

	public void setTempPassword(String tempPassword) {
		this.tempPassword = tempPassword;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public String getUsernameOrEmail() {
		return usernameOrEmail;
	}

	public void setUsernameOrEmail(String usernameOrEmail) {
		this.usernameOrEmail = usernameOrEmail;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public boolean isOtpSent() {
		return otpSent;
	}

	public void setOtpSent(boolean otpSent) {
		this.otpSent = otpSent;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getOtp() {
		return otp;
	}

	public void setOtp(String otp) {
		this.otp = otp;
	}
	
	/**
	 *  Handles the resend OTP operation during user signup.
	 *
	 * @return String
	 */
	public String resendOtp() {
		User sessionUser = (User) FacesContext.getCurrentInstance()
				.getExternalContext().getSessionMap().get("tempUser");

		if (sessionUser == null) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Session expired. Please sign up again.", null));
			return "Signup.jsp?faces-redirect=true";
		}

		logger.info("Resending OTP to: " + sessionUser.getEmail());

		Map<String, String> Resend_Otp = service.sendEmailOtp(sessionUser.getEmail(), sessionUser.getUsername());

		if (Resend_Otp.containsKey("otp")) {
			otpResendBlocked = true;
			String msg = Resend_Otp.get("otp");
			logger.warn("OTP resend blocked for 30 mins: " + msg);
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, msg, null));
			return null;
		}
		otpResendBlocked = false;

		if (Resend_Otp.isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "OTP resend successfully.", null));
			otpSent = true; // ✅ Ensure state is preserved
		} else {
			Resend_Otp.forEach((k, v) -> FacesContext.getCurrentInstance()
					.addMessage(k, new FacesMessage(FacesMessage.SEVERITY_WARN, v, null)));
		}

		return null;
	}

	/**
	 * Sends an OTP to the user's email after validating input during signup.
	 *
	 * @return String outcome of the operation
	 */
	public String sendOtpToEmail() {

		tempPassword = user.getPassword();
		Map<String, String> validationErrors = service.validateUserInputFields(user);

		if (!validationErrors.isEmpty()) {
			logger.warn("Validation failed before sending OTP.");
			for (Map.Entry<String, String> entry : validationErrors.entrySet()) {
				FacesContext.getCurrentInstance().addMessage(entry.getKey(),
						new FacesMessage(FacesMessage.SEVERITY_WARN, entry.getValue(), null));
			}
			return null;
		}

		FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("tempUser", user);

		Map<String, String> SignUp_Otp = service.sendEmailOtp(user.getEmail(), user.getUsername());

		if (SignUp_Otp.containsKey("otp")) {
			otpResendBlocked = true;
			String msg = SignUp_Otp.get("otp");
			logger.warn("OTP blocked for 30 mins: " + msg);
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, msg, null));
			return null;
		}
		otpResendBlocked = false;

		if (SignUp_Otp.isEmpty()) {
			logger.info("OTP sent successfully to: " + user.getEmail());
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "OTP has been sent to your email.", null));
			otpSent = true;
		} else {
			logger.warn("Failed to send OTP due to: " + SignUp_Otp);
			for (Map.Entry<String, String> entry : SignUp_Otp.entrySet()) {
				FacesContext.getCurrentInstance().addMessage(entry.getKey(),
						new FacesMessage(FacesMessage.SEVERITY_ERROR, entry.getValue(), null));
			}
		}

		return null;
	}



	/**
	 * Verifies OTP and registers the user during signup.
	 *
	 * @return String navigation outcome based on registration success
	 */
	public String verifyOtpAndSignUp() {
		user.setPassword(tempPassword);

		FacesContext context = FacesContext.getCurrentInstance();
		User sessionUser = (User) context.getExternalContext().getSessionMap().get("tempUser");

		if (sessionUser == null) {
			context.addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Session expired. Please sign up again.", null));
			return "Signup.jsp?faces-redirect=true";
		}

		this.user = sessionUser;
		logger.info("Attempting to register user: " + user.getEmail());

		boolean registered = service.registerUser(user, otp);

		if (registered) {
			logger.info("User registered successfully: " + user.getEmail());
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "Registration successful. Please login.", null));

			context.getExternalContext().getSessionMap().remove("tempUser");

			// Reset fields
			user = new User(); // ✅ Clear user
			otp = null;
			otpSent = false;
			return "Login.jsp?faces-redirect=true"; 
		} else {
			logger.warn("User registration failed for: " + user.getEmail());
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR,
							"Registration failed. Please verify  OTP.", null));
		}

		return null;
	}

	/**
	 * Handles user login using username/email and password.
	 * Validates credentials and redirects to dashboard on success.
	 *
	 * @return String 
	 */
	public String login() {
		logger.info("Login attempt for username/email: " + user.getUsername());

		Map<String, String> result = service.login(user.getUsername(), user.getPassword());

		if (result.containsKey("success")) {
			User loggedInUser = user.getUsername().contains("@")
					? service.findByEmail(user.getUsername())
							: service.findByUsername(user.getUsername());

			FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("loggedInUser", loggedInUser);

			FacesContext.getCurrentInstance().getExternalContext().getFlash().put("loginSuccess", "Welcome " + loggedInUser.getFirstName());

			logger.info("Login successful for user: " + loggedInUser.getUsername());

			user = new User();
			otp = null;
			otpSent = false;

			return "AdminDashBoard.jsp?faces-redirect=true";
		}
		else {

			for (Map.Entry<String, String> entry : result.entrySet()) {
				String key = entry.getKey();
				String msg = entry.getValue();

				if ("username".equals(key) || "email".equals(key)) {
					// Attach all errors including generic ones to the username/email input
					FacesContext.getCurrentInstance().addMessage("username", new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, null));
				} else if ("password".equals(key)) {
					FacesContext.getCurrentInstance().addMessage("password", new FacesMessage(FacesMessage.SEVERITY_ERROR, msg, null));
				}
			}
		}
		logger.warn("Login failed for input: " + user.getUsername());
		return null;
	}
	
	/**
	 * Handles user logout by clearing session and user data.
	 *
	 * @return String navigation outcome based on logout result
	 */
	public String logout() {
		// Getting User stored from session 
		User loggedInUser = (User) FacesContext.getCurrentInstance().getExternalContext().getSessionMap().get("loggedInUser");

		if (loggedInUser == null) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "No user is logged in.", null));
			return null;
		}
		//Getting User From logged User
		int userId = loggedInUser.getUserId();

		boolean result = service.logout(userId);

		if (result) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "Logout successful.", null));

			// Clear user data from controller
			user = new User();
			otp = null;
			otpSent = false;

			// Optionally, invalidate session here:
			FacesContext.getCurrentInstance().getExternalContext().invalidateSession();

			// Redirect to login page after logout
			return "Login.jsf?faces-redirect=true";
		} else {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Logout failed. Please try again.", null));
			return null;
		}
	}

	/**
	 * Sends OTP to user for forgot password flow after validating input.
	 *
	 * @return String navigation outcome or null if OTP sending fails
	 */
	public String sendOtpForForgotPassword() {
		String input = usernameOrEmail != null ? usernameOrEmail.trim() : null;

		if (input == null || input.isEmpty()) {
			FacesContext.getCurrentInstance().addMessage("usernameOrEmail",
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter your email or username.", null));
			return null;
		}

		logger.info("Handling Forgot Password OTP for: " + input);

		Map<String, String> Forgot_Otp = service.sendForgotPasswordOtp(input);

		// OTP block logic (e.g., too many resends)
		if (Forgot_Otp.containsKey("otp")) {
			otpResendBlocked = true;
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, Forgot_Otp.get("otp"), null));
			return null;
		}

		otpResendBlocked = false;
		if (Forgot_Otp.isEmpty()) {
			otpSent = true;
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "OTP has been sent to your email.", null));
			logger.info("OTP successfully sent to: " + input);
		} else {
			logger.warn("Validation error(s) during Forgot Password OTP: " + Forgot_Otp);
			for (Map.Entry<String, String> entry : Forgot_Otp.entrySet()) {
				FacesContext.getCurrentInstance().addMessage(entry.getKey(),
						new FacesMessage(FacesMessage.SEVERITY_ERROR, entry.getValue(), null));
			}
		}

		return null;
	}

	/**
	 * Verifies the OTP entered by the user during forgot password flow.
	 *
	 * @return String navigation outcome to reset page if OTP is valid, else null
	 */
	public String verifyOtpForForgotPassword() {
		if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter your username or email.", null));
			return null;
		}
		if (otp == null || otp.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter the OTP sent to your email.", null));
			return null;
		}

		// Verify OTP using service layer
		boolean isOtpValid = service.verifyForgotPasswordOtp(usernameOrEmail.trim(), otp.trim());

		if (isOtpValid) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "OTP verified. You can now reset your password.", null));
			// Redirect to reset password page
			return "ResetPassword.jsp?faces-redirect=true";
		} else {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "Invalid OTP. Please try again.", null));
			return null;
		}
	}
	
	/**
	 * Handles password reset after successful OTP verification during forgot password flow.
	 *
	 * @return String navigation outcome to login page on success, else null
	 */
	public String resetPasswordAfterOtp() {
		String input = usernameOrEmail != null ? usernameOrEmail.trim() : null;
		logger.info("Attempting password reset for: " + input);

		// Basic validation
		if (input == null || input.isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter your email or username.", null));
			return null;
		}
		if (otp == null || otp.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter the OTP sent to your email.", null));
			return null;
		}
		if (newPassword == null || newPassword.trim().isEmpty()) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_WARN, "Please enter a new password.", null));
			return null;
		}

		if (!newPassword.equals(confirmPassword)) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, "New password and confirm password do not match.", null));
			return null;
		}

		Map<String, String> result = service.forgotPassword(input, otp.trim(), newPassword.trim());

		if (result.containsKey("failure")) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, result.get("failure"), null));
		} else if (result.containsKey("password")) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, result.get("password"), null));
		} else if (result.containsKey("reused_password")) {
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_ERROR, result.get("reused_password"), null));
		} else {
			logger.info("Password reset successful for user: " + input);
			FacesContext.getCurrentInstance().addMessage(null,
					new FacesMessage(FacesMessage.SEVERITY_INFO, "Password has been reset successfully. Please login.", null));

			// Clear fields
			usernameOrEmail = null;
			otp = null;
			newPassword = null;
			confirmPassword = null;
			user = new User();
			otpSent = false;

			return "Login.jsp?faces-redirect=true";
		}
		logger.warn("Password reset failed for user: " + input);
		return null;
	}
}
