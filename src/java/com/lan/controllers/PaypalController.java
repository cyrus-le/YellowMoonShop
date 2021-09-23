/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.controllers;

import com.lan.dtos.CartDTO;
import com.lan.dtos.OrderDetailsDTO;
import com.lan.dtos.ProductDTO;
import com.lan.dtos.UserDTO;
import com.paypal.api.payments.*;
import com.paypal.base.rest.*;
import com.lan.utils.PaypalUtils;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
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
public class PaypalController extends HttpServlet {

    private final static Logger LOGGER = Logger.getLogger(PaypalController.class);
    private final static String SUCCESS = "SearchProductController";
    private final static String ERROR = "OrderProductController";
    private final static long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String approvalLink = ERROR;
        try {
            String orderID = (String) request.getAttribute("ORDER_ID");
            int totalPrice = Integer.parseInt((String) request.getAttribute("TOTAL"));
            HttpSession ses = request.getSession();
            CartDTO cart = (CartDTO) ses.getAttribute("CART");
            UserDTO user = (UserDTO) ses.getAttribute("USER");
            List<ProductDTO> list = new ArrayList<>(cart.getCart().values());
            OrderDetailsDTO dto = null;
            if (user != null) {
                dto = new OrderDetailsDTO(orderID, user.getUserID(), user.getPhone(), totalPrice, list);
            } else {
                String username = (String) request.getAttribute("USER_NAME");
                String phone = (String) request.getAttribute("USER_PHONE");
//                String address = (String) request.getAttribute("USER_ADDRESS");
                dto = new OrderDetailsDTO(orderID, username, phone, totalPrice, list);
            }
            approvalLink = authorizePayment(request, dto);

        } catch (NumberFormatException | PayPalRESTException e) {
            LOGGER.error("Error at PaypalController: " + e.getMessage());
        } finally {
            response.sendRedirect(approvalLink);
        }

    }

    private String authorizePayment(final HttpServletRequest req, OrderDetailsDTO dto)
            throws PayPalRESTException {

        Payer payer = getPayerInformation(req);
        RedirectUrls redirectUrls = getRedirectURLs();
        List<Transaction> listTransaction = getTransactionInformation(dto);

        Payment requestPayment = new Payment();
        requestPayment.setTransactions(listTransaction);
        requestPayment.setRedirectUrls(redirectUrls);
        requestPayment.setPayer(payer);
        requestPayment.setIntent("authorize");

        APIContext apiContext = new APIContext(PaypalUtils.CLIENT_ID, PaypalUtils.CLIENT_SECRET, PaypalUtils.MODE);

        Payment approvedPayment = requestPayment.create(apiContext);

        return getApprovalLink(approvedPayment);

    }

    private RedirectUrls getRedirectURLs() {
        RedirectUrls redirectUrls = new RedirectUrls();
        redirectUrls.setCancelUrl("http://localhost:8084/YellowMoonShop/orderProduct");
        redirectUrls.setReturnUrl("http://localhost:8084/YellowMoonShop");

        return redirectUrls;
    }

    private String getApprovalLink(Payment approvedPayment) {
        List<Links> links = approvedPayment.getLinks();
        String approvalLink = null;

        for (Links link : links) {
            if (link.getRel().equalsIgnoreCase("approval_url")) {
                approvalLink = link.getHref();
                break;
            }
        }

        return approvalLink;
    }

    private Payer getPayerInformation(final HttpServletRequest req) {
        HttpSession ses = req.getSession();
        UserDTO user = (UserDTO) ses.getAttribute("USER");

        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");
        PayerInfo payerInfo = new PayerInfo();
        if (user != null) {

            payerInfo.setFirstName(user.getFullName())
                    .setLastName("")
                    .setEmail(user.getAddress());
            payer.setPayerInfo(payerInfo);
        } else {
            String username = (String) req.getAttribute("USER_NAME");
            String phone = (String) req.getAttribute("USER_PHONE");
            String address = (String) req.getAttribute("USER_ADDRESS");
            payerInfo.setFirstName(username)
                    .setLastName("")
                    .setEmail(address);
            payer.setPayerInfo(payerInfo);
        }
        return payer;
    }

    private List<Transaction> getTransactionInformation(OrderDetailsDTO orderDetail) {
        Details details = new Details();
        details.setShipping("");
        details.setSubtotal(String.valueOf(orderDetail.getTotalPrice()));
        details.setTax("");

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setTotal(String.valueOf(orderDetail.getTotalPrice()));
        amount.setDetails(details);

        Transaction transaction = new Transaction();
        transaction.setAmount(amount);
        transaction.setDescription("");

        ItemList itemList = new ItemList();
        List<Item> items = new ArrayList<>();

        Item item = new Item();
        item.setCurrency("USD");
        item.setName("");
        item.setPrice(String.valueOf(orderDetail.getTotalPrice()));
        item.setTax("");
        item.setQuantity("1");

        items.add(item);
        itemList.setItems(items);
        transaction.setItemList(itemList);

        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;
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
