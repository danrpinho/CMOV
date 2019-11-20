package com.example.acmemarket_client.main;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.biometric.BiometricManager;
import androidx.biometric.BiometricPrompt;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.login.LoginActivity;
import com.example.acmemarket_client.mainmenu.MainMenuActivity;
import com.example.acmemarket_client.register.RegisterActivity;
import com.example.acmemarket_client.utils.Constants;

import java.util.concurrent.Executor;

public class MainAuthActivity extends AppCompatActivity {
    public static boolean localLogin = false;
    private boolean canAuthenticate = false;
    /*****BIOMETRIC LOGIC **********/
    private Handler handler = new Handler();

    private Executor executor = command -> handler.post(command);

    public static void setLocalLogin(boolean isLoogedIn) {
        localLogin = isLoogedIn;
    }

    private void showBiometricPrompt(Context context) {
        BiometricPrompt.PromptInfo promptInfo =
                new BiometricPrompt.PromptInfo.Builder()
                        .setTitle("Biometric login for my app")
                        .setSubtitle("Log in using your biometric credential")
                        .setDeviceCredentialAllowed(true)
                        .build();

        BiometricPrompt biometricPrompt = new BiometricPrompt(MainAuthActivity.this,
                executor, new BiometricPrompt.AuthenticationCallback() {
            @Override
            public void onAuthenticationError(int errorCode,
                                              @NonNull CharSequence errString) {
                super.onAuthenticationError(errorCode, errString);
                Toast.makeText(getApplicationContext(),
                        "Authentication error: " + errString, Toast.LENGTH_SHORT)
                        .show();
            }

            @Override
            public void onAuthenticationSucceeded(
                    @NonNull BiometricPrompt.AuthenticationResult result) {
                super.onAuthenticationSucceeded(result);

                localLogin = true;

                Intent intent = new Intent(context, MainMenuActivity.class);
                startActivity(intent);
            }

            @Override
            public void onAuthenticationFailed() {
                super.onAuthenticationFailed();
                Toast.makeText(getApplicationContext(), "Authentication failed",
                        Toast.LENGTH_SHORT)
                        .show();
            }
        });
        biometricPrompt.authenticate(promptInfo);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main_auth);

        BiometricManager biometricManager = BiometricManager.from(this);
        switch (biometricManager.canAuthenticate()) {
            case BiometricManager.BIOMETRIC_SUCCESS:
                canAuthenticate = true;
                break;
            default:
                canAuthenticate = false;
                break;
        }
    }

    @Override
    protected void onStart() {
        super.onStart();
        SharedPreferences preferences = this.getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        if (!preferences.contains(Constants.PreferenceKeys.UUID)) {
            Intent intent = new Intent(this, RegisterActivity.class);
            startActivity(intent);
            return;
        }
        if (!preferences.contains(Constants.PreferenceKeys.JWT) || (!canAuthenticate&&!localLogin)) {
            Intent intent = new Intent(this, LoginActivity.class);
            startActivity(intent);
            return;
        }

        if (!localLogin&&canAuthenticate)
            showBiometricPrompt(this);
        else {
            Intent intent = new Intent(this, MainMenuActivity.class);
            startActivity(intent);
        }
    }
}
