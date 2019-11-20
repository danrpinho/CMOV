package com.example.acmemarket_client.cart;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.checkout.CheckoutActivity;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;
import com.example.acmemarket_client.model.Product;
import com.example.acmemarket_client.model.Voucher;
import com.example.acmemarket_client.utils.Constants;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import static com.example.acmemarket_client.utils.DBinSharedPreferences.getListObject;
import static com.example.acmemarket_client.utils.DBinSharedPreferences.putListObject;

public class CartActivity extends AppCompatActivity implements CartView {

    private SharedPreferences preferences;
    RecyclerView itemRecyclerView;
    private CartItemAdapter cartAdapter;
    private CartPresenter cartPresenter;
    private Button checkoutButton;
    private Switch voucherSwitch, balanceSwitch;
    private TextView voucherLabel, balanceLabel;
    private boolean discount;
    private int voucherID = 0;

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
        if (preferences.contains(Constants.PreferenceKeys.CART)) {
            cart = getListObject(preferences, Constants.PreferenceKeys.CART, Product.class);
        }
        updateCheckoutButton(cart);
        cartAdapter.addList(cart);
    }

    public void updateCheckoutButton(ArrayList<Object> cart) {
        float value = 0;
        for (Object product : cart) {
            value += ((Product) product).getPrice();
        }
        if (value != 0) {
            String price = String.format(Locale.getDefault(), "%.2f", value);
            checkoutButton.setText("Checkout (€" + price + ")");
        } else checkoutButton.setText("Checkout");
    }

    private void initViews() {
        checkoutButton = findViewById(R.id.buttonCheckout);
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

    @Override
    public void clearToken() {
        preferences.edit().remove(Constants.PreferenceKeys.JWT).apply();
    }

    private void prepareBalanceSwitch(float balance) {
        if (balance == 0) {
            balanceSwitch.setEnabled(false);
            discount = false;
        } else {
            balanceSwitch.setEnabled(true);
            discount = true;
        }
        String value = String.format(Locale.getDefault(), "%.2f", balance);
        balanceLabel.setText("Use available balance? (€ " + value + ")");
    }

    private void prepareVoucherSwitch(List<Voucher> vouchers) {
        int availableVouchers = vouchers.size();
        if (availableVouchers == 0) {
            voucherSwitch.setEnabled(false);
            voucherID = 0;
        } else {
            voucherSwitch.setEnabled(true);
            voucherID = vouchers.get(0).getId();
        }

        voucherLabel.setText("Use available vouchers? (" + availableVouchers + ")");

    }

    /**
     * Sets up the RecyclerView used in this activity by defining what it requires:
     * - a layout manager (in this case, a LinearLayoutManager)
     * - an adapter (using the CartItemAdapter class)
     */
    private void setupRecyclerView() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        itemRecyclerView.setLayoutManager(layoutManager);
        itemRecyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        cartAdapter = new CartItemAdapter(new ArrayList<>(0), this);
        itemRecyclerView.setAdapter(cartAdapter);
    }

    public void onCheckoutButtonClick(View view) {
        if (cartAdapter.getItemCount() == 0) {
            Toast.makeText(this, "You need to have items in your cart in order to checkout.", Toast.LENGTH_LONG).show();
        } else {
            Intent intent = new Intent(this, CheckoutActivity.class);
            intent.putExtra("voucherID", voucherID);
            intent.putExtra("discount", discount);
            startActivity(intent);
        }
    }

}
