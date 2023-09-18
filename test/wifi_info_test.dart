import 'package:flutter_test/flutter_test.dart';
import 'package:wifi_info/wifi_info.dart';
import 'package:wifi_info/wifi_info_platform_interface.dart';
import 'package:wifi_info/wifi_info_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWifiInfoPlatform
    with MockPlatformInterfaceMixin
    implements WifiInfoPlatform {
  @override
  Future<WifiInfoModel?> getWifiInfo() => Future.value(
        WifiInfoModel(
          ssid: 'ssid',
          bssid: 'bssid',
        ),
      );
}

void main() {
  final WifiInfoPlatform initialPlatform = WifiInfoPlatform.instance;

  test('$MethodChannelWifiInfo is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWifiInfo>());
  });

  test('getWifiInfo', () async {
    WifiInfo wifiInfoPlugin = WifiInfo();
    MockWifiInfoPlatform fakePlatform = MockWifiInfoPlatform();
    WifiInfoPlatform.instance = fakePlatform;

    expect(await wifiInfoPlugin.getWifiInfo(), isInstanceOf<WifiInfoModel>());
  });
}
