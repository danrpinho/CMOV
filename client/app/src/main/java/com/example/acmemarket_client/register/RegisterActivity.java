package com.example.acmemarket_client.register;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.example.acmemarket_client.R;
import com.example.acmemarket_client.login.LoginActivity;

import java.util.UUID;

public class RegisterActivity extends AppCompatActivity {

    private EditText name, username, email, password, cardInfo;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

    }

    @Override
    protected void onStart() {
        super.onStart();

    }

    public void onLoginClick(View view) {
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
        if(TextUtils.isEmpty(email.getText()) || !android.util.Patterns.EMAIL_ADDRESS.matcher(email.getText()).matches()) {
            Toast.makeText(this, R.string.invalid_email, Toast.LENGTH_SHORT).show();
            return;
        }

        UUID userUUID = UUID.randomUUID();

        //GERAR CHAVES

        //Chama cenas





    }
}
