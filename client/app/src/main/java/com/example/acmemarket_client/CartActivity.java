package com.example.acmemarket_client;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;

public class CartActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setupRecyclerView();
        setContentView(R.layout.activity_cart);
    }

    RecyclerView itemRecyclerView;
    private CartItemAdapter cartAdapter;

    /**
     * Sets up the RecyclerView used in this activity by defining what it requires:
     * - a layout manager (in this case, a LinearLayoutManager)
     * - an adapter (using the CartItemAdapter class)
     */

    private void setupRecyclerView(){
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        itemRecyclerView.setLayoutManager(layoutManager);
        itemRecyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        cartAdapter = new CartItemAdapter();
        itemRecyclerView.setAdapter(cartAdapter);
    }
}
