package com.example.acmemarket_client.utils;

public class Constants {

    public class PreferenceKeys {
        public static final String JWT = "jwt";
        public static final String USER_INFORMATION_PREFERENCES = "userInformation";
        public static final String UUID = "uuid";
        public static final String SUPERMARKET_PUBLIC_KEY = "supermarketpublickey";
    }

    public class RESTAPI {
        public static final String IP = "http://b64af78a.ngrok.io";
    }

    public class Encryption {
        public static final String ANDROID_KEYSTORE = "AndroidKeyStore";
        public static final int KEY_SIZE = 512;
        public static final String KEY_ALGO = "RSA";
        public static final int CERT_SERIAL = 12121212;
        public static final String ENC_ALGO = "RSA/NONE/PKCS1Padding";
        public static final String KEYNAME = "AcmeMarketKey";
        public static final int TAGID = 0x41636D65;
    }

    public class QRCodes{
        public static final String ACTION_SCAN = "com.google.zxing.client.android.SCAN";
    }
}
