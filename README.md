# simple_wifi_info

## Description
This package is used to get the ssid and bssid of the wifi that the device is connected to.

## Usage
```dart
import 'package:simple_wifi_info/wifi_info.dart';

Future<void> getWifiInfo() async {
    WifiInfoModel? wifiInfo;
    try {
      final _wifiInfoPlugin = WifiInfo();
      wifiInfo = await _wifiInfoPlugin.getWifiInfo();
    } on PlatformException {
      wifiInfo = null;
    }
  }
```

## Installation

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  simple_wifi_info: ^1.0.0
```

- For Android, add the following permissions to your AndroidManifest.xml file:
```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

- For iOS, add the following permissions to your Info.plist file:
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Used to get the SSID of the connected wifi</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Used to get the SSID of the connected wifi</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>Used to get the SSID of the connected wifi</string>
```

You must enable Wifi-Entitlement by going to Target->Signing & Capabilities and adding Access WiFi Information or adding <key>com.apple.developer.networking.wifi-info</key> <true/> directly to your entitlements file

Note: Package only works on physical devices


