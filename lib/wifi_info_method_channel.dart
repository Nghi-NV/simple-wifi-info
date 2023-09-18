import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'wifi_info_platform_interface.dart';

class MethodChannelWifiInfo extends WifiInfoPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('wifi_info');

  @override
  Future<WifiInfoModel?> getWifiInfo() async {
    final result = await methodChannel.invokeMethod('getWifiInfo');
    if (result == null) {
      return null;
    }

    return WifiInfoModel(
      ssid: result['ssid'],
      bssid: result['bssid'],
    );
  }
}
