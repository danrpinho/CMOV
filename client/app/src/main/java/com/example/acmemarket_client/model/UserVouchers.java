package com.example.acmemarket_client.model;

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
