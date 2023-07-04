
# Platform Channels Example


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

## Accessibility
The use of accessibility for people with low vision is shown, through the use of the Semantics widget, which describes the behavior of a specific widget and the user can listen to this information by activating TalkBack on Android and VoiceOver on iOS

```dart

Semantics(
 label:'botón que inicia o detiene la escucha de la emisión de GPS del dispositivo',
 child: ElevatedButton(

```
The ExcludeSemantics widget was also used to hide widgets that would otherwise be read by readers and not need to be read.

```dart

AppBar(
 title: const ExcludeSemantics(child: Text('Platform Channel Example')),
      )

```

* [accessibility](https://esflutter.dev/docs/development/accessibility-and-localization/accessibility)



### CI/CD
[![CI](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/eliomacrosales/Simple-Platform-Channels-Example/actions/workflows/main.yml)

For the continuous integration of the tests, the Github Actions were used and especially the action subosito
* [subosito-action](https://github.com/subosito/flutter-action)
```dart

    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        channel: 'stable' # or: 'beta', 'dev' or 'master'
    - run: flutter pub get
    - run: flutter test

```


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















