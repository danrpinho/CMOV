package com.example.acmemarket_client.login;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.main.MainAuthActivity;
import com.example.acmemarket_client.mainmenu.MainMenuActivity;
import com.example.acmemarket_client.model.User;
import com.example.acmemarket_client.register.RegisterActivity;
import com.example.acmemarket_client.utils.Constants;
import com.example.acmemarket_client.utils.RSAKeys;

import java.security.KeyPair;

public class LoginActivity extends AppCompatActivity implements LoginView {

    private EditText username, password;
    LoginPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        presenter = new LoginPresenter(this, new LoginInteractor());
    }

    @Override
    protected void onStart() {
        super.onStart();

    }

    public void onLoginClick(View view) {
        username = findViewById(R.id.loginUsername);
        password = findViewById(R.id.loginPassword);

        if (TextUtils.isEmpty(username.getText()) || TextUtils.isEmpty(password.getText())) {
            Toast.makeText(this, R.string.register_field_empty, Toast.LENGTH_SHORT).show();
            return;
        }


        KeyPair kp = null;
        try {
            kp = RSAKeys.genKeys(this);
        } catch (Exception e) {
            Toast.makeText(this, R.string.key_generator_error, Toast.LENGTH_SHORT).show();
        }


        presenter.login(username.getText().toString(), password.getText().toString(), RSAKeys.KeyToString(kp.getPublic()));
    }

    @Override
    public void showError(@NonNull String errorMessage) {
        Toast.makeText(this, errorMessage, Toast.LENGTH_SHORT).show();
    }

    public void onRegisterLinkClick(View view) {
        Intent intent = new Intent(this, RegisterActivity.class);
        startActivity(intent);
    }

    @Override
    public void successful(@NonNull User user, @NonNull String token, @NonNull String publicKey) {
        MainAuthActivity.setLocalLogin(true);
        SharedPreferences preferences;
        preferences = this.getSharedPreferences("userInformation", MODE_PRIVATE);
        preferences.edit().putString(Constants.PreferenceKeys.JWT, token).apply();
        preferences.edit().putString(Constants.PreferenceKeys.UUID, user.getUuid()).apply();
        preferences.edit().putString(Constants.PreferenceKeys.SUPERMARKET_PUBLIC_KEY, publicKey).apply();
        Intent intent = new Intent(this, MainMenuActivity.class);
        startActivity(intent);

    }
}
