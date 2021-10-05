/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.daos.UserDAO;
import com.lan.dtos.PaymentDTO;
import com.lan.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.lan.dtos.InfoErrorObj;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class OrderProductController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(OrderProductController.class);
    private final static String SUCCESS = "order.jsp";
    private final static String ERROR = "invalid.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;

        List<PaymentDTO> paymentList = null;
        try {
            HttpSession ses = request.getSession();
            UserDTO user = (UserDTO) ses.getAttribute("USER");
            UserDAO dao = new UserDAO();

            if (user != null) {
                request.setAttribute("PHONE", dao.getUserPhone(user.getUserID()));
                request.setAttribute("ADDRESS", dao.getUserAddress(user.getUserID()));

            }
            paymentList = dao.getPaymentList();
            request.setAttribute("PAYMENTS", paymentList);
            String total = request.getParameter("total");
            if (total != null) {
                request.setAttribute("TOTAL", total);
            }
            url = SUCCESS;
        } catch (SQLException | NamingException e) {
            LOGGER.error("Error OrderProductController at: " + e.getMessage());
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
