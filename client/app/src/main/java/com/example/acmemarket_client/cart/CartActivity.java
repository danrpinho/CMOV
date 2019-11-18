package com.example.acmemarket_client.cart;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.checkout.CheckoutActivity;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.model.Voucher;
import com.example.acmemarket_client.utils.Constants;

import java.util.ArrayList;
import java.util.List;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;
import static com.example.acmemarket_client.utils.DBinSharedPreferences.putListObject;

public class CartActivity extends AppCompatActivity implements CartView {

    private SharedPreferences preferences;
    RecyclerView itemRecyclerView;
    private CartItemAdapter cartAdapter;
    private CartPresenter cartPresenter;
    private Switch voucherSwitch, balanceSwitch;
    private TextView voucherLabel, balanceLabel;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        cartPresenter = new CartPresenter(this, new CartInteractor());
        setContentView(R.layout.activity_cart);
    }

    @Override
    protected void onStart() {
        super.onStart();
        preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        callsToServer();
        initViews();
        ArrayList<Object> cart = new ArrayList<>();
        if (preferences.contains(Constants.PreferenceKeys.CART)){
            cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);
        }
        cartAdapter.addList(cart);
    }

    private void initViews() {
        voucherSwitch = findViewById(R.id.voucherSwitch);
        balanceSwitch = findViewById(R.id.balanceSwitch);
        voucherLabel = findViewById(R.id.voucherLabel);
        balanceLabel = findViewById(R.id.balanceLabel);
        itemRecyclerView = (RecyclerView) findViewById(R.id.cart_item_list);
        setupRecyclerView();
    }

    private void callsToServer() {
        String token = preferences.getString(Constants.PreferenceKeys.JWT, null);
        cartPresenter.getInfo(token);
    }

    @Override
    public void saveCart(ArrayList<Object> items) {
        putListObject(preferences, Constants.PreferenceKeys.CART, items);
    }

    @Override
    public void showError(String errorMessage) {
        Toast.makeText(this, errorMessage, Toast.LENGTH_LONG).show();

    }

    @Override
    public void successful(UserVouchers userVouchers) {
        float balance = userVouchers.getUser().getBalance();
        List<Voucher> vouchers = userVouchers.getVouchers();

        prepareBalanceSwitch(balance);
        prepareVoucherSwitch(vouchers);

    }

    private void prepareBalanceSwitch(float balance) {
        if (balance == 0)
            balanceSwitch.setEnabled(false);
        else
            balanceSwitch.setEnabled(true);

        balanceLabel.setText("Use available balance? (" + balance + ")");
    }

    private void prepareVoucherSwitch(List<Voucher> vouchers) {
        int availableVouchers = vouchers.size();
        if (availableVouchers == 0)
            voucherSwitch.setEnabled(false);
        else
            voucherSwitch.setEnabled(true);

        voucherLabel.setText("Use available vouchers? (" + availableVouchers + ")");

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
        if (cartAdapter.getItemCount() == 0){
            Toast.makeText(this, "You need to have items in your cart in order to checkout.", Toast.LENGTH_LONG).show();
        } else {
            Intent intent = new Intent(this, CheckoutActivity.class);
            startActivity(intent);
        }
    }

}
