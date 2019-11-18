package com.example.acmemarket_client.register;

import android.os.Handler;

import androidx.annotation.NonNull;

import com.example.acmemarket_client.model.NetworkLayer.Interactor;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.ErrorBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterRequestBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterResponse;
import com.example.acmemarket_client.model.User;
import com.google.gson.Gson;

import java.io.IOException;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RegisterInteractor implements Callback<RegisterResponse> {

    interface OnFinishedListener {
        void onFinished(User user, String jwt, String publicKey);
    }

    interface OnErrorListener {
        void onError(String errorMessage);
    }

    private OnFinishedListener successListener;
    private OnErrorListener errorListener;

    public void callAPIRegister(RegisterRequestBody body, @NonNull OnFinishedListener successListener, @NonNull OnErrorListener errorListener) {
        this.successListener = successListener;
        this.errorListener = errorListener;
        Call<RegisterResponse> call = Interactor.getInstance().getAPI().signup(body);
        call.enqueue(this);

    }

    @Override
    public void onResponse(Call<RegisterResponse> call, Response<RegisterResponse> response) {
        if (response.code() != 200) {
            try {
                Gson gson = new Gson();
                ErrorBody error = gson.fromJson(response.errorBody().string(), ErrorBody.class);
                new Handler().post(() -> errorListener.onError(error.getMessage()));
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        if (!response.body().getMessage().equals("Signup successful")) {
            new Handler().post(() -> errorListener.onError(response.body().getMessage()));
            return;
        }

        User user = response.body().getUser();
        String jwt = response.body().getToken();
        String publicKey = response.body().getSupermarketPublicKey();
        new Handler().post(() -> successListener.onFinished(user, jwt, publicKey));
    }

    @Override
    public void onFailure(Call<RegisterResponse> call, Throwable t) {
        new Handler().post(() -> errorListener.onError(t.getMessage()));
    }

}
