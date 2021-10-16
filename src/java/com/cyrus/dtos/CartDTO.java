/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author Admin
 */
public class CartDTO {

    private Map<String, ProductDTO> cart;

    public CartDTO() {
    }

    public CartDTO(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public Map<String, ProductDTO> getCart() {
        return cart;
    }

    public void setCart(Map<String, ProductDTO> cart) {
        this.cart = cart;
    }

    public void add(ProductDTO dto) {
        if (this.cart == null) {
            cart = new HashMap<>();
        }
        if (cart.containsKey(dto.getProductID())) {
            int quantity = cart.get(dto.getProductID()).getQuantity();
            dto.setQuantity(quantity + 1);
        }
        cart.put(dto.getProductID(), dto);
    }

    public void delete(String id) {
        if (cart == null) {
            return;
        }
        if (cart.containsKey(id)) {
            cart.remove(id);
        }
    }

    public void update(String id, ProductDTO dto) {
        if (cart != null) {
            if (cart.containsKey(id)) {
                cart.put(id, dto);
            }
        }
    }
}
