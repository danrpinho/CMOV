package com.example.acmemarket_client.model.NetworkLayer;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.LoginRequestBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterRequestBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterResponse;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;
import com.example.acmemarket_client.model.ShoppingList;

import java.util.List;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;
import retrofit2.http.Path;


public interface SupermarketAPI {


    @Headers({"Content-Type: application/json"})
    @POST("/login")
    Call<RegisterResponse> login(@Body LoginRequestBody request);


    @Headers({"Content-Type: application/json"})
    @POST("/signup")
    Call<RegisterResponse> signup(@Body RegisterRequestBody request);

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList")
    Call<List<ShoppingList>> getCompleteShoppingList(@Header("Authorization") String jwt);

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList/{id}")
    Call<ShoppingList> getShoppingList(@Path("id") int id, @Header("Authorization") String jwt);


    @Headers({"Content-Type: application/json"})
    @GET("/api/voucher")
    Call<UserVouchers> getVouchers(@Header("Authorization") String jwt);


}
