/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.controllers;

import com.cyrus.daos.AdminDAO;
import com.cyrus.dtos.CategoryDTO;
import com.cyrus.dtos.ProductDTO;
import com.cyrus.dtos.UserDTO;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import com.cyrus.dtos.ProductErrorObj;
import java.util.logging.Level;
import javax.naming.NamingException;
import org.apache.log4j.Logger;

/**
 *
 * @author Cyrus
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class UpdateController extends HttpServlet {

    final static Logger LOGGER = Logger.getLogger(UpdateController.class);
    private static final String SUCCESS = "SearchController";
    private static final String ERROR = "update.jsp";
    private static final long serialVersionUID = 1L;
    private static final ProductErrorObj errorObj = new ProductErrorObj();

    public static final String SAVE_DIRECTORY = "images";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        AdminDAO dao = new AdminDAO();
        String url = ERROR;
        try {
            String appPath = request.getServletContext().getRealPath("");
            appPath = appPath.substring(0, appPath.indexOf("build")) + "web\\";
            appPath = appPath.replace('\\', '/');

            // Thư mục để save file tải lên.
            String fullSavePath = null;
            if (appPath.endsWith("/")) {
                fullSavePath = appPath + SAVE_DIRECTORY;
            } else {
                fullSavePath = appPath + "/" + SAVE_DIRECTORY;
            }

            // Tạo thư mục nếu nó không tồn tại.
            File fileSaveDir = new File(fullSavePath);
            if (!fileSaveDir.exists()) {
                fileSaveDir.mkdir();
            }

            String fileName = "";
            for (Part part : request.getParts()) {
                String fileExtension = getFileExtension(part);
                if (fileExtension != null && fileExtension.length() > 0) {
                    fileName = String.valueOf(System.currentTimeMillis()) + fileExtension;
                    String filePath = fullSavePath + File.separator + fileName;

                    part.write(filePath);
                    String buildPath = request.getServletContext().getRealPath("");
                    if (buildPath.endsWith("/")) {
                        buildPath = buildPath + SAVE_DIRECTORY;
                    } else {
                        buildPath = buildPath + "/" + SAVE_DIRECTORY;
                    }
                    buildPath += File.separator + fileName;
                    File finish = new File(buildPath);
                    while (!finish.exists());
                }
            }
            SimpleDateFormat fm = new SimpleDateFormat("yyyy-MM-dd");
            String image = request.getParameter("txtImage");
            if (!fileName.equals("")) {
                File old = new File(appPath + "/" + image);
                old.delete();
                image = "images/" + fileName;
            }

            boolean check = validateProductName(request) && validateProductDescription(request) && validateProductPrice(request) && validateDate(request);
            System.out.println(check + "check");
            if (check) {
                String productID = request.getParameter("txtProductID");
                String name = request.getParameter("txtName");
                String description = request.getParameter("txtDescription");
                double price = Double.parseDouble(request.getParameter("txtPrice"));
                int quantity = Integer.parseInt(request.getParameter("txtQuantity"));
                String categoryID = request.getParameter("cbCategory");
                String createDate = request.getParameter("txtCreateDate");
                String expirationDate = request.getParameter("txtExpirationDate");
                boolean status = Boolean.valueOf(request.getParameter("cbStatus"));

                ProductDTO dto = new ProductDTO(productID, name, image, description, price, quantity,
                        fm.parse(createDate), fm.parse(expirationDate), new CategoryDTO(categoryID, null, null), status);
                if (dao.updateProduct(dto)) {
                    url = SUCCESS;
                    HttpSession ses = request.getSession();
                    UserDTO user = (UserDTO) ses.getAttribute("USER");
                    dao.addUpdateRecord(productID, user.getUserID());
                }

            } else {
                request.setAttribute("ERROR", errorObj);
            }

        } catch (IOException | NumberFormatException | SQLException | ParseException | ServletException | NamingException e) {
            LOGGER.error(e);
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private boolean validateProductName(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String name = req.getParameter("txtName");
        if (name != null) {
            if (!name.trim().isEmpty()) {
                check = true;
            } else {
                errorObj.setProductNameError("Product name cannot be blank");
            }

        } else {
            errorObj.setProductNameError("Product Name must not be null.");
        }
        return check;
    }

    private boolean validateProductDescription(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String descripion = req.getParameter("txtDescription");
        if (descripion != null) {
            if (!descripion.trim().isEmpty()) {
                check = true;
            } else {
                errorObj.setProductDescriptionError("Descripiton cannot be blank");
            }

        } else {
            errorObj.setProductNameError("Product Description must not be null.");
        }
        return check;
    }

    private boolean validateProductPrice(final HttpServletRequest req) {
        boolean check = Boolean.FALSE;
        final String txtPrice = req.getParameter("txtPrice");
        if (txtPrice != null) {
            if (!txtPrice.trim().isEmpty()) {
                if (!txtPrice.matches("\\d{1,}")) {
                    errorObj.setPriceError("Price are only numbers");
                } else {
                    check = true;
                }
            } else {
                errorObj.setPriceError("Price cannot be blank");
            }

        } else {
            errorObj.setPriceError("Price must not be null.");
        }
        return check;
    }

    private boolean validateDate(final HttpServletRequest req) throws ParseException {
        boolean check = Boolean.FALSE;
        final String txtCreateDate = req.getParameter("txtCreateDate");
        final String txtExpiredDate = req.getParameter("txtExpirationDate");
        Date createDate = new SimpleDateFormat("yyyy-MM-dd").parse(txtCreateDate);
        Date expireDate = new SimpleDateFormat("yyyy-MM-dd").parse(txtExpiredDate);
        if (createDate.before(expireDate)) {
            check = true;
        } else {
            errorObj.setDateError("Expired date must be late than created date");
        }
        return check;

    }

    private String getFileExtension(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                String clientFileName = "";
                if (s.contains(".")) {
                    clientFileName = s.substring(s.lastIndexOf("."), s.length() - 1);
                }
                return clientFileName;
            }
        }
        return null;
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
