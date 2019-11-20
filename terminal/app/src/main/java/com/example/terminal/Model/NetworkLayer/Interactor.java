package com.example.terminal.Model.NetworkLayer;


import com.example.terminal.utils.Constants;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class Interactor {
    private static Interactor interactor;
    private SupermarketAPI api;

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
}
