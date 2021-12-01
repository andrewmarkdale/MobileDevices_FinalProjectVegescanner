import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:geolocator/geolocator.dart';
import 'listproducts.dart';

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
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'VScanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
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
  bool searchSwitch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: searchSwitch ? 0.0 : 4.0,
          title: Image.asset(
            'images/vegescannerlong.png',
            fit: BoxFit.contain,
            height: 32,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(
                    () {
                      searchSwitch ? searchSwitch = false : searchSwitch = true;
                    },
                  );
                },
                child: searchSwitch
                    ? const Icon(FontAwesomeIcons.times)
                    : const Icon(FontAwesomeIcons.search),
              ),
            )
          ],
        ),
        body: productbuild(
          isSearching: searchSwitch,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 70,
            width: 70,
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
          shape: const CircularNotchedRectangle(),
          color: Colors.green[500],
          child: Container(
            height: MediaQuery.of(context).size.height / 12,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: () async {
                      Position position = await _determinePosition();
                      lat = position.latitude.toString();
                      print(lat);
                      long = position.longitude.toString();
                      print(long);
                      setState(() {});
                    },
                    icon: const Icon(FontAwesomeIcons.listUl,
                        color: Colors.white)),
                const IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                IconButton(
                  onPressed: () {
                    print("hello!");
                  },
                  icon: const Icon(FontAwesomeIcons.info, color: Colors.white),
                )
              ],
            ),
          ),
        ));
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
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
}
