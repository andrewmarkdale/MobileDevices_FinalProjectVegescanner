import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';
import 'listproducts.dart';
import 'bottomappbar.dart';

class infopage extends StatelessWidget {
  const infopage({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Information page"),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text("Information",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset('images/vegan_icon_true.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The green vegan icon indicates that the food item contains no animal product ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('images/vegetarian_icon_true.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The green vegetarian icon indicates that the food adheres to a vegetarians dietary standards ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('images/vegan_icon_maybe.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The red vegan icon indicates that the food item may contain animal products -- certain food additives may or may not be vegan. Proceed with caution ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('images/vegetarian_icon_maybe.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The red vegatarian icon indicates that the food item may contain animal products -- certain food additives may or may not be vegatarian. Proceed with caution ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('images/vegan_icon_false.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The grey vegan icon indicates that the food item contains animal products and therefore not suitable for vegans ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('images/vegetarian_icon_false.png',
                            width: MediaQuery.of(context).size.width / 9,
                            height: MediaQuery.of(context).size.height / 9),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 25,
                        ),
                        const Flexible(
                            child: Text(
                          "The grey vegatarian icon indicates that the food item contains animal products and therefore not suitable for vegetarians ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14),
                        ))
                      ],
                    ),
                  ]))
            ])),
        bottomNavigationBar: BottomAppBarWidget());
  }
}
