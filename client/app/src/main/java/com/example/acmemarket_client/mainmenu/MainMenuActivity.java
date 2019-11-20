package com.example.acmemarket_client.mainmenu;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.cart.CartActivity;
import com.example.acmemarket_client.history.HistoryActivity;
import com.example.acmemarket_client.main.MainAuthActivity;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.utils.Constants;

import java.nio.charset.StandardCharsets;
import java.util.ArrayList;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;
import static com.example.acmemarket_client.utils.DBinSharedPreferences.putListObject;

public class MainMenuActivity extends AppCompatActivity implements MainMenuView {

    private SharedPreferences preferences;
    private MainMenuPresenter presenter;

    // Displays the "log in" prompt.

    /******************************/
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

    public void onScanButtonClick(View view) {

        if (presenter.getCart().size() >= 10) {
            showDialog(this, "", getString(R.string.cart_full), null, getString(R.string.button_ok));
            return;
        }

        try {
            Intent intent = new Intent(Constants.QRCodes.ACTION_SCAN);
            intent.putExtra(Constants.QRCodes.INTENT_SCAN_MODE, Constants.QRCodes.INTENT_QR_CODE_MODE);
            startActivityForResult(intent, 0);
        } catch (ActivityNotFoundException anfe) {
            showDialog(this, getString(R.string.no_scanner), getString(R.string.download_scanner), getString(R.string.button_yes), getString(R.string.button_no)).show();
        }
    }

    private static AlertDialog showDialog(final Activity act, CharSequence title, CharSequence message, CharSequence buttonYes, CharSequence buttonDismiss) {
        AlertDialog.Builder downloadDialog = new AlertDialog.Builder(act);
        downloadDialog.setTitle(title);
        downloadDialog.setMessage(message);
        if (buttonYes != null) {
            downloadDialog.setPositiveButton(buttonYes, (d, i) -> {
                Uri uri = Uri.parse(Constants.QRCodes.URI_QRCODE_SCANNER);
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                act.startActivity(intent);
            });
        }
        downloadDialog.setNegativeButton(buttonDismiss, null);
        return downloadDialog.show();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 0 && resultCode == RESULT_OK) {
            String contents = data.getStringExtra(Constants.QRCodes.SCAN_RESULT);
            if (contents != null)
                decodeAndShow(contents.getBytes(StandardCharsets.ISO_8859_1));
        }
    }

    private void decodeAndShow(byte[] encTag) {
        byte[] clearTag;
        try {
            clearTag = presenter.decryptProduct(encTag, preferences.getString(Constants.PreferenceKeys.SUPERMARKET_PUBLIC_KEY, null));
            presenter.addProduct(clearTag);
        } catch (Exception e) {
            showMessage(e.getMessage());
        }

        return;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

    }

    @Override
    public void showMessage(String message) {
        Toast.makeText(this, message, Toast.LENGTH_SHORT).show();
    }

    public void onHistoryButtonClick(View view) {

        Intent intent = new Intent(this, HistoryActivity.class);
        startActivity(intent);
    }

    public void onCartButtonClick(View view) {

        Intent intent = new Intent(this, CartActivity.class);
        startActivity(intent);
    }


    @Override
    public void saveCart() {
        putListObject(preferences, Constants.PreferenceKeys.CART, presenter.getCart());
    }

    @Override
    protected void onStart() {
        super.onStart();
        preferences = this.getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        ArrayList<Object> cart = new ArrayList<>();
        if (preferences.contains(Constants.PreferenceKeys.CART))
            cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);

        presenter = new MainMenuPresenter(this, cart);

        if (!preferences.contains(Constants.PreferenceKeys.JWT)) {
            Intent intent = new Intent(this, MainAuthActivity.class);
            startActivity(intent);
            return;
        }
    }
}
