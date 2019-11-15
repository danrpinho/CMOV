package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

import com.example.acmemarket_client.model.User;

public class RegisterResponse {
    private User user;
    private String message;
    private String token;
    private String supermarketPublicKey;

    public User getUser() {
        return user;
    }

    public String getSupermarketPublicKey() {
        return supermarketPublicKey;
    }

    public String getMessage() {
        return message;
    }

    public String getToken() {
        return token;
    }
}
