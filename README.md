
# Platform Channels Example


[![CI](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/actions/workflows/main.yml)

This example shows the implementation of a Platform Channels, where the changes emitted by the GPS of the device are listened to.


### Documentation

* [Writing custom platform-specific code](https://docs.flutter.dev/platform-integration/platform-channels)




### Send data from client (Flutter) to host

Only the data types specified in the documentation can be sent. These are:
null, bool, int, double, String, Float, List, Map

```dart

await _methodChannel.invokeMethod(
          "version",
          {
          "product":"Apple pie",
          "amount":2,
          "price":3.5,
          "currency":"USD"
          }
      );

```

### Receiving data on host ( iOS / Swift)

```swift

let data : [String:Any] = call.arguments as! [String:Any]
let product : String = data["product"]

```

### Receiving data on host ( Android / Java)

```java

HashMap<String,Object> data = (HashMap<String,Object>) call.arguments;
String product = (String) data.get("product");

```
### To subscribe to the changes emitted by the device's GPS, the EventChannel was used.

```dart

final _eventChannel = const EventChannel("geolocation.listener");
_eventChannel.receiveBroadcastStream().listen((event) {
        
        });

```

## Presentation


https://github.com/eliomacrosales/Simple-Platform-Channels-Example/assets/58376042/52e64a23-cf82-407d-aa24-e50e4f053841

https://github.com/eliomacrosales/Simple-Platform-Channels-Example/assets/58376042/879489bd-abf7-4b22-8b81-93ef6e31d207

### Built With

To communicate the client (Flutter) with the hosts (Android/iOS), Java was used for Android and Swift was used for iOS.

* [![Flutter][Flutter.image]][Flutter-url]
* [![Java][Java.image]][Java-url]
* [![Swift][Swift.image]][Swift-url]





[Flutter.image]: https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white
[Flutter-url]: https://docs.flutter.dev/platform-integration/platform-channels
[Java.image]: https://img.shields.io/badge/Java-ffca28?style=for-the-badge&logo=openjdk&logoColor=white
[Java-url]: https://www.java.com/en/
[Swift.image]: https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white
[Swift-url]: https://www.swift.org/documentation/















