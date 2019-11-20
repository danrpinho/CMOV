package com.example.acmemarket_client.checkout;

import android.content.SharedPreferences;
import android.graphics.Bitmap;
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
import com.google.gson.Gson;

import java.util.ArrayList;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;

public class CheckoutActivity extends AppCompatActivity {
    private final String TAG = "QR_Code";

    private ImageView qrCodeImageview;
    private Checkout checkoutInfo;
    private String qr_content;
    private CheckoutPresenter presenter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_checkout);

        qrCodeImageview = findViewById(R.id.img_qr_code);
        presenter = new CheckoutPresenter();

        checkoutInfo = generateCheckoutFromIntent();

        try {
            byte[] rsa_text = presenter.generateSignature(checkoutInfo);

            String requestSigned = Base64.encodeToString(rsa_text, Base64.DEFAULT);
            checkoutInfo.setSigned(requestSigned);
            Gson gson = new Gson();
            qr_content = gson.toJson(checkoutInfo);


        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, R.string.error_generate_QR, Toast.LENGTH_LONG).show();
            return;
        }

        showQRCode();
        clearCart();
    }

    private Checkout generateCheckoutFromIntent() {
        int voucherID = getIntent().getIntExtra("voucherID", 0);
        boolean discount = getIntent().getBooleanExtra("discount", false);
        SharedPreferences preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        String uuid = preferences.getString(Constants.PreferenceKeys.UUID, null);
        ArrayList<Object> cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);

        return new Checkout(cart, uuid, voucherID, discount);
    }

    private void clearCart() {
        SharedPreferences preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        preferences.edit().remove(Constants.PreferenceKeys.CART).apply();
    }

    private void showQRCode() {
        Thread t = new Thread(() -> {              // do the creation in a new thread to avoid ANR Exception
            final Bitmap bitmap;
            try {
                bitmap = presenter.encodeAsBitmap(qr_content, getResources().getColor(R.color.colorPrimary));
                runOnUiThread(() -> {                  // runOnUiThread method used to do UI task in main thread.
                    qrCodeImageview.setImageBitmap(bitmap);
                });
            } catch (Exception e) {
                Log.d(TAG, e.getMessage());
            }
        });
        t.start();
    }


}
