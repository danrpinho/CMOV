package com.example.acmemarket_client.login;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.LoginRequestBody;
import com.example.acmemarket_client.model.User;

public class LoginPresenter {
    private LoginView view;
    private LoginInteractor interactor;

    LoginPresenter(LoginView view, LoginInteractor interactor) {
        this.view = view;
        this.interactor = interactor;
    }

    public void login(String username, String password, String publickey) {
        interactor.callAPILogin(new LoginRequestBody(username, password, publickey), this::onFinished, this::onError);
    }

    public void onFinished(User user, String jwt, String publicKey) {
        if (view != null) {
            view.successful(user, jwt, publicKey);
        }
    }

    public void onError(String errorMessage) {
        if (view != null) {
            view.showError(errorMessage);
        }
    }


}
