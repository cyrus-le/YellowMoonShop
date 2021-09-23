/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.dtos.CartDTO;
import com.lan.dtos.CategoryDTO;
import com.lan.dtos.OrderDetailsDTO;
import com.lan.dtos.PaymentDTO;
import com.lan.dtos.ProductDTO;
import com.lan.dtos.UserDTO;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.naming.NamingException;
import com.lan.utils.DBUtils;

/**
 *
 * @author Admin
 */
public class UserDAO {

    private Connection conn = null;
    private PreparedStatement stm = null;
    private ResultSet rs = null;

    private void closeConnection() throws SQLException {
        if (rs != null) {
            rs.close();
        }
        if (stm != null) {
            stm.close();
        }
        if (conn != null) {
            conn.close();
        }
    }

    public UserDTO checkLogin(String userID, String password) throws SQLException, NamingException {
        String fullName = "";
        String roleID = "";
        String phone = "";
        String address = "";
        boolean status;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT fullName, phone, address, roleID, status FROM Accounts WHERE userID=? AND password=? AND status=1";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                if (rs.next()) {
                    fullName = rs.getString("fullName");
                    phone = rs.getString("phone");
                    address = rs.getString("address");
                    roleID = rs.getString("roleID");
                    status = rs.getBoolean("status");
                    return new UserDTO(userID, "", fullName, phone, address, roleID, status);
                }
            }
        } finally {
            closeConnection();
        }
        return null;
    }

    public boolean checkPhoneExist(String phone) throws SQLException, NamingException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT phone FROM Accounts WHERE phone=? ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, phone);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return false;
                }
            }
        } finally {
            closeConnection();
        }
        return true;
    }

    public int getAllRecords() throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM products WHERE status = 1";
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    numberRecord = rs.getInt(1);
                }
            }
        } finally {
            closeConnection();
        }

        return numberRecord;
    }

    public int getAllRecordsBySearch(String categoryID, String search) throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM products "
                + "FULL OUTER JOIN categories ON categories.categoryID = products.categoryID "
                + "WHERE (products.name like '%" + search + "%' OR categories.category like '%" + search + "%') "
                + "AND (products.status = 1 AND products.quantity >= 1 "
                + (!categoryID.equals("") ? ("AND products.categoryID = '" + categoryID + "') ") : ") ");                 
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    numberRecord = rs.getInt(1);
                }
            }
        } finally {
            closeConnection();
        }

        return numberRecord;
    }

    public boolean insertAccount(UserDTO dto) throws SQLException, NamingException, NoSuchAlgorithmException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO Accounts(userID, fullName, password, phone, address, roleID, status) VALUES(?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getUserID());
                stm.setString(2, dto.getFullName());
                stm.setString(3, dto.getPassword());
                stm.setString(4, dto.getPhone());
                stm.setString(5, dto.getAddress());
                stm.setString(6, dto.getRoleID());
                stm.setBoolean(7, true);
                stm.executeUpdate();
                return true;
            }
        } finally {
            closeConnection();
        }
        return false;
    }

    public List<ProductDTO> getProductList(String search, int offset, int next, String categoryID) throws NamingException, SQLException {
        List<ProductDTO> list = null;
        try {
            conn = DBUtils.getConnection();
            String sql = "SELECT products.productID, products.name, products.image, products.description, products.price, products.categoryID, categories.category, products.quantity, products.createDate, products.expirationDate, products.status "
                    + "FROM products "
                    + "FULL OUTER JOIN categories ON categories.categoryID = products.categoryID "
                    + "WHERE (products.name like '%" + search + "%' OR categories.category like '%" + search + "%') "
                    + "AND (products.status = 1 AND products.quantity >= 1 "
                    + (!categoryID.equals("") ? ("AND products.categoryID = '" + categoryID + "') ") : ") ")
                    + "ORDER BY createDate DESC "
                    + "OFFSET ? ROW FETCH FIRST ? ROWS ONLY";
            if (conn != null) {
                stm = conn.prepareStatement(sql);
                stm.setInt(1, offset);
                stm.setInt(2, next);
                rs = stm.executeQuery();
                list = new ArrayList<>();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    String category = rs.getString("category");
                    Timestamp createTimestamp = rs.getTimestamp("createDate");
                    Timestamp expiTimestamp = rs.getTimestamp("expirationDate");
                    Date createDate = null, expirationDate = null;
                    if (createTimestamp != null) {
                        createDate = new Date(createTimestamp.getTime());
                    }
                    if (expiTimestamp != null) {
                        expirationDate = new Date(expiTimestamp.getTime());
                    }
                    boolean status = rs.getBoolean("status");
                    list.add(new ProductDTO(productID, name, image, description, price, quantity, createDate, expirationDate, new CategoryDTO(categoryID, category, ""), status));
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public boolean updateStatusWhenQuantityEq0(String productID) throws SQLException, NamingException {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE products SET status = 0 WHERE productID = ? AND quantity = 0";
                stm = conn.prepareStatement(sql);
                stm.setString(1, sql);
                check = stm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public List<CategoryDTO> getCategoryList() throws SQLException, NamingException {
        List<CategoryDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT categoryID, category, description FROM categories ";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String categoryID = rs.getString("categoryID");
                    String category = rs.getString("category");
                    String description = rs.getString("description");
                    list.add(new CategoryDTO(categoryID, category, description));
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public int getNumberOfProducts(String name, String categoryID) throws NamingException, SQLException {
        int count = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(productID) AS numberOfProducts "
                        + "FROM products "
                        + "WHERE name like '%" + name + "%' AND status=1 "
                        + (!categoryID.equals("") ? ("AND categoryID='" + categoryID + "' ") : "");

                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt("numberOfProducts");
                }
            }
        } finally {
            closeConnection();
        }
        return count;
    }

    public List<PaymentDTO> getPaymentList() throws SQLException, NamingException {
        List<PaymentDTO> list = new ArrayList<>();
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT paymentID, paymentName, status FROM payments ";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String paymentID = rs.getString("paymentID");
                    String paymentName = rs.getString("paymentName");
                    boolean status = rs.getBoolean("status");
                    list.add(new PaymentDTO(paymentID, paymentName, status));
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public String getUserAddress(String userID) throws SQLException, NamingException {
        String address = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT address FROM accounts WHERE userID=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    address = rs.getString("address");
                }
            }
        } finally {
            closeConnection();
        }
        return address;
    }

    public String getUserPhone(String userID) throws SQLException, NamingException {
        String phone = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT phone FROM accounts WHERE userID=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    phone = rs.getString("phone");
                }
            }
        } finally {
            closeConnection();
        }
        return phone;
    }

    public int getQuantity(String productID) throws SQLException, NamingException {
        int quantity = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT quantity FROM products WHERE productID=?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, productID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    quantity = rs.getInt("quantity");
                }
            }
        } finally {
            closeConnection();
        }
        return quantity;
    }

    public String insertOrder(String userID, String name, String address, String phone, double totalPrice, String paymentID, boolean paymentStatus, Connection conn) throws SQLException, NamingException, NoSuchAlgorithmException {
        String orderID = null;
        try {
            String sql = "INSERT INTO orders(userID, orderDate, shippingAddress, totalPrice, paymentID, phone, orderID, name, paymentStatus) VALUES(?,?,?,?,?,?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, userID);
            stm.setTimestamp(2, new java.sql.Timestamp(new Date().getTime()));
            stm.setString(3, address);
            stm.setDouble(4, totalPrice);
            stm.setString(5, paymentID);
            stm.setString(6, phone);
            orderID = String.valueOf(System.currentTimeMillis());
            stm.setString(7, orderID);
            stm.setString(8, name);
            stm.setBoolean(9, paymentStatus);
            stm.executeUpdate();
        } finally {
            closeConnection();
        }
        return orderID;
    }

    public void updateProduct(ProductDTO dto, Connection conn) throws SQLException, ClassNotFoundException, NamingException {
        try {
            String sql = "UPDATE products SET quantity=? WHERE productID=?";
            stm = conn.prepareStatement(sql);
            int quantity = getQuantity(dto.getProductID());
            stm.setInt(1, quantity - dto.getQuantity());
            stm.setString(2, dto.getProductID());
            stm.executeUpdate();
        } finally {
            closeConnection();
        }
    }

    public void insertOrderDetail(String orderID, ProductDTO dto, Connection conn) throws ClassNotFoundException, SQLException {

        try {
            String sql = "INSERT INTO OrderDetails(orderID,productID,quantity,price) VALUES(?,?,?,?)";
            stm = conn.prepareStatement(sql);
            stm.setString(1, orderID);
            stm.setString(2, dto.getProductID());
            stm.setInt(3, dto.getQuantity());
            stm.setDouble(4, dto.getPrice());
            stm.executeUpdate();
        } finally {
            closeConnection();
        }
    }

    public String confirm(String userID, String name, String address, String phone, double totalPrice, String paymentID, CartDTO cart, boolean paymentStatus) throws SQLException {

        try {
            conn = DBUtils.getConnection();
            conn.setAutoCommit(false);
            String orderID = insertOrder(userID, name, address, phone, totalPrice, paymentID, paymentStatus, conn);
            for (ProductDTO dto : cart.getCart().values()) {
                updateProduct(dto, conn);
                insertOrderDetail(orderID, dto, conn);
            }
            conn.commit();
            return orderID;
        } catch (ClassNotFoundException | NoSuchAlgorithmException | SQLException | NamingException e) {
            e.printStackTrace();
            conn.rollback();
        } finally {
            closeConnection();
        }
        return "";
    }

    public List<ProductDTO> getOrderProductList(String orderID) throws SQLException, NamingException {
        List<ProductDTO> list = new ArrayList<>();

        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT p.productID, p.name, o.price, o.quantity, p.status "
                        + "FROM products p, orderDetails o "
                        + "WHERE o.orderID=? AND o.productID=p.productID ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    int quantity = rs.getInt("quantity");
                    boolean status = rs.getBoolean("status");
                    list.add(new ProductDTO(productID, name, null, null, price, quantity, null, null, null, status));
                }
            }
        } finally {
            closeConnection();
        }
        return list;
    }

    public OrderDetailsDTO getOrder(String orderID, String userID1) throws SQLException, NamingException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT o.userID, o.name, o.shippingAddress, o.phone, o.orderDate, o.totalPrice, p.paymentName, o.paymentStatus "
                        + "FROM orders o, payments p "
                        + "WHERE orderID=? AND o.paymentID=p.paymentID ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, orderID);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String userID = rs.getString("userID");
                    if (!userID.equals(userID1)) {
                        return null;
                    }
                    String name = rs.getString("name");
                    String address = rs.getString("shippingAddress");
                    String phone = rs.getString("phone");
                    String paymentName = rs.getString("paymentName");
                    int totalPrice = rs.getInt("totalPrice");
                    Date orderDate = rs.getTimestamp("orderDate");
                    boolean paymentStatus = rs.getBoolean("paymentStatus");
                    return new OrderDetailsDTO(orderID, userID, name, address, phone, orderDate, totalPrice, paymentName, paymentStatus, getOrderProductList(orderID));
                }
            }
        } finally {
            closeConnection();
        }
        return null;
    }
}
