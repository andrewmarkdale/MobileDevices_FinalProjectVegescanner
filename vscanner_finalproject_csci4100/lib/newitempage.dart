import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/db_helper.dart';
import 'dart:convert';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';
import 'package:vscanner_finalproject_csci4100/localnotifcation.dart';
import 'package:vscanner_finalproject_csci4100/main.dart';
import 'package:vscanner_finalproject_csci4100/product.dart';

import 'listproducts.dart';

class newitempage extends StatefulWidget {
  const newitempage(
      {Key? key,
      required this.title,
      required this.image1,
      required this.image2,
      required this.mapImage,
      required this.barcode})
      : super(key: key);
  final String title;
  final String image1;
  final String image2;
  final String barcode;
  final String mapImage;
  @override
  State<StatefulWidget> createState() => _newitempagestate();
}

class _newitempagestate extends State<newitempage> {
  TextEditingController notes = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {});
    getAllProducts();
  }

  List<Product> products = [];
  List<Product> productCopy = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                    child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                )),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                  child: Text(
                    'Barcode: ${widget.barcode}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      strVeganCheck(widget.image1),
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * .1),
                    Image.asset(
                      strVegetarianCheck(widget.image2),
                      width: 50,
                      height: 50,
                    ),
                    //SizedBox(height: 100,),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.mapImage == ""
                      ? Image.asset('images/no_image.jpg',
                          width: MediaQuery.of(context).size.width * .80,
                          height: MediaQuery.of(context).size.height * .25,
                          fit: BoxFit.fill)
                      : Image.memory(
                          base64Decode(widget.mapImage),
                          width: MediaQuery.of(context).size.width * .80,
                          height: MediaQuery.of(context).size.height * .25,
                          fit: BoxFit.fill,
                        ),
                )),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .1,
                        20,
                        MediaQuery.of(context).size.width * .1,
                        20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Notes",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .1,
                        1,
                        MediaQuery.of(context).size.width * .1,
                        1),
                    child: TextFormField(
                      maxLength: 100,
                      maxLines: 5,
                      controller: notes,
                      decoration: const InputDecoration(
                        hintMaxLines: 5,
                        hintText: "Enter your notes here",
                      ),
                    )),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Center(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextButton(
                            onPressed: () async {
                              print(notes.text);
                              for (var i in products) {
                                if (i.barcode == widget.barcode) {
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            backgroundColor: Colors.green,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            title: Image.asset(
                                              "images/duplicatebarcode.png",
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                            ),
                                            content: const Text(
                                              "Barcode already saved.\nPlease enter a new unique item.",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors.white)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyApp(),
                                                      ));
                                                },
                                                child: const Text("OK",
                                                    style: TextStyle(
                                                        color: Colors.green)),
                                              )
                                            ]);
                                      });
                                }
                              }
                              try {
                                int result =
                                    await DBHelper.dbHelper.insertProduct({
                                  "name": widget.title,
                                  "barcode": widget.barcode,
                                  "vegan": widget.image1,
                                  "vegetarian": widget.image2,
                                  "imgb64": widget.mapImage,
                                  "notes": notes.text,
                                });
                                SimpleNotification(context)
                                    .showNotification(true);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productbuild()));
                              } catch (e) {
                                SimpleNotification(context)
                                    .showNotification(false);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => productbuild()));
                              }
                            },
                            child: const Text(
                              "Save Item",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))))
              ])),
        ));
  }

  getAllProducts() async {
    List<Map<String, dynamic>> record =
        await DBHelper.dbHelper.getAllProducts();
    setState(() {
      record.forEach((element) {
        products.add(Product(
            barcode: element["barcode"],
            productName: element["name"],
            vegan: element["vegan"],
            vegetarian: element["vegetarian"],
            imgB64: element["imgb64"],
            notes: element["notes"]));
        productCopy.add(Product(
            barcode: element["barcode"],
            productName: element["name"],
            vegan: element["vegan"],
            vegetarian: element["vegetarian"],
            imgB64: element["imgb64"],
            notes: element["notes"]));
      });
    });
  }
}
