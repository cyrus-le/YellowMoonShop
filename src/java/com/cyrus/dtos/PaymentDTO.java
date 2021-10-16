/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

/**
 *
 * @author Admin
 */
public class PaymentDTO {

    private String paymentID;
    private String paymentName;
    private boolean status;

    public PaymentDTO() {
    }

    public PaymentDTO(String paymentID, String paymentName, boolean status) {
        this.paymentID = paymentID;
        this.paymentName = paymentName;
        this.status = status;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public String getPaymentName() {
        return paymentName;
    }

    public void setPaymentName(String paymentName) {
        this.paymentName = paymentName;
    }

}
