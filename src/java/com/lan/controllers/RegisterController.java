/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.UserDAO;
import com.lan.dtos.ErrorUserDTO;
import com.lan.dtos.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class RegisterController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(RegisterController.class);
    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String url = ERROR;
        ErrorUserDTO errorUser = new ErrorUserDTO();
        boolean check = true;
        try {
            String userID = request.getParameter("txtUserID");
            String fullName = request.getParameter("txtFullName");
            String password = request.getParameter("txtPassword");
            String rePassword = request.getParameter("txtRePassword");
            String address = request.getParameter("txtAddress");
            String phone = request.getParameter("txtPhone");
            UserDAO dao = new UserDAO();

            if (userID.length() < 2 || userID.length() > 50) {
                errorUser.setUserIDError("UserID length >2 and <50");
                check = false;
            }
            if (fullName.length() < 2) {
                errorUser.setFullNameError("Fullname length >2");
                check = false;
            }
            if (password.length() < 1) {
                errorUser.setRepasswordError("Password length >0");
                check = false;

                if (!password.equals(rePassword)) {
                    errorUser.setRepasswordError("Repassword is different");
                    check = false;
                }
            }
            if (address.length() < 2) {
                errorUser.setAddressError("Address length >2");
                check = false;
            }
            if (!phone.matches("^[0-9]{10}$")) {
                errorUser.setPhoneError("Phone must have 10 numbers");
                check = false;
            } else if (!dao.checkPhoneExist(phone)) {
                errorUser.setPhoneError("Phone number has already exist, try another!");
                check = false;
            }
            if (check) {
                UserDTO dto = new UserDTO(userID, password, fullName, phone, address, "mem", true);
                dao.insertAccount(dto);
                url = SUCCESS;
                HttpSession ses = request.getSession();
                ses.setAttribute("MESS", "Sign up successfully!");
            } else {
                request.setAttribute("ERROR", errorUser);
            }
        } catch (Exception e) {
            if (e.getMessage().contains("duplicate")) {
                errorUser.setUserIDError("UserID is duplicate");
                request.setAttribute("ERROR", errorUser);
            } else {
                LOGGER.error("Error RegisterController at:"+e.getMessage());
            }
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
