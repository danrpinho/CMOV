package com.example.acmemarket_client.utils;

import android.content.Context;
import android.security.KeyPairGeneratorSpec;
import android.util.Base64;


import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.AlgorithmParameterSpec;
import java.security.spec.X509EncodedKeySpec;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.security.auth.x500.X500Principal;

import static com.example.acmemarket_client.utils.Constants.Encryption.KEY_ALGO;

public class RSAKeys {


    public static KeyPair genKeys(Context context) throws Exception {

        Calendar start = new GregorianCalendar();
        Calendar end = new GregorianCalendar();
        end.add(Calendar.YEAR, 20);
        KeyPairGenerator kgen = KeyPairGenerator.getInstance(KEY_ALGO, Constants.Encryption.ANDROID_KEYSTORE);
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

    public static KeyPair loadKeyPair() throws Exception{
        KeyStore ks = KeyStore.getInstance(Constants.Encryption.ANDROID_KEYSTORE);
        ks.load(null);
        KeyStore.Entry entry = ks.getEntry(Constants.Encryption.KEYNAME, null);
        boolean hasKey = (entry != null);
        if (hasKey) {
            PublicKey pub = ((KeyStore.PrivateKeyEntry)entry).getCertificate().getPublicKey();
            PrivateKey pri = ((KeyStore.PrivateKeyEntry)entry).getPrivateKey();
            return new KeyPair(pub,pri);
        }

        return null;
    }

    public static String KeyToString(PublicKey publicKey){
        String pkcs1pem="";
        pkcs1pem += Base64.encodeToString(publicKey.getEncoded(), Base64.DEFAULT);


        return pkcs1pem;
    }

    public static PublicKey StringToKey(String publicKeyString) throws Exception{

        byte[] keyBytes = Base64.decode(publicKeyString, Base64.DEFAULT);
        X509EncodedKeySpec spec = new X509EncodedKeySpec(keyBytes);
        KeyFactory keyFactory = KeyFactory.getInstance(KEY_ALGO);


        return keyFactory.generatePublic(spec);
    }

}
