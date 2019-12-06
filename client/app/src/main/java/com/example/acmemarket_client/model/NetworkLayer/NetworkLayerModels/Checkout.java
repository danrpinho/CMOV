package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

import android.util.Base64;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
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

    public Checkout(ArrayList<Object> products, String uuid, int voucherId, boolean discount) throws NoSuchAlgorithmException {
        this.products = products;
        this.uuid = uuid;
        this.voucherId = voucherId;
        this.discount = discount;
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] toStringHashed= md.digest(toString().getBytes(StandardCharsets.ISO_8859_1));
        this.text = Base64.encodeToString(toStringHashed,Base64.DEFAULT);
    }

    public String getText() {
        return text;
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
