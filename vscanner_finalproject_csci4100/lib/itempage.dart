// ignore_for_file: use_key_in_widget_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vscanner_finalproject_csci4100/db_helper.dart';

class itempage extends StatefulWidget {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: EdgeInsets.fromLTRB(80,0,80,80)),
          Center(
              child: Text(
            widget.title,
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
                image: NetworkImage(widget.image1),
                width: 50,
                height: 50,
              ),
              const SizedBox(
                width: 50,
                height: 90,
              ),
              Image(
                image: NetworkImage(widget.image2),
                width: 50,
                height: 50,
              ),
              //SizedBox(height: 100,),
            ],
          ),


Padding(padding:EdgeInsets.all(20),child: 
Column(crossAxisAlignment: CrossAxisAlignment.start,
  
  
  children: [Text('Barcode: ${widget.barcode}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
  SizedBox(height:20),
  Text("Notes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
  ],)
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
Padding(padding: EdgeInsets.only(left:300),child:
Row(children: [
  IconButton(onPressed:(){
    // Map<String, dynamic> row = {};
    // DBHelper.dbHelper.updateProduct(row);
  },icon:Icon(FontAwesomeIcons.edit)),
  IconButton(onPressed:() async{
    await showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Delete Product?"),
        content: Text("This action cannot be undone"),
        actions: [
          TextButton(onPressed: (){
            DBHelper.dbHelper.deleteProduct(widget.barcode);
            Navigator.pop(context);
            Navigator.pop(context);
          }, 
          child: Text("Delete")),

          TextButton(onPressed: (){
            Navigator.pop(context);
          }, 
          child: Text("Cancel"))
        ],
      );
    });
  },icon:Icon(FontAwesomeIcons.trashAlt))
],)
),

               ]
               
               ),
              


    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 75,
            width: 75,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[700],
              onPressed: ()  {
              
            
            
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
            height: MediaQuery.of(context).size.height / 10,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                    onPressed: () {
                     Navigator.pop(context);
                     
                     
                    },
                    icon:
                    
                     Icon(FontAwesomeIcons.listUl,
                        color: Colors.white)),
                 IconButton(
                  icon: Icon(null),
                  onPressed: (){
              
                  },
                ),
                IconButton(
                  onPressed: () {
                
                  },
                  icon: const Icon(FontAwesomeIcons.info, color: Colors.white),
                )
              ],
            ),
          )
        )




    );
  }

  Future<void> _showAlertDialog(BuildContext context) async{
    return showDialog(context: context, 
    builder: (BuildContext context){
      return AlertDialog(
        title: Text("Delete product?"),
        content: Text("Delete?"),
        actions: [
          TextButton(onPressed: (){}, 
          child: Text("Yes")),
          TextButton(onPressed: (){}, 
          child: Text("No"))
        ],
      );
    });
  }
}
