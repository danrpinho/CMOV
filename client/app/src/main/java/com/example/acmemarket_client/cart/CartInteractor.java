package com.example.acmemarket_client.cart;

import android.os.Handler;

import androidx.annotation.NonNull;

import com.example.acmemarket_client.model.NetworkLayer.Interactor;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;
import com.example.acmemarket_client.utils.Constants;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

class CartInteractor implements Callback<UserVouchers> {

    interface OnFinishedListener {
        void onFinished(UserVouchers userVouchers);
    }

    interface OnErrorListener {
        void onError(String errorMessage);
    }

    interface OnUnauthorizedListener {
        void onUnauthorized();
    }

    private OnFinishedListener successListener;
    private OnErrorListener errorListener;
    private OnUnauthorizedListener unauthorizedListener;

    @Override
    public void onResponse(Call<UserVouchers> call, Response<UserVouchers> response) {
        if (response.code() != 200) {
            if (response.code() == 401)
                new Handler().post(() -> unauthorizedListener.onUnauthorized());
            else
                new Handler().post(() -> errorListener.onError(Interactor.getMessageFromErrorBody(response)));
            return;
        }

        if (response.body() == null) {
            new Handler().post(() -> errorListener.onError(Interactor.SOMETHING_WRONG));
            return;
        }

        UserVouchers userVouchers = response.body();
        new Handler().post(() -> successListener.onFinished(userVouchers));
    }

    @Override
    public void onFailure(Call<UserVouchers> call, Throwable t) {
        new Handler().post(() -> errorListener.onError(t.getMessage()));
    }

    public void callAPIVouchers(String token, @NonNull OnFinishedListener successListener, @NonNull OnErrorListener errorListener, @NonNull OnUnauthorizedListener unauthorizedListener) {
        this.successListener = successListener;
        this.errorListener = errorListener;
        this.unauthorizedListener = unauthorizedListener;
        Call<UserVouchers> call = Interactor.getInstance().getAPI().getVouchers(Constants.RESTAPI.AUTHORIZATION_HEADER + token);
        call.enqueue(this);
    }
}
