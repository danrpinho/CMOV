package com.example.acmemarket_client.model.NetworkLayer;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.ErrorBody;
import com.example.acmemarket_client.utils.Constants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class Interactor {
    private static Interactor interactor;
    private SupermarketAPI api;
    public static final String SOMETHING_WRONG = "Something went wrong";

    private Interactor() {
        Gson gson = new GsonBuilder()
                .setLenient()
                .create();

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(Constants.RESTAPI.IP)
                .addConverterFactory(GsonConverterFactory.create(gson))
                .build();

        this.api = retrofit.create(SupermarketAPI.class);
    }

    public static Interactor getInstance() {
        if (interactor == null)
            interactor = new Interactor();

        return interactor;
    }

    public SupermarketAPI getAPI() {
        return api;
    }

    public static String getMessageFromErrorBody(Response<?> response) {
        try {
            Gson gson = new Gson();
            ErrorBody error = gson.fromJson(response.errorBody().string(), ErrorBody.class);
            return error.getMessage();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return SOMETHING_WRONG;
    }
}

