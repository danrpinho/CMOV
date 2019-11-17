package com.example.acmemarket_client.history;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Toast;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.model.ShoppingList;
import com.example.acmemarket_client.utils.Constants;

import java.util.ArrayList;
import java.util.List;

public class HistoryActivity extends AppCompatActivity implements HistoryView{

    private SharedPreferences preferences;
    private HistoryPresenter presenter;
    private HistoryItemAdapter adapter;
    RecyclerView recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        presenter = new HistoryPresenter(this, new HistoryInteractor());
        preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        setupRecyclerView();
        setContentView(R.layout.activity_history);
    }

    @Override
    protected void onStart(){
        super.onStart();
    }

    private void setupRecyclerView() {
        String token = preferences.getString(Constants.PreferenceKeys.JWT, null);
        presenter.getHistory(token);
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        adapter = new HistoryItemAdapter(new ArrayList<>(0));
        recyclerView.setAdapter(adapter);
    }

    @Override
    public void showError(@NonNull String errorMessage) {
        Toast.makeText(this, errorMessage, Toast.LENGTH_LONG).show();
    }

    @Override
    public void successful(List<ShoppingList> list) {
        adapter.setList(list);
    }

}
