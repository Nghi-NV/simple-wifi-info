package com.nghinv.wifiinfo

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.os.Build
import androidx.core.app.ActivityCompat.requestPermissions
import androidx.core.content.ContextCompat.checkSelfPermission
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding


class WifiInfoPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private val channelName = "wifi_info"
    private val requestCode = 1357

    private lateinit var channel: MethodChannel
    private var applicationContext: Context? = null
    private var activity: Activity? = null


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, channelName)
        applicationContext = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.activity = binding.activity;
    }

    override fun onDetachedFromActivityForConfigChanges() {
        this.activity = null;
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        this.activity = binding.activity;
    }

    override fun onDetachedFromActivity() {
        this.activity = null;
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getWifiInfo") {
            handlePermissions(applicationContext!!) {
                val wifiInfo = getWifiInfo()
                if (wifiInfo != null) {
                    val bssid = wifiInfo.bssid
                    var ssid: String?
                    if (bssid == null) {
                        ssid = null
                    } else {
                        ssid = wifiInfo.ssid

                        if (ssid == "<unknown ssid>") {
                            ssid = null
                        }

                        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
                            if (ssid != null && ssid.startsWith("\"") && ssid.endsWith("\"")) {
                                ssid = ssid.substring(1, ssid.length - 1)
                            }
                        }
                    }

                    val data = mapOf(
                        "ssid" to ssid,
                        "bssid" to bssid,
                        "rssi" to wifiInfo.rssi,
                    )
                    result.success(data)
                } else {
                    result.error("UNAVAILABLE", "WifiInfo is null", null)
                }
            }
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = null
        channel.setMethodCallHandler(null)
    }

    private fun getWifiInfo(): WifiInfo? {
        val wifiManager = applicationContext?.getSystemService(Context.WIFI_SERVICE) as WifiManager?

        return wifiManager?.connectionInfo
    }

    private fun handlePermissions(context: Context, callback: () -> Unit = {}) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (checkSelfPermission(
                    context, Manifest.permission.ACCESS_COARSE_LOCATION
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                activity?.let {
                    requestPermissions(
                        it,
                        arrayOf(Manifest.permission.ACCESS_COARSE_LOCATION),
                        requestCode
                    )
                }
            } else {
                callback()
            }
        } else {
            callback()
        }
    }
}
