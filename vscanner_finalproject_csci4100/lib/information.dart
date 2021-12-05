import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/bottomappbar.dart';
import 'listproducts.dart';

class infopage extends StatelessWidget{
  const infopage({Key? key}) : super(key: key);

   // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Information page"),
      
      automaticallyImplyLeading: false,),
      
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
        children: [
Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10 ),child:
Text("Information",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20))),


  Padding(padding: EdgeInsets.symmetric(horizontal: 15),child: Column(children:[

Row(mainAxisAlignment: MainAxisAlignment.start,
  
  children: [

Image(image: NetworkImage("https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png"
),width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9,),
SizedBox(width: MediaQuery.of(context).size.width/25,),

Flexible(child:

Text("The green vegan icon indicates that the food item contains no animal product ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)

)],)
,

Row(children: [
  Image(image:NetworkImage('https://cdn.discordapp.com/attachments/891062649742299236/915054249040298004/vegetarian_icon.png'),
  
  width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9, ),
  SizedBox(width: MediaQuery.of(context).size.width/25,),

  Flexible(child:
  Text("The green vegetarian icon indicates that the food adheres to a vegetarians dietary standards ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
  
)],),
Row(children: [
  Image(image:NetworkImage('https://cdn.discordapp.com/attachments/891062649742299236/915054130173718528/vegan_icon_maybe.png'),
  
  width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9, ),
  SizedBox(width: MediaQuery.of(context).size.width/25,),

  Flexible(child:
  Text("The red vegan icon indicates that the food item may contain animal products -- certain food additives may or may not be vegan. Proceed with caution ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
  
)],),
Row(children: [
  Image(image:NetworkImage('https://cdn.discordapp.com/attachments/891062649742299236/915054244447539240/vegetarian_icon_maybe.png'),
  
  width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9, ),
  SizedBox(width: MediaQuery.of(context).size.width/25,),

  Flexible(child:
  Text("The red vegatarian icon indicates that the food item may contain animal products -- certain food additives may or may not be vegatarian. Proceed with caution ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
  
)],),
Row(children: [
  Image(image:NetworkImage(        'https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png',
),
  
  width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9, ),
  SizedBox(width: MediaQuery.of(context).size.width/25,),

  Flexible(child:
  Text("The grey vegan icon indicates that the food item contains animal products and therefore not suitable for vegans ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
  
)],),

Row(children: [
  Image(image:NetworkImage(        'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png',

),
  
  width: MediaQuery.of(context).size.width/9,height: MediaQuery.of(context).size.height/9, ),
  SizedBox(width: MediaQuery.of(context).size.width/25,),

  Flexible(child:
  Text("The grey vegatarian icon indicates that the food item contains animal products and therefore not suitable for vegetarians ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),)
  
)],),





        ]))
  
  
  ]
  
  
  
  
  ),


   floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
   
        floatingActionButton: Container(
            height: 70,
            width: 70,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[700],
              onPressed: () async {
              /*
                barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    "#228B22", "Cancel", true, ScanMode.BARCODE);
                print(barcodeScanRes);
                setState(() {});
                */
              
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
                      /*
                      Position position = await _determinePosition();
                      lat = position.latitude.toString();
                      print(lat);
                      long = position.longitude.toString();
                      print(long);
                      setState(() {});
                      */
                      Navigator.pop(context);
                    },
                    icon: const Icon(FontAwesomeIcons.listUl,
                        color: Colors.white)),
                IconButton(
                icon: Icon(null),
                  onPressed:(){
                 //   Navigator.pop(context);
              //   print("hello");
                  }
                ),
                IconButton(
                  onPressed: () {
              
              
                  },
                  icon: const Icon(FontAwesomeIcons.info, color: Colors.white),
                )
              ],
            ),
          ),
        )
      


        );
  
  }
}