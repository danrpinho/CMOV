package com.example.acmemarket_client.model;

public class User {
    private String email, name, username, uuid, supermarketPublicKey;
    private float balance,totalSpent;
    private int id;

    public String getEmail() {
        return email;
    }

    public String getName() {
        return name;
    }

    public String getUsername() {
        return username;
    }

    public String getUuid() {
        return uuid;
    }

    public String getSupermarketPublicKey() {
        return supermarketPublicKey;
    }

    public float getBalance() {
        return balance;
    }

    public float getTotalSpent() {
        return totalSpent;
    }

    public int getId() {
        return id;
    }
}
