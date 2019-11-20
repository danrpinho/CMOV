package com.example.terminal.Model.NetworkLayer;

import com.example.terminal.Model.Checkout;
import com.example.terminal.Model.ServerResponse;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Headers;
import retrofit2.http.POST;


public interface SupermarketAPI {

    @Headers({"Content-Type: application/json"})
    @POST("/api/shoppingList")
    Call<ServerResponse> checkout(@Body Checkout request);


}
