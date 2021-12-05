// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/db_helper.dart';
import 'dart:convert';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';

class itempage extends StatefulWidget {
  const itempage(
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
  State<StatefulWidget> createState() => _itempagestate();
}

class _itempagestate extends State<itempage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
            Center(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: widget.mapImage == ""
                  ? Image.asset('images/no_image.jpg',
                      width: MediaQuery.of(context).size.width * .75,
                      height: MediaQuery.of(context).size.height * .25,
                      fit: BoxFit.fill)
                  : Image.memory(
                      base64Decode(widget.mapImage),
                      width: MediaQuery.of(context).size.width * .75,
                      height: MediaQuery.of(context).size.height * .25,
                      fit: BoxFit.fill,
                    ),
            )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  widget.image1,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: 50, height: 90),
                Image.asset(
                  widget.image2,
                  width: 50,
                  height: 50,
                ),
                //SizedBox(height: 100,),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Barcode: ${widget.barcode}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    const Text(
                      "Notes",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                child: Card(
                  elevation: 6,
                  child: ClipPath(
                    child: Container(
                      child: Text("Enter your notes..."),
                      height: 140,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                    ),
                    clipper: ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3))),
                  ),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      // Map<String, dynamic> row = {};
                      // DBHelper.dbHelper.updateProduct(row);
                    },
                    icon: Icon(FontAwesomeIcons.edit)),
                IconButton(
                    onPressed: () async {
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Delete Product?"),
                              content: Text("This action cannot be undone"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      DBHelper.dbHelper
                                          .deleteProduct(widget.barcode);
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text("Delete")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel"))
                              ],
                            );
                          });
                    },
                    icon: Icon(FontAwesomeIcons.trashAlt))
              ],
            ),
          ])),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete product?"),
            content: Text("Delete?"),
            actions: [
              TextButton(onPressed: () {}, child: Text("Yes")),
              TextButton(onPressed: () {}, child: Text("No"))
            ],
          );
        });
  }
}
