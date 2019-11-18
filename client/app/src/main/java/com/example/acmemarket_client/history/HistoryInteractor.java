package com.example.acmemarket_client.history;

import android.os.Handler;

import androidx.annotation.NonNull;

import com.example.acmemarket_client.model.NetworkLayer.Interactor;
import com.example.acmemarket_client.model.ShoppingList;

import java.util.List;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class HistoryInteractor implements Callback<List<ShoppingList>> {
        //TODO add Bearer + token
    interface OnFinishedListener {
        void onFinished(List<ShoppingList> shoppingLists);
    }

    interface OnErrorListener {
        void onError(String errorMessage);
    }

    private OnFinishedListener successListener;
    private OnErrorListener errorListener;

    public void callAPIHistory(String token, @NonNull OnFinishedListener successListener, @NonNull OnErrorListener errorListener) {
        this.successListener = successListener;
        this.errorListener = errorListener;
        Call<List<ShoppingList>> call = Interactor.getInstance().getAPI().getCompleteShoppingList("Bearer " + token);
        call.enqueue(this);
    }

    @Override
    public void onResponse(Call<List<ShoppingList>> call, Response<List<ShoppingList>> response) {
        if (response.body() == null) {
            new Handler().post(() -> errorListener.onError("Something went wrong."));
            return;
        }

        List<ShoppingList> shoppingLists = response.body();
        new Handler().post(() -> successListener.onFinished(shoppingLists));
    }

    @Override
    public void onFailure(Call<List<ShoppingList>> call, Throwable t) {
        new Handler().post(() -> errorListener.onError(t.getMessage()));
    }

}
