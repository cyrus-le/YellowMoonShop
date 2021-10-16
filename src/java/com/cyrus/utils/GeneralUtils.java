/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.utils;

import java.text.DecimalFormat;

/**
 *
 * @author Cyrus
 */
public class GeneralUtils {

    public static String normalizePrice(final String price) {
        DecimalFormat formatter = null;
        switch (price.length()) {
            case 4:
                formatter = new DecimalFormat("#,###");
                break;
            case 5:
                formatter = new DecimalFormat("##,###");
                break;
            case 6:
                formatter = new DecimalFormat("###,###");
                break;
            case 7:
                formatter = new DecimalFormat("#,###,###");
                break;
            case 8:
                formatter = new DecimalFormat("##,###,###");
                break;
            case 9:
                formatter = new DecimalFormat("###,###,###");
                break;
            case 10:
                formatter = new DecimalFormat("#,###,###,###");
                break;
            case 11:
                formatter = new DecimalFormat("##,###,###,###");
                break;
            case 12:
                formatter = new DecimalFormat("###,###,###,###");
                break;
            default:
                break;
        }
        return formatter.format(Double.parseDouble(price)) + " VND";
    }
}
