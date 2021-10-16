/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.AdminDAO;
import com.cyrus.dtos.ProductDTO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
public class SearchController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(SearchProductController.class);
    private final static String SUCCESS = "admin.jsp";
    private static final int CAKE_PER_PAGE = 3;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = SUCCESS;
        String search = "";
        try {
            List<ProductDTO> list = null;
            AdminDAO dao = new AdminDAO();
            int pageNum = 0;
            int numberRecords = dao.getAllRecords();
            if (request.getParameter("txtSearch") != null) {
                pageNum = Integer.parseInt(request.getParameter("page"));
            }
            int start = pageNum * CAKE_PER_PAGE;
            list = dao.getProductList(search, start, CAKE_PER_PAGE);

            if (request.getParameter("txtSearch") != null) {
                search = request.getParameter("txtSearch");
                list = dao.getProductList(search, start, CAKE_PER_PAGE);
                numberRecords = dao.getAllRecordsBySearch(search);
            }
            int totalPageNum = numberRecords / CAKE_PER_PAGE;
            if (numberRecords % CAKE_PER_PAGE != 0) {
                totalPageNum++;
            }
            request.setAttribute("LIST_PRO", list);
            request.setAttribute("SEARCH", search);
            request.setAttribute("PAGE", totalPageNum);
            request.setAttribute("CUR_PAGE", pageNum);
        } catch (NumberFormatException | SQLException | NamingException | ClassNotFoundException e) {
            LOGGER.error("Error SearchController at: " + e.getMessage());
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
