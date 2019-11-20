package com.example.acmemarket_client.model;

public class Product {
    private String uuid, name;
    private float price;
    private int id;


    public Product(String uuid, String name, float price) {
        this.uuid = uuid;
        this.name = name;
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public float getPrice() {
        return price;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return uuid;
    }
}
