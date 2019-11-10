package com.example.acmemarket_client.mainmenu;

import androidx.annotation.Nullable;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.cart.CartActivity;
import com.example.acmemarket_client.checkout.CheckoutActivity;
import com.example.acmemarket_client.history.HistoryActivity;
import com.example.acmemarket_client.register.RegisterActivity;
import com.example.acmemarket_client.utils.Constants;

import java.util.Map;
import java.util.Set;

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
        //TODO Implement QR Code
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
