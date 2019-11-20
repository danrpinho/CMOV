package com.example.acmemarket_client.checkout;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.Checkout;
import com.example.acmemarket_client.utils.RSAKeys;

import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.Signature;

public class CheckoutPresenter {

    public byte[] generateSignature(Checkout checkoutInfo) throws Exception {
        KeyPair kp = RSAKeys.loadKeyPair();
        Signature signature = Signature.getInstance("SHA256withRSA");
        signature.initSign(kp.getPrivate());
        signature.update(checkoutInfo.getText().getBytes(StandardCharsets.ISO_8859_1));
        byte[] rsa_text = signature.sign();

        signature.initVerify(kp.getPublic());
        signature.update(checkoutInfo.getText().getBytes(StandardCharsets.ISO_8859_1));
        boolean verified = signature.verify(rsa_text);
        if (!verified)
            throw new Exception();

        return rsa_text;
    }

}
