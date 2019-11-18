package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

import java.util.ArrayList;

public class Checkout {
    ArrayList<Object> products;
    String uuid;
    int voucherId;
    boolean discount;

    public Checkout(ArrayList<Object> products, String uuid, int voucherId, boolean discount) {
        this.products = products;
        this.uuid = uuid;
        this.voucherId = voucherId;
        this.discount = discount;
    }
}
