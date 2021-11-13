import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'VScanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var lat = '39.9205';
  var long = '-105.0867';
  makeUrl() {
    var url = 'https://www.mapquestapi.com/staticmap/v5/map?locations=' +
        lat +
        ',' +
        long +
        '&size=@2x&zoom=15&defaultMarker=marker&key=yoHht6ZFq4TOuqWZ9fbGmUWZcumb8DZ5';
    print(url);
    return url;
  }

  String barcodeScanRes = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Final Project"),
        ),
        body: Image.network(makeUrl()),

        /* floatingActionButton: FloatingActionButton(
          onPressed: () async {
            barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                "#ff0f0f", "Cancel", true, ScanMode.BARCODE);
            print(barcodeScanRes);
            setState(() {});
          },
          child: const Icon(
            FontAwesomeIcons.barcode,
            size: 30,
            color: Colors.white,
          )), */
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 75,
            width: 75,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[700],
              onPressed: () async {
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#228B22", "Cancel", true, ScanMode.BARCODE);
                print(barcodeScanRes);
                setState(() {});
              },
              child: const Icon(
                FontAwesomeIcons.barcode,
                size: 35,
              ),
              elevation: 5.0,
            )),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.green[700],
          child: Container(
            height: MediaQuery.of(context).size.height / 10,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: () async {
                      Position position = await Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high);
                      lat = position.latitude.toString();
                      print(lat);
                      long = position.longitude.toString();
                      print(long);
                      setState(() {});
                    },
                    icon: Icon(FontAwesomeIcons.listUl, color: Colors.white)),
                const IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                IconButton(
                  onPressed: () {
                    print("hello!");
                  },
                  icon: Icon(FontAwesomeIcons.info, color: Colors.white),
                )
              ],
            ),
          ),
        )

        /* SizedBox(
          height: MediaQuery.of(context).size.height / 10,
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            backgroundColor: Colors.green[700],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.listUl,
                    size: 20,
                    color: Colors.black,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  backgroundColor: Colors.grey,
                  icon: Icon(
                    FontAwesomeIcons.barcode,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.info,
                    size: 20,
                    color: Colors.black,
                  ),
                  label: "")
            ],
          )), */
        /* bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () {},
              child: const Icon(
                FontAwesomeIcons.listUl,
                size: 20,
                color: Colors.black,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                      primary: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  onPressed: () async {
                    barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                        "#ff0f0f", "Cancel", true, ScanMode.BARCODE);
                    print(barcodeScanRes);
                    setState(() {});
                  },
                  child: const Icon(
                    FontAwesomeIcons.barcode,
                    size: 30,
                    color: Colors.white,
                  ))),
          Align(
            alignment: Alignment.bottomRight,
            child: TextButton(
                onPressed: () {},
                child: const Icon(
                  FontAwesomeIcons.info,
                  size: 20,
                  color: Colors.black,
                )),
          )
        ],
      ),*/
        );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}
