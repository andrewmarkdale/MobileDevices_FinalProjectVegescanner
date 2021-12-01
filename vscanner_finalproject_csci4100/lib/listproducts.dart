import 'package:flutter/material.dart';
//import 'package:flutter_map/plugin_api.dart';
//import 'package:latlong2/latlong.dart';
//import 'package:quiver/collection.dart';
import 'package:vscanner_finalproject_csci4100/product.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class productbuild extends StatefulWidget {
  bool isSearching;

  productbuild({
    Key? key,
    this.isSearching = false,
  }) : super(key: key);

  @override
  _productbuildstate createState() => _productbuildstate();
}

class _productbuildstate extends State<productbuild> {
  _productbuildstate({Key? key});

  // List<String>product = ["Coca cola","pepsi","bean and cheese burrito"];
  List<String> images = [
    'https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png',
  ];
  List<items> _items = [
    items(
        'Coca cola',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054130173718528/vegan_icon_maybe.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054244447539240/vegetarian_icon_maybe.png',
        '85345689894'),
    items(
        'Impossible burgers',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054249040298004/vegetarian_icon.png',
        '85269004583'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795')
  ];
  List<items> _itemsCopy = [
    items(
        'Coca cola',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054130173718528/vegan_icon_maybe.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054244447539240/vegetarian_icon_maybe.png',
        '85345689894'),
    items(
        'Impossible burgers',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054249040298004/vegetarian_icon.png',
        '85269004583'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795'),
    items(
        'Bean and cheese burrito',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',
        '96713456795')
  ];

  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (widget.isSearching == false) {
      setState(() {
        _items.clear();
        _items.addAll(_itemsCopy);
      });
    }
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.isSearching
              ? Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border(
                        bottom: BorderSide(
                      width: 1,
                      color: Colors.green,
                    )),
                  ),
                  child: SizedBox(
                    width: 400,
                    height: 80,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                                isDense: true,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(),
                                    borderRadius: BorderRadius.circular(10)),
                                suffixIcon: const Icon(
                                  FontAwesomeIcons.search,
                                  size: 20,
                                ),
                                hintText: 'Search',
                                contentPadding:
                                    const EdgeInsets.only(left: 10)),
                            onChanged: (value) {
                              filterSearchResults(value);
                            },
                            controller: searchController,
                          ),
                        )),
                  ))
              : Container(),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height / 7),
                itemCount: _items.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: 100,
                    height: 90,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 3),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3,
                              offset: Offset(1, 3))
                        ]),
                    margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
                    child: ListTile(
                      leading: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minHeight: 90,
                          minWidth: 100,
                          maxHeight: 90,
                          maxWidth: 100,
                        ),
                        child: Image.asset('images/mapimage.jpg'),
                      ),
                      title: Text(
                        _items[index].product,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: NetworkImage(_items[index].img1),
                            width: 30,
                            height: 50,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image(
                            image: NetworkImage(_items[index].img2),
                            width: 30,
                            height: 50,
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => itempage(
                                    title: _items[index].product,
                                    image1: _items[index].img1,
                                    image2: _items[index].img2,
                                    barcode: _items[index].barcode)));
                      },
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  void filterSearchResults(String query) {
    List<items> searchList = <items>[];
    List<items> copyItems = _items;
    searchList.addAll(_items);
    if (query.isNotEmpty) {
      List<items> dummyListItems = <items>[];
      searchList.forEach((item) {
        if (item.product.toLowerCase().contains(query.toLowerCase())) {
          dummyListItems.add(item);
        }
      });
      setState(() {
        _items.clear();
        _items.addAll(dummyListItems);
      });
      return;
    } else {
      setState(() {
        _items.clear();
        _items.addAll(_itemsCopy);
      });
    }
  }
}

class items {
  String product = "";
  String img1 = "";
  String img2 = "";
  String barcode = "";
  items(this.product, this.img1, this.img2, this.barcode);
}

class itempage extends StatelessWidget {
  const itempage(
      {Key? key,
      required this.title,
      required this.image1,
      required this.image2,
      required this.barcode})
      : super(key: key);
  final String title;
  final String image1;
  final String image2;
  final String barcode;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.all(80)),
          Center(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 120,
                height: 90,
              ),
              Image(
                image: NetworkImage(image1),
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 50,
                height: 90,
              ),
              Image(
                image: NetworkImage(image2),
                width: 50,
                height: 50,
              ),
              //SizedBox(height: 100,),
            ],
          ),
          Container(
              // margin:EdgeInsets.all(20),

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                // Padding(padding: EdgeInsets.only(left:20)),
                Text(
                  'Barcode: ${barcode}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Notes',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
               Padding(padding:EdgeInsets.fromLTRB(15, 1,15, 1),child:
 Card(
     elevation:6,
     child: ClipPath(
       child: Container(
         child:Text("Enter your notes..."),
      
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
       clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3))),
               ),
              
              
    )
),
Padding(padding: EdgeInsets.only(left:320),child:
IconButton(onPressed:(){},icon:Icon(FontAwesomeIcons.edit))
)
               ]
               
               ),
              



              )




              
        ],
      ),
    );
  }
}

