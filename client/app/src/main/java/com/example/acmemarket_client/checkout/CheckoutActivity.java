package com.example.acmemarket_client.checkout;

import android.content.SharedPreferences;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.util.Base64;
import android.util.Log;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.Checkout;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.utils.Constants;
import com.example.acmemarket_client.utils.RSAKeys;
import com.google.gson.Gson;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

import java.nio.charset.StandardCharsets;
import java.security.KeyPair;
import java.security.Signature;
import java.util.ArrayList;
import java.util.Hashtable;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;

public class CheckoutActivity extends AppCompatActivity {
    private final String TAG = "QR_Code";

    private ImageView qrCodeImageview;
    private Checkout checkoutInfo;
    private String qr_content;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_checkout);

        qrCodeImageview = findViewById(R.id.img_qr_code);


        int voucherID = getIntent().getIntExtra("voucherID", 0);
        boolean discount = getIntent().getBooleanExtra("discount", false);
        SharedPreferences preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        String uuid = preferences.getString(Constants.PreferenceKeys.UUID, null);
        ArrayList<Object> cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);

        checkoutInfo = new Checkout(cart, uuid, voucherID, discount);

        /*checkoutInfo = new Checkout(cart, uuid, voucherID, discount);
        Gson gson = new Gson();
        String checkoutInfoStr = gson.toJson(checkoutInfo);*/

        try {
            KeyPair kp = RSAKeys.loadKeyPair();
            Signature signature = Signature.getInstance("SHA256withRSA");
            signature.initSign(kp.getPrivate());
            signature.update(checkoutInfo.getText().getBytes(StandardCharsets.ISO_8859_1));
            byte[] rsa_text= signature.sign();

            String requestSigned = Base64.encodeToString(rsa_text, Base64.DEFAULT);
            checkoutInfo.setSigned(requestSigned);
            Gson gson = new Gson();
            qr_content = gson.toJson(checkoutInfo);
            //qr_content = requestStr.getBytes(StandardCharsets.ISO_8859_1);

            signature.initVerify(kp.getPublic());
            signature.update(checkoutInfo.getText().getBytes(StandardCharsets.ISO_8859_1));
            boolean verified = signature.verify(rsa_text);
            if(!verified)
                throw new Exception();
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this,"There was a problem generating your QRCode", Toast.LENGTH_LONG).show();
            return;
        }

        Thread t = new Thread(() -> {              // do the creation in a new thread to avoid ANR Exception
            final Bitmap bitmap;
            try {
                bitmap = encodeAsBitmap(qr_content);
                runOnUiThread(() -> {                  // runOnUiThread method used to do UI task in main thread.
                    qrCodeImageview.setImageBitmap(bitmap);
                });
            } catch (Exception e) {
                Log.d(TAG, e.getMessage());
            }
        });
        t.start();
    }

    Bitmap encodeAsBitmap(String str) throws WriterException {
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
                pixels[offset + x] = result.get(x, y) ? getResources().getColor(R.color.colorPrimary) : Color.WHITE;
            }
        }
        Bitmap bitmap = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        bitmap.setPixels(pixels, 0, w, 0, 0, w, h);
        return bitmap;
    }
}
