package com.example.terminal.main;

import android.os.Handler;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.example.terminal.Model.Checkout;
import com.example.terminal.Model.NetworkLayer.Interactor;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainInteractor implements Callback<Object> {


    @Override
    public void onResponse(Call<Object> call, Response<Object> response) {

    }

    @Override
    public void onFailure(Call<Object> call, Throwable t) {

    }

    interface OnFinishedListener {
        void onFinished(String message);
    }

    interface OnErrorListener {
        void onError(String errorMessage);
    }

    private OnFinishedListener successListener;
    private OnErrorListener errorListener;

    public void callAPICheckout(Checkout body, @NonNull OnFinishedListener successListener, @NonNull OnErrorListener errorListener) {
        this.successListener = successListener;
        this.errorListener = errorListener;
        Call<Object> call = Interactor.getInstance().getAPI().checkout(body);
        call.enqueue(this);
    }


}
