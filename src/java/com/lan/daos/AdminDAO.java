/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.daos;

import com.lan.dtos.CategoryDTO;
import com.lan.dtos.ProductDTO;
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
public class AdminDAO {

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

    public List<ProductDTO> getProductList(String search, int offset, int next) throws NamingException, SQLException {
        List<ProductDTO> list = new ArrayList<>();
        ProductDTO dto = null;
        CategoryDTO categoryDTO = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                Date createDate = null, expirationDate = null;
                String sql = "SELECT p.productID, p.name, p.image, p.description, p.price, p.categoryID, c.category, p.quantity, p.createDate, p.expirationDate, p.status "
                        + "FROM products p, categories c "
                        + "WHERE p.name like '%" + search + "%' AND c.categoryID = p.categoryID "
                        + "ORDER BY createDate DESC "
                        + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, offset);
                stm.setInt(2, next);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String productID = rs.getString("productID");
                    String name = rs.getString("name");
                    String image = rs.getString("image");
                    String description = rs.getString("description");
                    double price = Double.parseDouble(rs.getString("price"));
                    int quantity = Integer.parseInt(rs.getString("quantity"));
                    String categoryID = rs.getString("categoryID");
                    String category = rs.getString("category");
                    Timestamp createTimestamp = rs.getTimestamp("createDate");
                    Timestamp expiTimestamp = rs.getTimestamp("expirationDate");

                    if (createTimestamp != null) {
                        createDate = new Date(createTimestamp.getTime());
                    }
                    if (expiTimestamp != null) {
                        expirationDate = new Date(expiTimestamp.getTime());
                    }
                    boolean status = rs.getBoolean("status");
                    categoryDTO = new CategoryDTO(categoryID, category, description);
                    dto = new ProductDTO(productID, name, image, description, Math.ceil(price), quantity, createDate, expirationDate, categoryDTO, status);
                    list.add(dto);
                }
            }
        } finally {
            closeConnection();
        }
        return list;

    }

    public int getAllRecords() throws SQLException, ClassNotFoundException, NamingException {
        int numberRecord = 0;
        String sql = "SELECT COUNT(*) FROM products";
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

    public int getAllRecordsBySearch(String search) throws NamingException, SQLException {
        int count = 0;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "SELECT COUNT(productID) AS numberOfProducts "
                        + "FROM products "
                        + "WHERE name like '%" + search + "%' ";
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

    public boolean insertProduct(ProductDTO dto) throws SQLException, NamingException {
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO products (productID, name, image, description, price, quantity, categoryID, status, createDate, expirationDate) "
                        + "VALUES(?,?,?,?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getProductID());
                stm.setString(2, dto.getName());
                stm.setString(3, dto.getImage());
                stm.setString(4, dto.getDescription());
                stm.setDouble(5, dto.getPrice());
                stm.setInt(6, dto.getQuantity());
                stm.setString(7, dto.getCategory().getCategoryID());
                stm.setBoolean(8, dto.isStatus());
                stm.setDate(9, new java.sql.Date(dto.getCreateDate().getTime()));
                stm.setDate(10, new java.sql.Date(dto.getExpirationDate().getTime()));
                check = stm.executeUpdate() > 0;
            }
        } finally {
            closeConnection();
        }
        return check;
    }

    public boolean updateProduct(ProductDTO dto) throws SQLException, NamingException {
        boolean flag = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "UPDATE products SET name=?,image=?,description=?,price=?, quantity=?, categoryID=?,status=?, createDate=?, expirationDate=? "
                        + "WHERE productID = ?";
                stm = conn.prepareStatement(sql);
                stm.setString(1, dto.getName());
                stm.setString(2, dto.getImage());
                stm.setString(3, dto.getDescription());
                stm.setDouble(4, dto.getPrice());
                stm.setInt(5, dto.getQuantity());
                stm.setString(6, dto.getCategory().getCategoryID());
                stm.setBoolean(7, dto.isStatus());
                stm.setDate(8, new java.sql.Date(dto.getCreateDate().getTime()));
                stm.setDate(9, new java.sql.Date(dto.getExpirationDate().getTime()));
                stm.setString(10, dto.getProductID());
                stm.executeUpdate();
                flag = true;
            }
        } finally {
            closeConnection();
        }
        return flag;
    }

    public void addUpdateRecord(String productID, String userID) throws SQLException, NamingException {
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO updateRecord (userID, productID, date) VALUES (?,?,?) ";
                stm = conn.prepareStatement(sql);
                stm.setString(1, userID);
                stm.setString(2, productID);
                stm.setDate(3, new java.sql.Date(new Date().getTime()));
                stm.executeUpdate();
            }
        } finally {
            closeConnection();
        }
    }
}
