package com.example.acmemarket_client.utils;

import android.util.Pair;

public class QRCodeSupport {
    public float qIntegersToFloat(int euros, int cents){
        if (cents > 100 || euros < 0 || cents < 0)
            throw new IllegalArgumentException();
        return euros + 0.01f*cents;
    }

    public Pair<Integer, Integer> floatToQIntegers(float price){
        int newPrice = (int) Math.floor((double) price * 100);
        Integer euros = newPrice / 100;
        Integer cents = newPrice % 100;
        return new Pair<>(euros, cents);
    }


}
