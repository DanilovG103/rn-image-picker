package com.learnnativemodules;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;

import java.net.URI;
import java.net.URISyntaxException;

public class MyAppModule extends ReactContextBaseJavaModule implements ActivityEventListener {
    private static final int IMAGE_PICK_REQUEST = 467081;
    private Promise reactPromise;

    MyAppModule(ReactApplicationContext context) {
        super(context);
        context.addActivityEventListener(this);
    }

    @Override
    public String getName() {
        return "MyAppModule";
    }

    @ReactMethod
    public void chooseFile(Promise promise) {
        reactPromise = promise;

        Activity currentActivity = getCurrentActivity();

        Intent intent = new Intent();
        intent.setType("image/*");
        intent.setAction(Intent.ACTION_PICK);

        Intent chooser = Intent.createChooser(intent, "Choose an image");

        try {
            currentActivity.startActivityForResult(chooser, IMAGE_PICK_REQUEST);
        } catch (Exception e) {
            promise.reject("Activity Result Error", e.toString());
            reactPromise = null;
        }
    }


    @Override
    public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent intent) {
        if (requestCode == IMAGE_PICK_REQUEST) {
            if (resultCode == Activity.RESULT_CANCELED) {
                reactPromise.reject("Error", "Picker cancelled");
            } else if (resultCode == Activity.RESULT_OK) {
                Uri dataUri = intent.getData();
                try {
                    URI uri = new URI(dataUri.toString());
                    reactPromise.resolve(uri.toString());
                } catch (URISyntaxException e) {
                    reactPromise.reject("Failed to parse to url", e.getMessage());
                }
            }
        }
    }

    @Override
    public void onNewIntent(Intent intent){}
}
