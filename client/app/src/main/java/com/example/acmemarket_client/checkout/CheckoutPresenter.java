package com.example.acmemarket_client.checkout;

import android.graphics.Bitmap;
import android.graphics.Color;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.Checkout;
import com.example.acmemarket_client.utils.RSAKeys;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.Signature;
import java.util.Hashtable;

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

    public Bitmap encodeAsBitmap(String str, int colorPrimary) throws WriterException {

        int DIMENSION = 1000;
        BitMatrix result;

        Hashtable<EncodeHintType, String> hints = new Hashtable<>();
        hints.put(EncodeHintType.CHARACTER_SET, "ISO-8859-1");
        try {
            result = new MultiFormatWriter().encode(str, BarcodeFormat.QR_CODE, DIMENSION, DIMENSION, hints);
        } catch (IllegalArgumentException iae) {
            return null;
        }
        int w = result.getWidth();
        int h = result.getHeight();
        int[] pixels = new int[w * h];
        for (int y = 0; y < h; y++) {
            int offset = y * w;
            for (int x = 0; x < w; x++) {
                pixels[offset + x] = result.get(x, y) ? colorPrimary : Color.WHITE;
            }
        }
        Bitmap bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, w, 0, 0, w, h);
        return bitmap;

    }
}
