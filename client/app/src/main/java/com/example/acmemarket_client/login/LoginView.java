package com.example.acmemarket_client.login;

import com.example.acmemarket_client.model.User;

public interface LoginView {

    void showError(String errorMessage);

    void successful(User user, String token, String publicKey);
}
