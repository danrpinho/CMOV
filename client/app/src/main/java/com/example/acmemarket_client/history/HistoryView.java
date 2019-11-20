package com.example.acmemarket_client.history;

import com.example.acmemarket_client.model.ShoppingList;

import java.util.List;

public interface HistoryView {
    void showError(String errorMessage);

    void successful(List<ShoppingList> list);
}
