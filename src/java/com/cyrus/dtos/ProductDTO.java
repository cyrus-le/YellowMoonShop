/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class ProductDTO {

    private String productID;
    private String name;
    private String image;
    private String description;
    private double price;
    private int quantity;
    private int quantityDB;
    private Date createDate;
    private Date expirationDate;
    private CategoryDTO category;
    private boolean status;

    public ProductDTO() {
    }

    public ProductDTO(String productID, String name, String image, String description, double price, int quantity, Date createDate, Date expirationDate, CategoryDTO category, boolean status) {
        this.productID = productID;
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.category = category;
        this.status = status;
    }

    public ProductDTO(String productID, String name, String image, String description, double price, int quantity, int quantityDB, Date createDate, Date expirationDate, CategoryDTO category, boolean status) {
        this.productID = productID;
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.quantityDB = quantityDB;
        this.createDate = createDate;
        this.expirationDate = expirationDate;
        this.category = category;
        this.status = status;
    }

    public CategoryDTO getCategory() {
        return category;
    }

    public void setCategory(CategoryDTO category) {
        this.category = category;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getExpirationDate() {
        return expirationDate;
    }

    public void setExpirationDate(Date expirationDate) {
        this.expirationDate = expirationDate;
    }

    public String getProductID() {
        return productID;
    }

    public void setProductID(String productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getQuantityDB() {
        return quantityDB;
    }

    public void setQuantityDB(int quantityDB) {
        this.quantityDB = quantityDB;
    }

    public String getFmCreateDate() {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(this.createDate);
    }

    public String getFmExpirationDate() {
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        return df.format(this.expirationDate);
    }
}
