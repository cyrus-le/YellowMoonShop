/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

/**
 *
 * @author Cyrus
 */
public class ProductErrorObj {

    private String productIDError;
    private String productNameError;
    private String imageError;
    private String productDescriptionError;
    private String priceError;
    private String quantityError;
    private String dateError;

    public String getProductIDError() {
        return productIDError;
    }

    public void setProductIDError(String productIDError) {
        this.productIDError = productIDError;
    }

    public String getProductNameError() {
        return productNameError;
    }

    public void setProductNameError(String productNameError) {
        this.productNameError = productNameError;
    }

    public String getImageError() {
        return imageError;
    }

    public void setImageError(String imageError) {
        this.imageError = imageError;
    }

    public String getProductDescriptionError() {
        return productDescriptionError;
    }

    public void setProductDescriptionError(String productDescriptionError) {
        this.productDescriptionError = productDescriptionError;
    }

    public String getPriceError() {
        return priceError;
    }

    public void setPriceError(String priceError) {
        this.priceError = priceError;
    }

    public String getQuantityError() {
        return quantityError;
    }

    public void setQuantityError(String quantityError) {
        this.quantityError = quantityError;
    }

    public String getDateError() {
        return dateError;
    }

    public void setDateError(String dateError) {
        this.dateError = dateError;
    }

}
