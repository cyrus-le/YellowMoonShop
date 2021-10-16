/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.dtos.CartDTO;
import com.cyrus.dtos.ProductDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.cyrus.daos.UserDAO;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class UpdateCartProductController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(UpdateCartProductController.class);

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = "view.jsp";
        try {
            UserDAO dao = new UserDAO();
            String productID = request.getParameter("txtProductID");
            int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
            int quantityDB = dao.getQuantity(productID);

            ProductDTO newProduct = null;
            HttpSession ses = request.getSession();
            CartDTO cart = (CartDTO) ses.getAttribute("CART");
            if (quantity > quantityDB) {
                request.setAttribute("ERROR", "The store has only " + quantityDB + " " + productID + ".");
            } else if (quantityDB == 0) {
                request.setAttribute("ERROR", "The " + productID + " is out of stock.");
            } else {
                for (ProductDTO dto : cart.getCart().values()) {
                    if (dto.getProductID().equals(productID)) {
                        newProduct = new ProductDTO(productID, dto.getName(),
                                dto.getImage(), dto.getDescription(),
                                dto.getPrice(), quantity, quantityDB, dto.getCreateDate(),
                                dto.getExpirationDate(), dto.getCategory(), true);
                    }
                }
                cart.update(productID, newProduct);
                ses.setAttribute("CART", cart);
            }
        } catch (NumberFormatException | SQLException | NamingException  e) {
            LOGGER.error(e);
        }  finally {
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
