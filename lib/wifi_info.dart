import 'wifi_info_platform_interface.dart';
export 'wifi_info_platform_interface.dart' show WifiInfoModel;

class WifiInfo {
  Future<WifiInfoModel?> getWifiInfo() {
    return WifiInfoPlatform.instance.getWifiInfo();
  }
}
