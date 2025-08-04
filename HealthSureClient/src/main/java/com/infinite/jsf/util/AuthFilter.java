package com.infinite.jsf.util;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.*;

@WebFilter("/AdminDashBoard.jsf")  // Intercepts all JSF pages, you can narrow this if needed
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        String uri = req.getRequestURI();
        boolean isLoginPage = uri.endsWith("Login.jsf") || uri.contains("resources"); // allow static content

        Object user = (session != null) ? session.getAttribute("loggedInUser") : null;

        if (user == null && !isLoginPage) {
            // Not logged in and trying to access a protected page
            res.sendRedirect(req.getContextPath() + "/Login.jsf");
        } else {
            // Logged in or accessing login page/resource
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
