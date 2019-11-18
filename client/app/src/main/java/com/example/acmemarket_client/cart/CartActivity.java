package com.example.acmemarket_client.cart;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.checkout.CheckoutActivity;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.utils.Constants;

import java.util.ArrayList;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;
import static com.example.acmemarket_client.utils.DBinSharedPreferences.putListObject;

public class CartActivity extends AppCompatActivity implements CartView {

    private SharedPreferences preferences;
    RecyclerView itemRecyclerView;
    private CartItemAdapter cartAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cart);
    }

    @Override
    protected void onStart() {
        super.onStart();
        itemRecyclerView = (RecyclerView) findViewById(R.id.cart_item_list);
        preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        setupRecyclerView();
        ArrayList<Object> cart = new ArrayList<>();
        if (preferences.contains(Constants.PreferenceKeys.CART)){
            cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);
        }
        cartAdapter.addList(cart);
    }

    @Override
    public void saveCart(ArrayList<Object> items) {
        putListObject(preferences, Constants.PreferenceKeys.CART, items);
    }

    /**
     * Sets up the RecyclerView used in this activity by defining what it requires:
     * - a layout manager (in this case, a LinearLayoutManager)
     * - an adapter (using the CartItemAdapter class)
     */
    private void setupRecyclerView(){
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        itemRecyclerView.setLayoutManager(layoutManager);
        itemRecyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        cartAdapter = new CartItemAdapter(new ArrayList<>(0), this);
        itemRecyclerView.setAdapter(cartAdapter);
    }

    public void onCheckoutButtonClick(View view) {

        Intent intent = new Intent(this, CheckoutActivity.class);
        startActivity(intent);

    }

}
