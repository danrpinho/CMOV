package com.example.acmemarket_client.register;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import com.example.acmemarket_client.R;
import com.example.acmemarket_client.login.LoginActivity;

public class RegisterActivity extends AppCompatActivity {

    Button submit;
    private EditText name, username, email, password;
    TextView loginLink;

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
}
