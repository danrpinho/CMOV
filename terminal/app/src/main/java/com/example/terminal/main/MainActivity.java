package com.example.terminal.main;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;

import com.example.terminal.utils.Constants;
import com.example.terminal.R;

public class MainActivity extends AppCompatActivity implements MainView {
    MainPresenter presenter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    @Override
    public void onStart() {
        super.onStart();
        presenter = new MainPresenter(this, new MainInteractor());
    }

    public void onScanButtonClick(View view) {

        try {
            Intent intent = new Intent(Constants.QRCodes.ACTION_SCAN);
            intent.putExtra(Constants.QRCodes.INTENT_SCAN_MODE, Constants.QRCodes.INTENT_QR_CODE_MODE);
            startActivityForResult(intent, 0);
        } catch (ActivityNotFoundException anfe) {
            showDialog(this, getString(R.string.no_scanner), getString(R.string.download_scanner), getString(R.string.button_yes), getString(R.string.button_no)).show();
        }

    }

    private static AlertDialog showDialog(final Activity act, CharSequence title, CharSequence message, CharSequence buttonYes, CharSequence buttonDismiss) {
        AlertDialog.Builder downloadDialog = new AlertDialog.Builder(act);
        downloadDialog.setTitle(title);
        downloadDialog.setMessage(message);
        if (buttonYes != null) {
            downloadDialog.setPositiveButton(buttonYes, (d, i) -> {
                Uri uri = Uri.parse(Constants.QRCodes.URI_QRCODE_SCANNER);
                Intent intent = new Intent(Intent.ACTION_VIEW, uri);
                act.startActivity(intent);
            });
        }
        downloadDialog.setNegativeButton(buttonDismiss, null);
        return downloadDialog.show();
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 0 && resultCode == RESULT_OK) {
            String contents = data.getStringExtra(Constants.QRCodes.SCAN_RESULT);
            presenter.checkout(contents);
            return;
        }
    }


    @Override
    public void showMessage(String message) {
        showDialog(this, "", message, null, getString(R.string.button_ok));
    }
}
