package by.chemerisuk.cordova.firebase;

import android.content.Context;
import android.os.Bundle;
import android.util.Log;

import com.google.firebase.analytics.FirebaseAnalytics;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Iterator;


public class FirebaseAnalyticsPlugin extends CordovaPlugin {
    private static final String TAG = "FirebaseAnalyticsPlugin";

    private FirebaseAnalytics firebaseAnalytics;

    @Override
    protected void pluginInitialize() {
        Log.d(TAG, "Starting Firebase Analytics plugin");

        Context context = this.cordova.getActivity().getApplicationContext();

        this.firebaseAnalytics = FirebaseAnalytics.getInstance(context);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("logEvent".equals(action)) {
            logEvent(callbackContext, args.getString(0), args.getJSONObject(1));

            return true;
        } else if ("setUserId".equals(action)) {
            setUserId(callbackContext, args.getString(0));

            return true;
        } else if ("setUserProperty".equals(action)) {
            setUserProperty(callbackContext, args.getString(0), args.getString(1));

            return true;
        } else if ("setEnabled".equals(action)) {
            setEnabled(callbackContext, args.getBoolean(0));

            return true;
        } else if ("setCurrentScreen".equals(action)) {
            setCurrentScreen(callbackContext, args.getString(0));

            return true;
        }

        return false;
    }

    private void logEvent(CallbackContext callbackContext, String name, JSONObject params) throws JSONException {
        Bundle bundle = new Bundle();
        if(name.equals("signup")) {
           // bundle.putString(FirebaseAnalytics.Param.METHOD, params.get("method").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.SIGN_UP, bundle);
        } else if(name.equals("tutorialbegin")) {
            //bundle.putString(FirebaseAnalytics.Param.METHOD, params.get("method").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.TUTORIAL_BEGIN, bundle);
        } else if(name.equals("tutorialcomplete")) {
            //bundle.putString(FirebaseAnalytics.Param.METHOD, params.get("method").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.TUTORIAL_COMPLETE, bundle);
        }  else if(name.equals("login")) {
            //bundle.putString(FirebaseAnalytics.Param.METHOD, params.get("method").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.LOGIN, bundle);
        } else if(name.equals("addtowishlist")) {
            Object quantity = params.get("quantity");
            bundle.putString(FirebaseAnalytics.Param.ITEM_CATEGORY, params.get("item_category").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, params.get("item_name").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_LOCATION_ID, params.get("item_location_id").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_ID, params.get("item_id").toString());
            bundle.putLong(FirebaseAnalytics.Param.QUANTITY, ((Number) quantity).longValue());
            
            //bundle.putFloat(FirebaseAnalytics.Param.QUANTITY, ((Number) quantity).floatValue());
            //bundle.putLong(FirebaseAnalytics.Param.QUANTITY, 1);
            
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.ADD_TO_WISHLIST, bundle);
        } else if(name.equals("addtocart")) {
            bundle.putString(FirebaseAnalytics.Param.ITEM_CATEGORY, params.get("item_category").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, params.get("item_name").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_LOCATION_ID, params.get("item_location_id").toString());
            bundle.putString(FirebaseAnalytics.Param.CURRENCY, params.get("currency").toString());
            bundle.putDouble(FirebaseAnalytics.Param.VALUE, ((Number) params.get("value")).doubleValue());
            bundle.putString(FirebaseAnalytics.Param.COUPON, params.get("coupon").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_ID, params.get("item_id").toString());
            bundle.putLong(FirebaseAnalytics.Param.QUANTITY, ((Number) params.get("quantity")).longValue());
            
            //bundle.putFloat(FirebaseAnalytics.Param.QUANTITY, ((Number) params.get("quantity")).floatValue());
            
            //bundle.putLong(FirebaseAnalytics.Param.QUANTITY, 1);
     
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.ADD_TO_CART, bundle);
        }  else if(name.equals("ecommercepurchase")) {
            bundle.putString(FirebaseAnalytics.Param.COUPON, params.get("coupon").toString());
            bundle.putString(FirebaseAnalytics.Param.CURRENCY, params.get("currency").toString());
            bundle.putDouble(FirebaseAnalytics.Param.VALUE,((Number) params.get("value")).doubleValue());
            bundle.putString(FirebaseAnalytics.Param.TRANSACTION_ID, params.get("transaction_id").toString());
            bundle.putString(FirebaseAnalytics.Param.LOCATION, params.get("location").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, params.get("item_name").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.ECOMMERCE_PURCHASE, bundle);
        } else if(name.equals("viewitem")) {
            bundle.putString(FirebaseAnalytics.Param.ORIGIN, params.get("origin").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_ID, params.get("item_id").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, params.get("item_name").toString());
            bundle.putString(FirebaseAnalytics.Param.ITEM_CATEGORY, params.get("item_category").toString());
            bundle.putString(FirebaseAnalytics.Param.SEARCH_TERM, params.get("search_term").toString());
            this.firebaseAnalytics.logEvent(FirebaseAnalytics.Event.VIEW_ITEM, bundle);
        } else {
            
            Iterator iter = params.keys();

            while (iter.hasNext()) {
                String key = (String) iter.next();
                Object value = params.get(key);

                if (value instanceof Integer || value instanceof Double) {
                    bundle.putFloat(key, ((Number) value).floatValue());
                } else {
                    bundle.putString(key, value.toString());
                }
            }

            this.firebaseAnalytics.logEvent(name, bundle); 
        }
     
        callbackContext.success();
    }

    private void setUserId(CallbackContext callbackContext, String userId) {
        this.firebaseAnalytics.setUserId(userId);

        callbackContext.success();
    }

    private void setUserProperty(CallbackContext callbackContext, String name, String value) {
        this.firebaseAnalytics.setUserProperty(name, value);

        callbackContext.success();
    }

    private void setEnabled(CallbackContext callbackContext, boolean enabled) {
        this.firebaseAnalytics.setAnalyticsCollectionEnabled(enabled);

        callbackContext.success();
    }

    private void setCurrentScreen(final CallbackContext callbackContext, final String screenName) {
        cordova.getActivity().runOnUiThread(new Runnable() {
            public void run() {
                firebaseAnalytics.setCurrentScreen(
                    cordova.getActivity(),
                    screenName,
                    null
                );

                callbackContext.success();
            }
        });
    }
}
