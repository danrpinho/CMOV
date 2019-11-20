package com.example.terminal.Model;

import java.util.ArrayList;

public class Checkout {
    ArrayList<Product> products;
    String uuid;
    int voucherId;
    boolean discount;
    String text;
    String signed;


    public Checkout(ArrayList<Product> products, String uuid, int voucherId, boolean discount) {
        this.products = products;
        this.uuid = uuid;
        this.voucherId = voucherId;
        this.discount = discount;
        this.text = toString();
    }

    @Override
    public String toString() {
        String toReturn = "";
        for (Object product : products) {
            toReturn += product.toString();
        }
        toReturn += uuid + voucherId + discount;
        return toReturn;
    }
}
