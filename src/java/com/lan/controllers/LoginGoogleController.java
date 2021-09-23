/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.UserDAO;
import com.lan.dtos.GooglePojo;
import com.lan.dtos.UserDTO;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import com.lan.utils.GoogleUtils;

/**
 *
 * @author Cyrus
 */
public class LoginGoogleController extends HttpServlet {

    final static Logger LOGGER = Logger.getLogger(LoginGoogleController.class);
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "login.jsp";
    private static final String SUCCESS = "searchProduct";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        System.out.println("voooooooooooooooooooooo");
        try {
              
            String code = request.getParameter("code");
            HttpSession ses = request.getSession();
            if (code != null && !code.isEmpty()) {
                String accessToken = GoogleUtils.getToken(code);
         
                GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
                UserDAO dao = new UserDAO();
                UserDTO user = dao.checkLogin(googlePojo.getId(), "");
                if (user == null) {
                    String userID = googlePojo.getId();
                    String fullName = googlePojo.getEmail();
                    UserDTO newUser = new UserDTO(userID, "", fullName, null, null, "mem", true);
                    if (dao.insertAccount(newUser)) {
                        user = newUser;
                    }
                }
                ses.setAttribute("USER", user);
                url = SUCCESS;
            } else {
                ses.setAttribute("LOGIN_MESS", "Cannot find account");
            }
        } catch (IOException | NoSuchAlgorithmException | SQLException | NamingException e) {
            LOGGER.error(e);
        } finally {
            response.sendRedirect(url);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
