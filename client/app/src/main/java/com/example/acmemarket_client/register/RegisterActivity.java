package com.example.acmemarket_client.register;

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
import com.example.acmemarket_client.login.LoginActivity;
import com.example.acmemarket_client.main.MainAuthActivity;
import com.example.acmemarket_client.mainmenu.MainMenuActivity;
import com.example.acmemarket_client.model.User;
import com.example.acmemarket_client.utils.Constants;
import com.example.acmemarket_client.utils.RSAKeys;

import java.security.KeyPair;

public class RegisterActivity extends AppCompatActivity implements RegisterView {

    private EditText name, username, email, password, cardInfo;
    RegisterPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);
        presenter = new RegisterPresenter(this, new RegisterInteractor());
    }

    @Override
    protected void onStart() {
        super.onStart();

    }

    public void onLoginLinkClick(View view) {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
    }

    public void onRegisterClick(View view) {
        name = findViewById(R.id.registerName);
        username = findViewById(R.id.registerUsername);
        email = findViewById(R.id.registerEmail);
        password = findViewById(R.id.registerPassword);
        cardInfo = findViewById(R.id.registerCardInfo);

        //TODO CHECK CREDIT CARD INFO

        if (TextUtils.isEmpty(email.getText()) || TextUtils.isEmpty(name.getText()) || TextUtils.isEmpty(username.getText()) || TextUtils.isEmpty(password.getText()) || TextUtils.isEmpty(cardInfo.getText())) {
            Toast.makeText(this, R.string.register_field_empty, Toast.LENGTH_SHORT).show();
            return;
        }

        if (!android.util.Patterns.EMAIL_ADDRESS.matcher(email.getText()).matches()) {
            Toast.makeText(this, R.string.invalid_email, Toast.LENGTH_SHORT).show();
            return;
        }

        KeyPair kp = null;
        try {
            kp = RSAKeys.genKeys(this);
        } catch (Exception e) {
            Toast.makeText(this, R.string.key_generator_error, Toast.LENGTH_SHORT).show();
        }


        presenter.register(name.getText().toString(), email.getText().toString(), username.getText().toString(), cardInfo.getText().toString(), password.getText().toString(), RSAKeys.KeyToString(kp.getPublic()));
    }

    @Override
    public void showError(@NonNull String errorMessage) {
        Toast.makeText(this, errorMessage, Toast.LENGTH_SHORT).show();
    }

    @Override
    public void successful(@NonNull User user, @NonNull String token, @NonNull String publicKey) {
        MainAuthActivity.setLocalLogin(true);
        SharedPreferences preferences;
        preferences = this.getSharedPreferences(Constants.PreferenceKeys.USER_INFORMATION_PREFERENCES, MODE_PRIVATE);
        preferences.edit().putString(Constants.PreferenceKeys.JWT, token).apply();
        preferences.edit().putString(Constants.PreferenceKeys.UUID, user.getUuid()).apply();
        preferences.edit().putString(Constants.PreferenceKeys.SUPERMARKET_PUBLIC_KEY, publicKey).apply();
        Intent intent = new Intent(this, MainMenuActivity.class);
        startActivity(intent);
    }
}
