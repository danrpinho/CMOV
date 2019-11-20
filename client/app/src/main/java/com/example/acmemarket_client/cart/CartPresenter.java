package com.example.acmemarket_client.cart;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;

public class CartPresenter {
    private CartView view;
    private CartInteractor interactor;

    public CartPresenter(CartView view, CartInteractor interactor) {
        this.view = view;
        this.interactor = interactor;
    }

    public void getInfo(String token) {
        interactor.callAPIVouchers(token, this::onFinished, this::onError, this::onUnauthorized);
    }

    public void onFinished(UserVouchers userVouchers) {
        if (view != null) {
            view.successful(userVouchers);
        }
    }

    public void onError(String errorMessage) {
        if (view != null) {
            view.showError(errorMessage);
        }
    }

    public void onUnauthorized(){

    }


}
