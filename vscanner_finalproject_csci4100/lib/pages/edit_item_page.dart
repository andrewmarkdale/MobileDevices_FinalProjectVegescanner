import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/model/db_helper.dart';
import 'dart:convert';
import 'package:vscanner_finalproject_csci4100/model/bottom_app_bar.dart';
import 'package:vscanner_finalproject_csci4100/pages/item_page.dart';

import 'list_products_page.dart';

class edititempage extends StatefulWidget {
  const edititempage(
      {Key? key,
      required this.title,
      required this.image1,
      required this.image2,
      required this.mapImage,
      required this.barcode,
      required this.notes})
      : super(key: key);
  final String title;
  final String image1;
  final String image2;
  final String barcode;
  final String mapImage;
  final String notes;
  @override
  State<StatefulWidget> createState() => _edititempagestate();
}

class _edititempagestate extends State<edititempage> {
  TextEditingController notes = TextEditingController();

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
                Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.circular(10)),
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: IconButton(
                            onPressed: () async {
                              _showAlertDialog(context);
                            },
                            icon: const Icon(
                              FontAwesomeIcons.trashAlt,
                              color: Colors.white,
                            )),
                        alignment: Alignment.center,
                      ),
                    )),
                Padding(
                    child: Text(
                      widget.title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    padding: EdgeInsets.only(left: 5)),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Padding(
                  child: Text(
                    'Barcode: ${widget.barcode}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  padding: EdgeInsets.only(left: 10),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 20)),
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
                      maxLines: 10,
                      controller: notes,
                      decoration: const InputDecoration(
                        hintMaxLines: 15,
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
                              int result =
                                  await DBHelper.dbHelper.updateProduct({
                                "name": widget.title,
                                "barcode": widget.barcode,
                                "vegan": widget.image1,
                                "vegetarian": widget.image2,
                                "imgb64": widget.mapImage,
                                "notes": notes.text,
                              });
                              print(result);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => itempage(
                                          title: widget.title,
                                          image1: widget.image1,
                                          image2: widget.image2,
                                          mapImage: widget.mapImage,
                                          barcode: widget.barcode,
                                          notes: notes.text)));
                            },
                            child: const Text(
                              "Save Notes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ))))
              ])),
        ));
  }

  Future<void> _showAlertDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Image.asset('images/deletebarcode.png',
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width * 0.75),
            content: const Text(
              "Delete product?\nThis cannot be undone.",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                  )),
              TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                  ),
                  onPressed: () {
                    DBHelper.dbHelper.deleteProduct(widget.barcode);
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => productbuild(),
                        ));
                  },
                  child: const Text("Delete",
                      style: TextStyle(color: Colors.white))),
            ],
          );
        });
  }
}
