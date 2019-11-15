package com.example.acmemarket_client.register;

import com.example.acmemarket_client.model.User;

public interface RegisterView {

    void showError(String errorMessage);

    void successful(User user, String token, String publicKey);
}
