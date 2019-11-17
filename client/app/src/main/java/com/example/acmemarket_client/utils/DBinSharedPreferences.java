package com.example.acmemarket_client.utils;

import android.content.SharedPreferences;
import android.text.TextUtils;

import com.google.gson.Gson;

import java.util.ArrayList;
import java.util.Arrays;

public class DBinSharedPreferences {

    public static void putListObject(SharedPreferences preferences, String key, ArrayList<Object> objArray) {
        checkForNullKey(key);
        Gson gson = new Gson();
        ArrayList<String> objStrings = new ArrayList<>();
        for (Object obj : objArray) {
            objStrings.add(gson.toJson(obj));
        }
        putListString(preferences, key, objStrings);
    }

    public static void putListString(SharedPreferences preferences, String key, ArrayList<String> stringList) {
        checkForNullKey(key);
        String[] myStringList = stringList.toArray(new String[stringList.size()]);
        preferences.edit().remove(key);
        preferences.edit().putString(key, TextUtils.join("‚‗‚", myStringList)).apply();
    }

    public static void checkForNullKey(String key) {
        if (key == null) {
            throw new NullPointerException();
        }
    }

    public static ArrayList<Object> getListObject(SharedPreferences preferences, String key, Class<?> mClass) {
        Gson gson = new Gson();

        ArrayList<String> objStrings = getListString(preferences, key);
        ArrayList<Object> objects = new ArrayList<>();

        for (String jObjString : objStrings) {
            Object value = gson.fromJson(jObjString, mClass);
            objects.add(value);
        }
        return objects;
    }

    public static ArrayList<String> getListString(SharedPreferences preferences, String key) {
        return new ArrayList<>(Arrays.asList(TextUtils.split(preferences.getString(key, ""), "‚‗‚")));
    }
}
