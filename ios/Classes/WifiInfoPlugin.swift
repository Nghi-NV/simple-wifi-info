import Flutter
import UIKit
import SystemConfiguration.CaptiveNetwork
import CoreLocation


public class WifiInfoPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "wifi_info", binaryMessenger: registrar.messenger())
        let instance = WifiInfoPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getWifiInfo" :
            let ssid = getSSID()
            let bssid = getBSSID()
            result(["ssid": ssid, "bssid": bssid])
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func checkPermission() -> Bool {
      // if permission is not determined, ask for permission
        let status = CLLocationManager.authorizationStatus()
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            return true
        }

        // request permission
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        return false
    }
    
    func getSSID() -> String? {
            guard let interface = (CNCopySupportedInterfaces() as? [String])?.first,
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                let ssid = unsafeInterfaceData["SSID"] as? String else{
                    return nil
            }
            return ssid
        }
    
    // get BSSID
    func getBSSID() -> String? {
            guard let interface = (CNCopySupportedInterfaces() as? [String])?.first,
                let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any],
                let bssid = unsafeInterfaceData["BSSID"] as? String else{
                    return nil
            }
            return bssid
        }
    
}
