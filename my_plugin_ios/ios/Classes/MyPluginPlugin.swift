
import Flutter
import UIKit
import CoreLocation

public class MyPluginPlugin: NSObject, FlutterPlugin, GeolocationDelegate {



    func onLocationUpdate(coords: CLLocationCoordinate2D) {
        self.channel?.invokeMethod("onLocation", arguments: ["lat":coords.latitude,"lng":coords.longitude])

    }

    let geolocation = Geolocation()
     var channel:FlutterMethodChannel?


    public init(channel:FlutterMethodChannel) {
        super.init()
        self.channel = channel
        self.geolocation.delegate = self
    }

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "my_plugin", binaryMessenger: registrar.messenger())
    let instance = MyPluginPlugin(channel: channel)
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {


    switch call.method{

             case "startLocation":
                 self.geolocation.startTracking()
                 result(nil)

                 case "stopLocation":
                 self.geolocation.stopTracking()
                 result(nil)



             default: result(FlutterMethodNotImplemented)

             }


  }
}
