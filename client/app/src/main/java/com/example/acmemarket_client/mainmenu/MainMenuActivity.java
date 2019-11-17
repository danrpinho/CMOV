package com.example.acmemarket_client.mainmenu;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.cart.CartActivity;
import com.example.acmemarket_client.checkout.CheckoutActivity;
import com.example.acmemarket_client.history.HistoryActivity;
import com.example.acmemarket_client.register.RegisterActivity;
import com.example.acmemarket_client.utils.Constants;
import com.example.acmemarket_client.utils.RSAKeys;

import java.nio.ByteBuffer;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

import javax.crypto.Cipher;

public class MainMenuActivity extends AppCompatActivity {

    SharedPreferences preferences;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);
        ActionBar bar = getSupportActionBar();
        if (bar != null) {
            //bar.setIcon(R.drawable.);
            bar.setDisplayShowHomeEnabled(true);
        }

    }

    public void onScanButtonClick(View view){
        try {
            Intent intent = new Intent(Constants.QRCodes.ACTION_SCAN);
            intent.putExtra("SCAN_MODE",  "QR_CODE_MODE");
            startActivityForResult(intent, 0);
        }
        catch (ActivityNotFoundException anfe) {
            showDialog(this, "No Scanner Found", "Download a scanner code activity?", "Yes", "No").show();
        }
    }

    private static AlertDialog showDialog(final Activity act, CharSequence title, CharSequence message, CharSequence buttonYes, CharSequence buttonNo) {
        AlertDialog.Builder downloadDialog = new AlertDialog.Builder(act);
        downloadDialog.setTitle(title);
        downloadDialog.setMessage(message);
        downloadDialog.setPositiveButton(buttonYes, (d, i) -> {
            Uri uri = Uri.parse("market://search?q=pname:" + "com.google.zxing.client.android");
            Intent intent = new Intent(Intent.ACTION_VIEW, uri);
            act.startActivity(intent);
        });
        downloadDialog.setNegativeButton(buttonNo, null);
        return downloadDialog.show();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 0) {
            if (resultCode == RESULT_OK) {
                String contents = data.getStringExtra("SCAN_RESULT");
                if (contents != null)
                    decodeAndShow(contents.getBytes(StandardCharsets.ISO_8859_1));
            }
        }
    }
    void decodeAndShow(byte[] encTag) {
        byte[] clearTag = null;
        try {
            Cipher cipher = Cipher.getInstance(Constants.Encryption.ENC_ALGO);
            cipher.init(Cipher.DECRYPT_MODE, RSAKeys.StringToKey(getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES,MODE_PRIVATE).getString(Constants.PreferenceKeys.SUPERMARKET_PUBLIC_KEY, "")));
            clearTag = cipher.doFinal(encTag);
        }catch (Exception e){

        }

        ByteBuffer tag = ByteBuffer.wrap(clearTag);
        int tId = tag.getInt();
        long most = tag.getLong();
        long less = tag.getLong();
        UUID id = new UUID(most, less);
        int euros = tag.getInt();
        int cents = tag.getInt();
        byte l = tag.get();
        byte[] bName = new byte[l];
        tag.get(bName);
        String name = new String(bName, StandardCharsets.ISO_8859_1);

        return;
    }


    public void onHistoryButtonClick(View view){
        Intent intent = new Intent(this, HistoryActivity.class);
        startActivity(intent);
    }

    public void onCartButtonClick(View view){
        Intent intent = new Intent(this, CartActivity.class);
        startActivity(intent);
    }

    public void onCheckoutButtonClick(View view){
        Intent intent = new Intent(this, CheckoutActivity.class);
        startActivity(intent);
    }

    @Override
    protected void onStart() {
        super.onStart();
        preferences = this.getSharedPreferences("userInformation",MODE_PRIVATE);
        if(!preferences.contains(Constants.PreferenceKeys.JWT)){
            Intent intent = new Intent(this, RegisterActivity.class);
            startActivity(intent);
        }
    }
}
