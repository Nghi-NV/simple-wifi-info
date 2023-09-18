import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'wifi_info_method_channel.dart';

class WifiInfoModel {
  final String? ssid;
  final String? bssid;

  WifiInfoModel({this.ssid, this.bssid});

  @override
  String toString() {
    return 'WifiInfo{ssid: $ssid, bssid: $bssid}';
  }
}

abstract class WifiInfoPlatform extends PlatformInterface {
  /// Constructs a WifiInfoPlatform.
  WifiInfoPlatform() : super(token: _token);

  static final Object _token = Object();

  static WifiInfoPlatform _instance = MethodChannelWifiInfo();

  /// The default instance of [WifiInfoPlatform] to use.
  ///
  /// Defaults to [MethodChannelWifiInfo].
  static WifiInfoPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WifiInfoPlatform] when
  /// they register themselves.
  static set instance(WifiInfoPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<WifiInfoModel?> getWifiInfo() {
    throw UnimplementedError('getWifiInfo() has not been implemented.');
  }
}
