package com.example.terminal.Model;

import java.util.ArrayList;

public class Checkout {
    ArrayList<Object> products;
    String uuid;
    int voucherId;
    boolean discount;
    String text;
    String signed;

    public void setSigned(String signed) {
        this.signed = signed;
    }

    public Checkout(ArrayList<Object> products, String uuid, int voucherId, boolean discount) {
        this.products = products;
        this.uuid = uuid;
        this.voucherId = voucherId;
        this.discount = discount;
        this.text = toString();
    }

    public String getText() {
        return text;
    }

    @Override
    public String toString() {
        String toReturn = "";
        for(Object product: products){
            toReturn += product.toString();
        }
        toReturn+= uuid + voucherId + discount;
        return toReturn;
    }
}
