package com.example.acmemarket_client.utils;

import java.util.regex.Pattern;

public class Constants {

    public class PreferenceKeys{
        public static final String JWT = "jwt";
        public static final String USER_INFORMATION_PREFERENCES = "userInformation";
    }

    public class RESTAPI{
        public static final String IP = "127.0.0.1";
        public static final int PORT = 3000;
    }

    public class Encryption{
        public static final String ANDROID_KEYSTORE = "AndroidKeyStore";
        public static final int KEY_SIZE = 512;
        public static final String KEY_ALGO = "RSA";
        public static final int CERT_SERIAL = 12121212;
        public static final String ENC_ALGO = "RSA/NONE/PKCS1Padding";
        public static final String KEYNAME = "AcmeMarketKey";
        public static final int TAGID = 0x41636D65;
    }



}
