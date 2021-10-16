/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.UserDAO;
import com.cyrus.dtos.CartDTO;
import com.cyrus.dtos.UserDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Objects;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cyrus.dtos.InfoErrorObj;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class ConfirmOrderController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(ConfirmOrderController.class);
    private static final InfoErrorObj errorObj = new InfoErrorObj();
    private static final String ERROR = "OrderProductController";
    private static final String SUCCESS = "SearchProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {

            HttpSession ses = request.getSession();
            CartDTO cart = (CartDTO) ses.getAttribute("CART");
            if (cart == null || cart.getCart().isEmpty()) {
                request.setAttribute("EMPTY_CART", "Your cart is empty");
            } else {
                UserDAO dao = new UserDAO();
                
                UserDTO user = (UserDTO) ses.getAttribute("USER");
                String address = request.getParameter("txtAddress");
                String phone = request.getParameter("txtPhone");
                String name = request.getParameter("txtName");

                boolean check = validatePhone(request) && validateAddress(request) && validateName(request);

                String txtTotal = Objects.isNull(request.getAttribute("TOTAL")) ? request.getParameter("txtTotal")
                        : String.valueOf(request.getAttribute("TOTAL"));
                double totalPrice = Double.parseDouble(txtTotal);
                request.setAttribute("TOTAL", totalPrice);

                String paymentID = request.getParameter("cbPayment");
                if (check) {
                    url = SUCCESS;
                    String orderID = "";
                    if (user != null) {
                        orderID = dao.confirm(user.getUserID(), name, address, phone, totalPrice, paymentID, cart, true);
                        if (orderID != null) {
                            request.setAttribute("CONFIRM_MESS", "Checkout successfully");
                            ses.setAttribute("CART", null);
                        } else {
                            request.setAttribute("CONFIRM_MESS", "Checkout fail, please try again!");
                        }
                    } else {
                        orderID = dao.confirm(null, name, address, phone, totalPrice, paymentID, cart, true);
                        if (orderID != null) {
                            request.setAttribute("CONFIRM_MESS", "Checkout successfully");
                            ses.setAttribute("CART", null);
                        } else {
                            request.setAttribute("CONFIRM_MESS", "Checkout fail, please try again!");
                        }
                    }

                    request.setAttribute("ORDER_ID", orderID);
                } else {
                    request.setAttribute("ERROR", errorObj);
                }

            }
        } catch (NumberFormatException | SQLException e) {
            LOGGER.error("Errror ConfirmOrderController at: " + e.getMessage());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private boolean validateAddress(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String address = req.getParameter("txtAddress");
        if (address != null) {
            if (!address.trim().isEmpty()) {
                if (address.matches("[a-zA-Z\\s\\d]{1,}")) {
                    req.setAttribute("ADDRESS", address);
                    check = true;
                } else {
                    errorObj.setAddressError("Address must be alphabet");
                }
            } else {
                errorObj.setAddressError("Address cannot be blank");
            }

        } else {
            errorObj.setAddressError("Address must not be null.");
        }
        return check;
    }

    private boolean validatePhone(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String phone = req.getParameter("txtPhone");
        if (phone != null) {
            if (!phone.trim().isEmpty()) {
                if (phone.matches("\\d{10}$")) {
                    req.setAttribute("PHONE", phone);
                    check = true;
                } else {
                    errorObj.setPhoneError("Phone must be 10 digits");
                }
            } else {
                errorObj.setPhoneError("Phone cannot be blank");
            }

        } else {
            errorObj.setPhoneError("Phone must not be null.");
        }
        return check;
    }

    private boolean validateName(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String name = req.getParameter("txtName");
        if (name != null) {
            if (!name.trim().isEmpty()) {
                if (name.matches("[a-zA-Z\\s]{1,}")) {
                    check = true;
                } else {
                    errorObj.setNameError("Name must be alphabet");
                }
            } else {
                errorObj.setNameError("Name cannot be blank");
            }

        } else {
            errorObj.setNameError("Name must not be null.");
        }
        return check;
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
