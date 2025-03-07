package com.example.terminal.main;

import com.example.terminal.Model.Checkout;
import com.google.gson.Gson;

public class MainPresenter {

    private MainView view;
    private MainInteractor interactor;

    MainPresenter(MainView view, MainInteractor interactor) {
        this.view = view;
        this.interactor = interactor;
    }

    public void checkout(String checkoutStr) {
        Gson gson = new Gson();
        Checkout checkout = gson.fromJson(checkoutStr, Checkout.class);
        interactor.callAPICheckout(checkout, this::onFinished);
    }

    public void onFinished(String message) {
        if (view != null) {
            view.showMessage(message);
            return;
        }
    }
}
