package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

public class RegisterRequestBody {
    String name, email, username, cardInfo, password, publickey;

    public RegisterRequestBody(String name, String email, String username, String cardInfo, String password, String publickey) {
        this.name = name;
        this.email = email;
        this.username = username;
        this.cardInfo = cardInfo;
        this.password = password;
        this.publickey = publickey;
    }
}
