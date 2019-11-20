package com.example.acmemarket_client.cart;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;

import java.util.ArrayList;

interface CartView {

    void saveCart(ArrayList<Object> list);

    void showError(String errorMessage);

    void successful(UserVouchers userVouchers);
}
