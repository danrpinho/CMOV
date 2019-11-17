package com.example.acmemarket_client.history;

import com.example.acmemarket_client.model.ShoppingList;
import com.example.acmemarket_client.model.User;

import java.util.List;

public class HistoryPresenter {

    private HistoryView view;
    private HistoryInteractor interactor;

    HistoryPresenter(HistoryView view, HistoryInteractor interactor) {
        this.view = view;
        this.interactor = interactor;
    }

    public void getHistory(String token) {
        interactor.callAPIHistory(token, this::onFinished, this::onError);
    }

    public void onFinished(List<ShoppingList> list) {
        if (view != null) {
            view.successful(list);
        }
    }

    public void onError(String errorMessage) {
        if (view != null) {
            view.showError(errorMessage);
        }
    }


}
