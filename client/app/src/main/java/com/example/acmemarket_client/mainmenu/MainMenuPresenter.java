package com.example.acmemarket_client.mainmenu;

import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.utils.Constants;
import com.example.acmemarket_client.utils.QRCodeSupport;
import com.example.acmemarket_client.utils.RSAKeys;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.UUID;

import javax.crypto.Cipher;

public class MainMenuPresenter {
    MainMenuView view;
    ArrayList<Object> cart;

    public MainMenuPresenter(MainMenuView view, ArrayList<Object> cart) {
        this.view = view;
        this.cart = cart;
    }

    public byte[] decryptProduct(byte [] encTag, String supermarketPublicKey) throws Exception{
        Cipher cipher = Cipher.getInstance(Constants.Encryption.ENC_ALGO);
        cipher.init(Cipher.DECRYPT_MODE, RSAKeys.StringToKey(supermarketPublicKey));
        return cipher.doFinal(encTag);
    }

    public void addProduct(byte[] clearTag){

        ByteBuffer tag = ByteBuffer.wrap(clearTag);
        tag.getInt();
        long most = tag.getLong();
        long less = tag.getLong();
        UUID id = new UUID(most, less);
        int euros = tag.getInt();
        int cents = tag.getInt();
        byte l = tag.get();
        byte[] bName = new byte[l];
        tag.get(bName);
        String name = new String(bName, StandardCharsets.ISO_8859_1);

        cart.add(new Product(id.toString(),name, QRCodeSupport.qIntegersToFloat(euros,cents)));
        view.saveCart();
        return;
    }

    public ArrayList<Object> getCart() {
        return cart;
    }
}
