package com.gameparkstudio.wkcocos.lib;

import android.os.Handler;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.igaworks.IgawCommon;
import com.igaworks.displayad.IgawDisplayAd;
import com.igaworks.displayad.common.DAErrorCode;
import com.igaworks.displayad.interfaces.IBannerEventCallbackListener;
import com.igaworks.displayad.view.BannerContainerView;

/**
 * Manage Advertisement library
 */
public class WkAd implements IBannerEventCallbackListener {

    private MainActivity mainActivity;
    private final String BANNER_ID_2 = "fa910d896f";
    private String bannerKey;

    private android.widget.LinearLayout adLayout;
    private BannerContainerView bannerView;
    // Need handler for callbacks to the UI thread
    final Handler mHandler = new Handler();

    // Create runnable for posting
    final Runnable adBannerShow = new Runnable() {
        public void run() {
            adLayout.setVisibility(View.VISIBLE);
            adLayout.requestLayout();
        }
    };
    final Runnable adBannerHide = new Runnable() {
        public void run() {
            adLayout.setVisibility(View.INVISIBLE);
            adLayout.requestLayout();
        }
    };

    public WkAd(MainActivity activity)
    {
        mainActivity = activity;
        bannerKey = BANNER_ID_2;

        adLayout = new android.widget.LinearLayout(mainActivity);
        //adLayout.setOrientation(LinearLayout.VERTICAL);
        adLayout.setLayoutParams(new android.widget.LinearLayout.LayoutParams(android.widget.LinearLayout.LayoutParams.MATCH_PARENT, android.widget.LinearLayout.LayoutParams.MATCH_PARENT));


        bannerView = new BannerContainerView(mainActivity);
        adLayout.addView(bannerView);
        TextView title = new TextView(mainActivity);
        title.setText("test text");
        adLayout.addView(title);
        adLayout.setVisibility(View.INVISIBLE);

        // Ad init
        IgawCommon.startApplication(mainActivity);
        IgawDisplayAd.init(mainActivity);
        IgawDisplayAd.setBannerEventCallbackListener(mainActivity, bannerKey, this);
    }

    public View getUI()
    {
        return adLayout;
    }

    public void pause(){
        IgawCommon.endSession();
        IgawDisplayAd.pauseBannerAd(mainActivity, bannerKey);

    }

    public void resume(){
        IgawCommon.startSession(mainActivity);
        IgawDisplayAd.startBannerAd(mainActivity, bannerKey, bannerView);

    }

    @Override
    public void OnBannerAdReceiveSuccess() {
        // TODO Auto-generated method stub
        Toast.makeText(mainActivity, "OnBannerAdReceiveSuccess", Toast.LENGTH_SHORT).show();
    }

    @Override
    public void OnBannerAdReceiveFailed(DAErrorCode errorCode) {
        // TODO Auto-generated method stub
        Toast.makeText(mainActivity, "OnBannerAdReceiveFailed: " + errorCode.getErrorMessage(), Toast.LENGTH_SHORT).show();
    }

    public void showAdBanner(int x, int y) {
        adLayout.layout(
                x - adLayout.getWidth() / 2,
                y - adLayout.getHeight() / 2,
                x + adLayout.getWidth() / 2,
                y + adLayout.getHeight() / 2
        );
        mHandler.post(adBannerShow);
    }

    public void hideAdBanner() {
        mHandler.post(adBannerHide);
    }

}