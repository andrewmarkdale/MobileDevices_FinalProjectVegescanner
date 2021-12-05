import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/db_helper.dart';
import 'dart:convert';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';

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
            const Padding(padding: EdgeInsets.only(top: 10)),
            Center(
                child: Text(
              widget.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Center(
              child: Text(
                'Barcode: ${widget.barcode}',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  widget.image1,
                  width: 50,
                  height: 50,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .1),
                Image.asset(
                  widget.image2,
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
            const Padding(padding: EdgeInsets.only(top: 10)),
            Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Save Item",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ))))
          ])),
    );
  }
}
