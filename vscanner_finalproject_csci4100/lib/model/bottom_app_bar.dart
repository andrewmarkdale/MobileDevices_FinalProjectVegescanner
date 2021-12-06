import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vscanner_finalproject_csci4100/main.dart';
import 'package:vscanner_finalproject_csci4100/pages/new_item_page.dart';
import '../pages/information_page.dart';
import '../pages/list_products_page.dart';
import 'local_notifcation.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'db_helper.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class BottomAppBarWidget extends StatefulWidget {
  const BottomAppBarWidget({Key? key}) : super(key: key);
  @override
  _BottomAppBarWidgetState createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              productbuild(key: UniqueKey())));
                },
                icon: const Icon(FontAwesomeIcons.listUl, color: Colors.white)),
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    padding: EdgeInsets.only(bottom: 3),
                    width: 70,
                    color: Colors.grey[700],
                    child: IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.barcode,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () async {
                        var barcodeScanRes =
                            await FlutterBarcodeScanner.scanBarcode(
                                "#228B22", "Cancel", true, ScanMode.BARCODE);
                        if (barcodeScanRes == "-1") {
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        }
                        var product =
                            await getProductInformation(barcodeScanRes);

                        if (product == false) {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    backgroundColor: Colors.green,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    title: Image.asset(
                                      'images/barcode_not_found.png',
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                    ),
                                    content: const Text(
                                      "Barcode not found.\n\nIf it is a food item, please consider adding it to Open Food Facts.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK",
                                            style:
                                                TextStyle(color: Colors.green)),
                                      )
                                    ]);
                              });
                        }
                        if (product is Product) {
                          Position position = await _determinePosition();
                          final image = await staticmaptoBase64(
                              LatLng(position.latitude, position.longitude));

                          product.imgB64 = image;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => newitempage(
                                      title: product.productName,
                                      image1: product.vegan,
                                      image2: product.vegetarian,
                                      mapImage: product.imgB64 ?? "",
                                      barcode: product.barcode)));
                        }
                        if (product == "Error") {
                          return showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    backgroundColor: Colors.green,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    title: Image.asset(
                                      "images/error_barcode.png",
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                    ),
                                    content: const Text(
                                      "Error retrieving data. \nPlease try again later.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white)),
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("OK",
                                            style:
                                                TextStyle(color: Colors.green)),
                                      )
                                    ]);
                              });
                        }

                        setState(() {});
                      },
                    ))),
            IconButton(
              onPressed: () async {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const infopage()));
              },
              icon: const Icon(FontAwesomeIcons.info, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

// Geolocation/Geocoding based on online documentation and lecture code.
// Needed to error handle to ensure users could still use app.
Future<Position> _determinePosition() async {
  bool isServiceEnabled;
  LocationPermission permission;

  // Checking if location services are enabled
  isServiceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isServiceEnabled) {
    return Future.error('Location services are disabled.');
  }

  // If services are enabled, checking permission.
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  // If permission has been denied forever, return error.
  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // Getting position.
  return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best);
}

// Converting image data gathered from mapbox api to b64 and stored in the db
// which is then converted to an image when needed.
Future<String> staticmaptoBase64(LatLng coordinates) async {
  var lat = coordinates.latitude.toString();
  var long = coordinates.longitude.toString();
  final response = await http.get(Uri.parse(
      'https://api.mapbox.com/styles/v1/mapbox/streets-v11/static/pin-s+ff0000($long,$lat)/$long,$lat,14.51,0/300x200?access_token=pk.eyJ1IjoiYW5kcmV3bWFya2RhbGUiLCJhIjoiY2t3a3hmaDZwMXdtMTJ0bm8xZHhhNG1jNSJ9.JtUGdsqShlhU8hJ6gtEpbw'));
  final bytes = response.bodyBytes;
  return base64Encode(bytes);
}

// Getting the product information from the Open Food Data API.
// Uses scanned barcode.

Future<dynamic> getProductInformation(String barcode) async {
  try {
    var name;
    String veganStatus;
    String vegetarianStatus;
    Product food =
        Product(barcode: barcode, productName: "", vegan: "", vegetarian: "");

    List<String> productnameLangs = [
      'product_name',
      'product_name_en',
      'product_name_fr',
      'product_name_la'
    ];

    Uri uri =
        Uri.https('world.openfoodfacts.org', '/api/v0/product/[$barcode].json');

    Map<String, String> headers = {
      HttpHeaders.userAgentHeader: 'VegeScanner - Android - Version 1.0'
    };
    final response = await http.get(uri, headers: headers);
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == 0) {
      return false;
    }
    food.barcode = barcode;
    if (responseData['product'] != null) {
      if (responseData['product']['product_name'] != null) {
        for (String n in productnameLangs) {
          name = responseData['product'][n];
          if (name != "") {
            break;
          }
        }
        food.productName = name;
      }
      if (responseData['product']['ingredients_analysis_tags'] != null) {
        veganStatus = responseData['product']['ingredients_analysis_tags'][1];
        food.vegan = veganStatus.split(":")[1];
        vegetarianStatus =
            responseData['product']['ingredients_analysis_tags'][2];
        food.vegetarian = vegetarianStatus.split(":")[1];
      }
    }
    print(food.barcode);
    print(food.productName);
    print(food.vegan);
    print(food.vegetarian);

    return food;
  } catch (e) {
    return "Error";
  }
}
