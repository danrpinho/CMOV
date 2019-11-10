package com.example.acmemarket_client.model;

import java.util.ArrayList;

public class ShoppingList {
    private float totalCost, discounted;
    private int id;
    private ArrayList<Product> productItems;

    public float getTotalCost() {
        return totalCost;
    }

    public float getDiscounted() {
        return discounted;
    }

    public int getId() {
        return id;
    }

    public ArrayList<Product> getProductItems() {
        return productItems;
    }

}
