package com.example.acmemarket_client.model.NetworkLayer;

import android.telecom.CallScreeningService;


import com.example.acmemarket_client.model.ShoppingList;
import com.example.acmemarket_client.model.User;
import com.example.acmemarket_client.model.UserVouchers;

import java.util.List;

import okhttp3.RequestBody;
import retrofit2.Call;
import retrofit2.http.*;


public interface SupermarketAPI {


    @Headers({"Content-Type: application/json"})
    @POST("/login")
    Call<User> login(@Part("username") RequestBody username,
                     @Part("password") RequestBody password
    );

    @Headers({"Content-Type: application/json"})
    @POST("/signup")
    Call<User> signup(
            @Part("username") RequestBody username,
            @Part("name") RequestBody name,
            @Part("email") RequestBody email,
            @Part("password") RequestBody password,
            @Part("publicKey") RequestBody publicKey,
            @Part("uuid") RequestBody uuid
    );

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList")
    Call<List<ShoppingList>> getCompleteShoppingList(@Header("Authorization") String jwt);

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList/{id}")
    Call<ShoppingList> getCompleteShoppingList(@Path("id") int id, @Header("Authorization") String jwt);

    //TODO POST SHOPPING LIST

    @Headers({"Content-Type: application/json"})
    @GET("/api/voucher")
    Call<UserVouchers> getVouchers(@Header("Authorization") String jwt);


}
