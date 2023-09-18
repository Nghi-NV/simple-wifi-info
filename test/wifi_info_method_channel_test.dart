import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_wifi_info/wifi_info_method_channel.dart';
import 'package:simple_wifi_info/wifi_info_platform_interface.dart';

void main() {
  MethodChannelWifiInfo platform = MethodChannelWifiInfo();
  const MethodChannel channel = MethodChannel('wifi_info');

  TestWidgetsFlutterBinding.ensureInitialized();

  final wifiInfo = {
    'ssid': 'ssid',
    'bssid': 'bssid',
  };

  final wifiInfoModel = WifiInfoModel(
    ssid: wifiInfo['ssid'],
    bssid: wifiInfo['bssid'],
  );

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return wifiInfo;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getWifiInfo(), wifiInfoModel);
  });
}
