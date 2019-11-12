package com.example.acmemarket_client.register;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterRequestBody;
import com.example.acmemarket_client.model.User;

public class RegisterPresenter {
    private RegisterView view;
    private RegisterInteractor interactor;

    RegisterPresenter(RegisterView view, RegisterInteractor interactor) {
        this.view = view;
        this.interactor = interactor;
    }

    public void register(String name, String email, String username, String cardInfo, String password, String publickey) {
        interactor.callAPIRegister(new RegisterRequestBody(name, email, username, cardInfo, password, publickey), this::onFinished, this::onError);
    }

    public void onFinished(User user, String jwt) {
        if (view != null) {
            view.successful(user, jwt);
        }
    }

    public void onError(String errorMessage) {
        if (view != null) {
            view.showError(errorMessage);
        }
    }


}
