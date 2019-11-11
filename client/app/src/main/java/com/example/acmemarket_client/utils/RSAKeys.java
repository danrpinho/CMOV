package com.example.acmemarket_client.utils;

import android.content.Context;
import android.security.KeyPairGeneratorSpec;


import java.math.BigInteger;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PublicKey;
import java.security.spec.AlgorithmParameterSpec;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.security.auth.x500.X500Principal;

public class RSAKeys {


    public static KeyPair genKeys(Context context) throws Exception {

        Calendar start = new GregorianCalendar();
        Calendar end = new GregorianCalendar();
        end.add(Calendar.YEAR, 20);
        KeyPairGenerator kgen = KeyPairGenerator.getInstance(Constants.Encryption.KEY_ALGO, Constants.Encryption.ANDROID_KEYSTORE);
        AlgorithmParameterSpec spec = new KeyPairGeneratorSpec.Builder((context))
                .setKeySize(Constants.Encryption.KEY_SIZE)
                .setAlias(Constants.Encryption.KEYNAME)
                .setSubject(new X500Principal("CN=" + Constants.Encryption.KEYNAME))
                .setSerialNumber(BigInteger.valueOf(Constants.Encryption.CERT_SERIAL))
                .setStartDate(start.getTime())
                .setEndDate(end.getTime())
                .build();
        kgen.initialize(spec);
        KeyPair kp = kgen.generateKeyPair();
        return kp;
    }

    public static boolean loadKeyPair(){
        return true;
    }

    public static String KeyToString(PublicKey publicKey){
       //WTF
        return "";
    }

    public static PublicKey StringToKey(String publicKeyString){
        return new PublicKey() {
            @Override
            public String getAlgorithm() {
                return null;
            }

            @Override
            public String getFormat() {
                return null;
            }

            @Override
            public byte[] getEncoded() {
                return new byte[0];
            }
        };
    }

}
