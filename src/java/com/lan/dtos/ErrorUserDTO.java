/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lan.dtos;

/**
 *
 * @author Admin
 */
public class ErrorUserDTO {

    private String userIDError, fullNameError, passwordError, roleIDError, repasswordError, statusdError, phoneError, addressError;

    public ErrorUserDTO() {
        this.userIDError = "";
        this.fullNameError = "";
        this.passwordError = "";
        this.roleIDError = "";
        this.repasswordError = "";
        this.statusdError = "";
        this.phoneError = "";
        this.addressError = "";
    }

    public ErrorUserDTO(String userIDError, String fullNameError, String passwordError, String roleIDError, String repasswordError, String statusdError, String phoneError, String addressError) {
        this.userIDError = userIDError;
        this.fullNameError = fullNameError;
        this.passwordError = passwordError;
        this.roleIDError = roleIDError;
        this.repasswordError = repasswordError;
        this.statusdError = statusdError;
        this.phoneError = phoneError;
        this.addressError = addressError;
    }

    public String getPhoneError() {
        return phoneError;
    }

    public void setPhoneError(String phoneError) {
        this.phoneError = phoneError;
    }

    public String getAddressError() {
        return addressError;
    }

    public void setAddressError(String addressError) {
        this.addressError = addressError;
    }

    public String getStatusdError() {
        return statusdError;
    }

    public void setStatusdError(String statusdError) {
        this.statusdError = statusdError;
    }

    public String getUserIDError() {
        return userIDError;
    }

    public void setUserIDError(String userIDError) {
        this.userIDError = userIDError;
    }

    public String getFullNameError() {
        return fullNameError;
    }

    public void setFullNameError(String fullNameError) {
        this.fullNameError = fullNameError;
    }

    public String getPasswordError() {
        return passwordError;
    }

    public void setPasswordError(String passwordError) {
        this.passwordError = passwordError;
    }

    public String getRoleIDError() {
        return roleIDError;
    }

    public void setRoleIDError(String roleIDError) {
        this.roleIDError = roleIDError;
    }

    public String getRepasswordError() {
        return repasswordError;
    }

    public void setRepasswordError(String repasswordError) {
        this.repasswordError = repasswordError;
    }
}
