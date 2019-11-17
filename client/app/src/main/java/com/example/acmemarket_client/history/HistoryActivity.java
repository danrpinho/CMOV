package com.example.acmemarket_client.history;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.content.SharedPreferences;
import android.os.Bundle;
import com.example.acmemarket_client.R;
import com.example.acmemarket_client.utils.Constants;

import java.util.ArrayList;

public class HistoryActivity extends AppCompatActivity {

    private SharedPreferences preferences;
    private HistoryPresenter presenter;
    private HistoryItemAdapter adapter;
    RecyclerView recyclerView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        preferences = getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        setupRecyclerView();
        setContentView(R.layout.activity_history);
    }

    private void setupRecyclerView() {
        LinearLayoutManager layoutManager = new LinearLayoutManager(this);
        recyclerView.setLayoutManager(layoutManager);
        recyclerView.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        adapter = new HistoryItemAdapter(new ArrayList<>(0));
        recyclerView.setAdapter(adapter);
    }
}
