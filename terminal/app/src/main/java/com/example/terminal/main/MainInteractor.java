package com.example.terminal.main;

import android.os.Handler;

import androidx.annotation.NonNull;

import com.example.terminal.Model.Checkout;
import com.example.terminal.Model.NetworkLayer.Interactor;
import com.example.terminal.Model.ServerResponse;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class MainInteractor implements Callback<ServerResponse> {


    @Override
    public void onResponse(Call<ServerResponse> call, Response<ServerResponse> response) {
        if (response.code() != 201) {
            try {
                Gson gson = new Gson();
                ServerResponse error = gson.fromJson(response.errorBody().string(), ServerResponse.class);
                new Handler().post(() -> onFinishedListener.onFinished(error.getMessage()));
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }


        new Handler().post(() -> onFinishedListener.onFinished(response.body().getMessage()));
        return;
    }

    @Override
    public void onFailure(Call<ServerResponse> call, Throwable t) {
        new Handler().post(() -> onFinishedListener.onFinished(t.getMessage()));
    }

    interface OnFinishedListener {
        void onFinished(String message);
    }


    private OnFinishedListener onFinishedListener;


    public void callAPICheckout(Checkout body, @NonNull OnFinishedListener onFinishedListener) {
        this.onFinishedListener = onFinishedListener;

        Call<ServerResponse> call = Interactor.getInstance().getAPI().checkout(body);
        call.enqueue(this);
    }


}
