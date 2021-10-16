/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.dtos.CartDTO;
import com.cyrus.dtos.CategoryDTO;
import com.cyrus.dtos.ProductDTO;
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
public class AddToCartController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(AddToCartController.class);
    private static final String ERROR = "invalid.html";
    private static final String SUCCESS = "SearchProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String productID = request.getParameter("txtProductID");
            String name = request.getParameter("txtName");
            String image = request.getParameter("txtImage");
            double price = Double.parseDouble(request.getParameter("txtPrice"));
            String categoryID = request.getParameter("txtCategoryID");
            String category = request.getParameter("txtCategory");
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            ProductDTO dto = new ProductDTO(productID, name, image, "", price, 1, quantity, null, null, new CategoryDTO(categoryID, category, ""), true);
            HttpSession ses = request.getSession();
            CartDTO cart = (CartDTO) ses.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO();
            }
            cart.add(dto);
            ses.setAttribute("CART", cart);
            request.setAttribute("ADD_MESS", "You added " + dto.getName() + " successfully!");

//            ses.setAttribute("QUANTITY", quantity);
            url = SUCCESS;
        } catch (NumberFormatException e) {
            LOGGER.error(e);
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
