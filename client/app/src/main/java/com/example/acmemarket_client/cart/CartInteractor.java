package com.example.acmemarket_client.cart;

import android.os.Handler;

import androidx.annotation.NonNull;

import com.example.acmemarket_client.model.NetworkLayer.Interactor;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

class CartInteractor  implements Callback<UserVouchers> {

    interface OnFinishedListener {
        void onFinished(UserVouchers userVouchers);
    }

    interface OnErrorListener {
        void onError(String errorMessage);
    }

    private OnFinishedListener successListener;
    private OnErrorListener errorListener;

    @Override
    public void onResponse(Call<UserVouchers> call, Response<UserVouchers> response) {
        if (response.body()==null){
            new Handler().post(() -> errorListener.onError("Something went wrong."));
            return;
        }

        UserVouchers userVouchers = response.body();
        new Handler().post(() -> successListener.onFinished(userVouchers));
    }

    @Override
    public void onFailure(Call<UserVouchers> call, Throwable t) {
        new Handler().post(() -> errorListener.onError(t.getMessage()));
    }

    public void callAPIVouchers(String token, @NonNull OnFinishedListener successListener, @NonNull OnErrorListener errorListener) {
        this.successListener = successListener;
        this.errorListener = errorListener;
        Call<UserVouchers> call = Interactor.getInstance().getAPI().getVouchers("Bearer " + token);
        call.enqueue(this);
    }




}
