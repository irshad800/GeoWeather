package com.example.newtokteck_task;

import android.os.Build;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public void onBackPressed() {
        // Handle back navigation
        super.onBackPressed(); // or perform other actions
        finish(); // Close the activity if needed
    }
}
