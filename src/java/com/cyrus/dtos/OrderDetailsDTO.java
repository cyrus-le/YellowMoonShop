/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.util.Date;
import java.util.List;

/**
 *
 * @author Cyrus
 */
public class OrderDetailsDTO {

    private String orderID;
    private String userID;
    private String name;
    private String address;
    private String phone;
    private Date orderDate;
    private int totalPrice;
    private String paymentName;
    private boolean paymentStatus;
    private List<ProductDTO> products;

    public String getPaymentName() {
        return paymentName;
    }

    public void setPaymentName(String paymentName) {
        this.paymentName = paymentName;
    }

    public OrderDetailsDTO(String orderID, String userID, String name, String address, String phone, Date orderDate, int totalPrice, String paymentName, boolean paymentStatus, List<ProductDTO> products) {
        this.orderID = orderID;
        this.userID = userID;
        this.name = name;
        this.address = address;
        this.phone = phone;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.paymentName = paymentName;
        this.paymentStatus = paymentStatus;
        this.products = products;
    }

    public OrderDetailsDTO(String orderID, String userID, String phone, int totalPrice, List<ProductDTO> products) {
        this.orderID = orderID;
        this.userID = userID;
        this.phone = phone;
        this.totalPrice = totalPrice;
        this.products = products;
    }
    

    public OrderDetailsDTO() {
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public boolean isPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(boolean paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public List<ProductDTO> getProducts() {
        return products;
    }

    public void setProducts(List<ProductDTO> products) {
        this.products = products;
    }

}
