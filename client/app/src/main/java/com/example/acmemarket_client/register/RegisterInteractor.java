package com.example.acmemarket_client.register;

import android.util.Log;

import com.example.acmemarket_client.model.NetworkLayer.Interactor;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterRequestBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterResponse;
import com.example.acmemarket_client.model.User;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

public class RegisterInteractor implements Callback<RegisterResponse> {

    interface OnFinishedListener {
        void onFinished(User user, String jwt);
    }

    //final OnFinishedListener listener;

    public void callAPIRegister(RegisterRequestBody body) {
        Call<RegisterResponse> call = Interactor.getInstance().getAPI().signup(body);
        call.enqueue(this);

    }

    @Override
    public void onResponse(Call<RegisterResponse> call, Response<RegisterResponse> response) {
        Log.d("Chamada", "chamada ok");
    }

    @Override
    public void onFailure(Call<RegisterResponse> call, Throwable t) {
        Log.d("Chamada", "chamada ok");
    }

}
