import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:wifi_info/wifi_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  WifiInfoModel? _wifiInfo;
  final _wifiInfoPlugin = WifiInfo();

  @override
  void initState() {
    super.initState();
    getWifiInfo();
  }

  Future<void> getWifiInfo() async {
    WifiInfoModel? wifiInfo;
    try {
      wifiInfo = await _wifiInfoPlugin.getWifiInfo();
    } on PlatformException {
      wifiInfo = null;
    }

    if (!mounted) return;

    setState(() {
      _wifiInfo = wifiInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WifiInfo example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SSID: ${_wifiInfo?.ssid ?? '-'}\n'),
              Text('BSSID: ${_wifiInfo?.bssid ?? '-'}\n'),
            ],
          ),
        ),
      ),
    );
  }
}
