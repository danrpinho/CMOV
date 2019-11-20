package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

public class LoginRequestBody {
    String username, password, publickey;

    public LoginRequestBody(String username, String password, String publickey) {
        this.username = username;
        this.password = password;
        this.publickey = publickey;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getPublickey() {
        return publickey;
    }
}
