package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

import com.example.acmemarket_client.model.User;

public class RegisterResponse {
    private User user;
    private String message;
    private String token;

    public User getUser() {
        return user;
    }

    public String getMessage() {
        return message;
    }

    public String getToken() {
        return token;
    }
}
