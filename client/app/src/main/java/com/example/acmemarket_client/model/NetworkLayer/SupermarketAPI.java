package com.example.acmemarket_client.model.NetworkLayer;

import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterRequestBody;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.RegisterResponse;
import com.example.acmemarket_client.model.ShoppingList;
import com.example.acmemarket_client.model.User;
import com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels.UserVouchers;

import java.util.List;

import okhttp3.RequestBody;
import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.GET;
import retrofit2.http.Header;
import retrofit2.http.Headers;
import retrofit2.http.POST;
import retrofit2.http.Part;
import retrofit2.http.Path;


public interface SupermarketAPI {


    @Headers({"Content-Type: application/json"})
    @POST("/login")
    Call<User> login(@Part("username") RequestBody username,
                     @Part("password") RequestBody password
    );


    @Headers({"Content-Type: application/json"})
    @POST("/signup")
    Call<RegisterResponse> signup(@Body RegisterRequestBody request);

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList")
    Call<List<ShoppingList>> getCompleteShoppingList(@Header("Authorization") String jwt);

    @Headers({"Content-Type: application/json"})
    @GET("/api/shoppingList/{id}")
    Call<ShoppingList> getShoppingList(@Path("id") int id, @Header("Authorization") String jwt);

    //TODO POST SHOPPING LIST

    @Headers({"Content-Type: application/json"})
    @GET("/api/voucher")
    Call<UserVouchers> getVouchers(@Header("Authorization") String jwt);


}
