import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:quiver/collection.dart';
import 'package:vscanner_finalproject_csci4100/product.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
	  runApp(const MyApp());
	}

class MyApp extends StatelessWidget {
	  const MyApp({Key? key}) : super(key: key);

	  @override
	  Widget build(BuildContext context) {
	    return MaterialApp(
	      title: 'Flutter Demo',
	      theme: ThemeData(
	        primarySwatch: Colors.blue,
      		),
	      home: const productbuild(),
	    
	    );
	  }
	}
  class productbuild extends StatefulWidget {
	  const productbuild({Key? key}) : super(key: key);

	  @override
	  _productbuildstate createState() => _productbuildstate();
	}

	class  _productbuildstate extends State<productbuild> {
    	 _productbuildstate({Key? key});

   // List<String>product = ["Coca cola","pepsi","bean and cheese burrito"];
    List<String>images = ['https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png',];
     List<items> _items = [
  items('Coca cola','https://cdn.discordapp.com/attachments/891062649742299236/915054130173718528/vegan_icon_maybe.png', 
  'https://cdn.discordapp.com/attachments/891062649742299236/915054244447539240/vegetarian_icon_maybe.png','85345689894'),
  items('Impossible burgers','https://cdn.discordapp.com/attachments/891062649742299236/915054136964304947/vegan_icon.png', 
  'https://cdn.discordapp.com/attachments/891062649742299236/915054249040298004/vegetarian_icon.png','85269004583'),
   items('Bean and cheese burrito','https://cdn.discordapp.com/attachments/891062649742299236/915054134309306398/vegan_icongreyed.png', 
  'https://cdn.discordapp.com/attachments/891062649742299236/915054247014436924/vegetarian_icongreyed.png','96713456795'),
  ];


      @override
	  void initState() {
	    // TODO: implement initState
	    super.initState();
    }
    Widget build(BuildContext context)
    {
      return Scaffold(
        appBar: AppBar(title: Text("Products scanned"),
        
        
      ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        children: [
        
            SizedBox(
            width: 400,
            height: 80,
            child:
       Padding(padding: EdgeInsets.all(10),
        child:
          TextField(decoration: InputDecoration(border:OutlineInputBorder(borderSide: BorderSide()),prefixIcon: Icon(Icons.search),labelText: 'Search'),))
          ,
            ),
          
          Expanded(
            child:
         ListView.builder(
        	  itemCount: _items.length,
        	  itemBuilder: (BuildContext context, int index) {
              return Container(
                
              width: 100,
              height: 90,
	          decoration: BoxDecoration(color: Colors.white,border: Border.all(color: Colors.grey)),
              
	          margin: const EdgeInsets.all(10.0),
	              child: ListTile(
                  contentPadding: EdgeInsets.only(left: 100),
                //  contentPadding: EdgeInsets.fromLTRB(150, 0, 80, 0),
                    //contentPadding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  title: Text(_items[index].product,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),),
                          
	                subtitle: 
                  Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   SizedBox(width: 90),
                    Image(image:NetworkImage(_items[index].img1),width: 30,height: 50, ),
                  SizedBox(width: 20,),
                   Image(image:NetworkImage(_items[index].img2),width: 30,height: 50, ),

              
                    

                  ]
                  
                  ,),
                 
	                onTap: () {
	               
	                   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => itempage(title: _items[index].product,image1: _items[index].img1,image2: _items[index].img2,
                barcode:_items[index].barcode)));
	                
	                },
            
                  
              
                ),
	            );
	          }),
           
              
            
            
            
          )
            
            ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 75,
            width: 75,
            child: FloatingActionButton(
              backgroundColor: Colors.grey[700],
              onPressed: () async {
              
            
            
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
                    onPressed: () async {
                      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => productbuild()),
  );
                   
                     
                     
                    },
                    icon:
                    
                     Icon(FontAwesomeIcons.listUl,
                        color: Colors.white)),
                 IconButton(
                  icon: Icon(null),
                  onPressed: (){
                    Navigator.pop(context);},
                ),
                IconButton(
                  onPressed: () {
                    print("hello!");
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
  class items{
   String product= "";
    String img1="";
  String img2="";
  String barcode = "";
 items(this.product,this.img1,this.img2,this.barcode);
  }

  class itempage extends StatelessWidget {
const itempage({Key? key,required this.title,required this.image1,required this.image2,required this.barcode}) : super(key: key);
final String title;
final String image1;
final String image2;
final String barcode;

	 

 

  Widget build(BuildContext context)
  {
    return Scaffold(
     appBar: AppBar(title: Text(title),
     automaticallyImplyLeading: false,),
     body: Column(mainAxisAlignment: MainAxisAlignment.start,
     crossAxisAlignment: CrossAxisAlignment.start,
     
     children: [
      Padding(padding:EdgeInsets.all(80)),
       Center(
         child:
       Text(title,style: 
     
  
     TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
    Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                   SizedBox(width: 120,height: 90,),
                    Image(image:NetworkImage(image1),width: 50,height: 50, ),
                  SizedBox(width: 50,height: 90,),
                   Image(image:NetworkImage(image2),width: 50,height: 50, ),
                   //SizedBox(height: 100,),
                   
                  
                  

                  ]
                  
                  ,),
                
               Container(
                 // margin:EdgeInsets.all(20),
                
                child: 
            
               Column(
                
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              children:[
               // Padding(padding: EdgeInsets.only(left:20)),
                Text('Barcode: ${barcode}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                SizedBox(height: 40,),
                Text('Notes',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
     TextField(decoration: InputDecoration(border:OutlineInputBorder(borderSide: BorderSide()),contentPadding: EdgeInsets.symmetric(horizontal: 10)))

             
                
           

             


               ]
               ))

     ],
    
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
          ),
        )


    );
  }
  }
  