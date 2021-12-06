import 'package:flutter/material.dart';
import 'package:vscanner_finalproject_csci4100/model/product.dart';
import 'package:vscanner_finalproject_csci4100/pages/item_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/model/db_helper.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:vscanner_finalproject_csci4100/model/vege_check_functions.dart';
import 'dart:convert';
import '../model/local_notifcation.dart';
import '../model/bottom_app_bar.dart';

class productbuild extends StatefulWidget {
  const productbuild({
    Key? key,
  }) : super(key: key);

  @override
  _productbuildstate createState() => _productbuildstate();
}

class _productbuildstate extends State<productbuild> {
  _productbuildstate({Key? key});

  @override
  void initState() {
    super.initState();
    setState(() {});
    getAllProducts();
  }
//a list to store products
  List<Product> products = [];
  List<Product> productCopy = [];
  TextEditingController searchController = TextEditingController();
  bool searchSwitch = false;
  @override
  Widget build(BuildContext context) {
    //clear input in search 
    if (searchSwitch == false) {
      setState(() {
        products.clear();
        products.addAll(productCopy);
        searchController.text = "";
      });
    }
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: searchSwitch ? false : true,
        title: searchSwitch
            ? TextField(
              //decorate input for the search bar at the top
                decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(),
                        borderRadius: BorderRadius.circular(10)),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.search,
                      size: 20,
                    ),
                    hintText: "Search",
                    contentPadding: const EdgeInsets.only(left: 10)),
                onChanged: (value) {
                  print(products);
                  filterSearchResults(value);
                },
                controller: searchController,
              )// include image besides search icon
            : Image.asset(
                'images/vegescannerlong.png',
                fit: BoxFit.contain,
                height: 32,
              ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            //see if search switch is tapped and rebuild widget 
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            //create a list view builder for products
            child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 7),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  //have the list tiles inside a container that have grey shadows and circular edges 
                  return Container(
                    width: 100,
                    height: 90,
                    
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(1, 3))
                        ]),
                    margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 10),
                      minVerticalPadding: 10,
                      leading: ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 90,
                            minWidth: 80,
                            maxHeight: 90,
                            maxWidth: 80,
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: products[index].imgB64 == null
                                  ? Image.asset(
                                      'images/no_image.jpg',
                                      fit: BoxFit.fill,
                                    )
                                  : Image.memory(
                                    //fetch the maps
                                      base64Decode(products[index].imgB64),
                                      fit: BoxFit.fill))),
                      //display text on list tiles and include some properties to stop text overflow
                      title: Text(
                        products[index].productName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        softWrap: true,
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //get the appropriate icons for vegan/vegetarian products
                          Image.asset(
                            veganCheck(products[index]),
                            width: 30,
                            height: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            vegetarianCheck(products[index]),
                            width: 30,
                            height: 50,
                          ),
                        ],
                      ),
                      onTap: () {
                        //pass product info to the item page
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => itempage(
                                      title: products[index].productName,
                                      image1: veganCheck(products[index]),
                                      image2: vegetarianCheck(products[index]),
                                      mapImage: products[index].imgB64 ?? "",
                                      barcode: products[index].barcode,
                                      notes: products[index].notes ?? "",
                                    )));
                      },
                    ),
                  );
                }),
          )
        ],
      ),
      bottomNavigationBar: const BottomAppBarWidget(),
    );
  }

  // Using internet documentation we were able to determine how to search
//filtering search results for the products
  void filterSearchResults(String query) {
    List<Product> searchList = <Product>[];
    List<Product> copyItems = products;
    searchList.addAll(products);
    if (query.isNotEmpty) {
      List<Product> dummyListItems = <Product>[];
      searchList.forEach((item) {
        if (item.productName.toLowerCase().contains(query.toLowerCase())) {
          dummyListItems.add(item);
        }
      });
      setState(() {
        products.clear();
        products.addAll(dummyListItems);
      });
      return;
    } else {
      setState(() {
        products.clear();
        products.addAll(productCopy);
      });
    }
  }
//get all the necessary product information from the database such as barcode,name and their logos
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
