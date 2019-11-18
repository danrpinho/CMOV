package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

public class SignedCheckout {
    String checkoutInfoStr;
    String signature;

    public SignedCheckout(String checkoutInfoStr, String signature) {
        this.checkoutInfoStr = checkoutInfoStr;
        this.signature = signature;
    }

    public String getCheckoutInfoStr() {
        return checkoutInfoStr;
    }
}
