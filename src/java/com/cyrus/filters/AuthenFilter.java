/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.filters;

import com.cyrus.dtos.UserDTO;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class AuthenFilter implements Filter {

    final static Logger LOGGER = Logger.getLogger(AuthenFilter.class);
    private static final boolean debug = true;
    private static List<String> user;
    private static List<String> guest;
    private static List<String> admin;
    private static final String START_PAGE = "logout";
    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        user = new ArrayList<>();
        user.add("");
        user.add("logout");
        user.add("shopping.jsp");
        user.add("searchProduct");
        user.add("addToCart");
        user.add("view.jsp");
        user.add("updateCartProduct");
        user.add("deleteCartProduct");
        user.add("orderProduct");
        user.add("confirmOrder");
        user.add("track");
        user.add("track.jsp");
        user.add("loginGoogle");

        guest = new ArrayList<>();
        guest.add("");
        guest.add("logout");
        guest.add("login");
        guest.add("login.jsp");
        guest.add("shopping.jsp");
        guest.add("searchProduct");
        guest.add("register");
        guest.add("register.jsp");
        guest.add("addToCart");
        guest.add("view.jsp");
        guest.add("updateCartProduct");
        guest.add("deleteCartProduct");
        guest.add("orderProduct");
        guest.add("confirmOrder");

        admin = new ArrayList<>();
        admin.add("logout");
        admin.add("admin.jsp");
        admin.add("search");
        admin.add("UpdateController");
        admin.add("update.jsp");
        admin.add("create");
        admin.add("create.jsp");
        admin.add("CreateController");
    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }

    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }

    }


    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {

        try {
            HttpServletRequest rq = (HttpServletRequest) request;
            HttpServletResponse rs = (HttpServletResponse) response;
            String uri = rq.getRequestURI();
            if ((uri.contains(".js") || uri.contains(".jpg")
                    || uri.contains("png")
                    || uri.contains("jpeg"))
                    && !uri.contains("jsp")) {
                chain.doFilter(request, response);

            } else {
                if (uri.contains("login")) {
                    chain.doFilter(request, response);
                    return;
                }
                int index = uri.lastIndexOf("/");
                String resource = uri.substring(index + 1);
                HttpSession session = rq.getSession();
                if (session == null || session.getAttribute("USER") == null) {
                    if (guest.contains(resource)) {
                        chain.doFilter(request, response);
                    }
                    else {
                        rs.sendRedirect(START_PAGE);
                    }
                } else {
                    UserDTO dto = (UserDTO) session.getAttribute("USER");
                    String role = dto.getRoleID();
                    if (role.equals("ad") && admin.contains(resource)) {
                        chain.doFilter(request, response);
                    } else if (!role.equals("ad") && user.contains(resource)) {
                        chain.doFilter(request, response);
                    } else {
                        rs.sendRedirect(START_PAGE);
                    }
                }
            }
        } catch (IOException | ServletException e) {
            LOGGER.error(e);
        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                LOGGER.error(ex);
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
                LOGGER.error(ex);
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
            LOGGER.error(ex);
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
