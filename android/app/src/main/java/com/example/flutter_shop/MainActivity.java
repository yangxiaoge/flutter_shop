package com.example.flutter_shop;

import android.os.Build;
import android.os.Bundle;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import moe.feng.alipay.zerosdk.AlipayZeroSdk;

public class MainActivity extends FlutterActivity {
    // 交互通道名字
    static final String CHANNEL = "com.bruce.flutter_shop/channel";
    // 支付宝
    static final String ALIPAY = "aliPay";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            //API>21, 设置状态栏颜色透明
            getWindow().setStatusBarColor(0);
        }

        // 注册通道
        new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    if (methodCall.method.equals(ALIPAY)) {
                        if (AlipayZeroSdk.hasInstalledAlipayClient(this)) {
                            AlipayZeroSdk.startAlipayClient(this, "tsx08459q7nhhh9pdxpbp9b");
                            result.success(true);
                        } else {
                            //Toast.makeText(this, "您没有安装支付宝！", Toast.LENGTH_SHORT).show();
                            result.success(false);
                        }
                    }
                });

        GeneratedPluginRegistrant.registerWith(this);
    }
}
