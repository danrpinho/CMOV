package com.example.acmemarket_client.model.NetworkLayer.NetworkLayerModels;

import com.example.acmemarket_client.model.User;
import com.example.acmemarket_client.model.Voucher;

import java.util.List;

public class UserVouchers {
    User user;
    List<Voucher> vouchers;

    public User getUser() {
        return user;
    }

    public List<Voucher> getVouchers() {
        return vouchers;
    }
}
