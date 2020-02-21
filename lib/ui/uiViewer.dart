
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mythreads/services/db.dart';

class ViewerPage extends StatefulWidget {
  
  @override
  _ViewerPageState createState() {
    
     
    
    return _ViewerPageState();
  }
}

class _ViewerPageState extends State<ViewerPage> {
  final db = DatabaseHelper.instance;
  
int chipPrefWeather =0;
int chipPrefCat =0;
var dbMap;
List<Widget> catListWidget = List<Widget>();
List<Widget> weatherListWidget = List<Widget>();
List catList = List();

_query() async {
  print('_query called');
    final allRows = await db.queryAllRows();
    print('Viewer allrows ${allRows}');
    dbMap= allRows;

  //finds the catagories and adds to catList
    catList.clear();
    allRows.forEach((row) {
      if (!catList.toString().contains('${row['cat']}')) {
        //print('TEST: ${allRows[1]["cat"]}');
        catList.add(Tab(text: '${row['cat']}'));
        //print('if');
      }
    });

for (int i = 0; i < catList.length; i++) {//loops only through catagories for main list
catListWidget.add(
  Row(
mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.max, 
  children: [
    Expanded( child: SizedBox(
            height: MediaQuery.of(context).size.height /5,
            child: new 
            Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.35,
        child:
  //
  ListView.builder(
          itemCount: dbMap.length,
          itemBuilder: (ctx, index) {
            return
             catList[i].text == dbMap[index]['cat']? 
                new Card(
                    child: SizedBox(
            height: MediaQuery.of(context).size.height /5,
            child: new 
            Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        height: MediaQuery.of(context).size.height * 0.35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: dbMap.length, itemBuilder: (context, index) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  color: Colors.blue,
                  child: Container(
                    child: Center(child: Text(dbMap[index]['name'].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                  ),
                ),
              );
        }),
      ),
    
    ),
                  )
                : new Card();
          },
        ),
  //
            ),),),],),);
  

}

}
 

@override
  Widget build(BuildContext context) {
    // testing
    _query();
    
    //testing
    return 
      Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.accessibility_new),
        title: Text('weather TODO'),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'Fav pressed',
                  toastLength: Toast.LENGTH_LONG,
                );
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(8.0),),
            //todo dynamic
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.max, //chips pref
  children: [
    ChoiceChip(
      label: Text('all'),
      selected: chipPrefWeather == 0,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 0;
        });
      },
    ),
    ChoiceChip(
      label: Text('cold'),
      selected: chipPrefWeather == 1,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 1;
        });
      },
    ),
    ChoiceChip(
      label: Text('chilly'),
      selected: chipPrefWeather == 2,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 2;
        });
      },
    ),
    ChoiceChip(
      label: Text('mild'),
      selected: chipPrefWeather == 3,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 3;
        });
      },
    ),
    ChoiceChip(
      label: Text('warm'),
      selected: chipPrefWeather == 4,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 4;
        });
      },
    ),
    ChoiceChip(
      label: Text('hot'),
      selected: chipPrefWeather == 5,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 5;
        });
      },
    ),
    ChoiceChip(
      label: Text('other'),
      selected: chipPrefWeather == 6,
      onSelected: (value) {
        setState(() {
          chipPrefWeather = 6;
        });
      },
    )
  ],
),
//todo dynamic
            Row(
  mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.max, //chips pref
  children: [
    ChoiceChip(
      label: Text('all'),
      selected: chipPrefCat == 0,
      onSelected: (value) {
        setState(() {
          chipPrefCat = 0;
        });
      },
    ),
    ChoiceChip(
      label: Text('Shirt'),
      selected: chipPrefCat == 1,
      onSelected: (value) {
        setState(() {
          chipPrefCat = 1;
        });
      },
    ),
    ChoiceChip(
      label: Text('Pants'),
      selected: chipPrefCat == 2,
      onSelected: (value) {
        setState(() {
          chipPrefCat = 2;
        });
      },
    ),
    ChoiceChip(
      label: Text('T-Shirt'),
      selected: chipPrefCat == 3,
      onSelected: (value) {
        setState(() {
          chipPrefCat = 3;
        });
      },
    ),
    ChoiceChip(
      label: Text('Dress'),
      selected: chipPrefCat == 4,
      onSelected: (value) {
        setState(() {
          chipPrefCat = 4;
        });
      },
    ),
    
  ],
),
          
          Row(
                    mainAxisAlignment: MainAxisAlignment.center,
  mainAxisSize: MainAxisSize.max, 
  children: [
      new Center(
       child:
         new Container(
          width: MediaQuery.of(context).size.height * 0.5294,color: Colors.blue,height:MediaQuery.of(context).size.height * 0.765,
          child: ListView.builder(
          scrollDirection: Axis.vertical,
            itemCount: dbMap.length, itemBuilder: (context, index) {//note change to cat length
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  color: Colors.red,
                  child: Container(
                              width: MediaQuery.of(context).size.height * 0.1,color: Colors.blue,height:MediaQuery.of(context).size.height * 0.1,

                    child: Center(child: 
                    ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: dbMap.length, itemBuilder: (context, index) {//note change to cat length
              return Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Card(
                  color: Colors.red,
                  child: Container(
                    child: Center(child: Text(dbMap[index]['name'].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
                  ),
                ),
              );
        }),
                    ),
                  ),
                ),
              );
        }),
        ),),
  //         mainAxisAlignment: MainAxisAlignment.center,
  // mainAxisSize: MainAxisSize.max, 
  // children: [
  //   Expanded( child: SizedBox(
  //           height: MediaQuery.of(context).size.height /5,
  //           child: new 
  //           Container(
  //       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
  //       height: MediaQuery.of(context).size.height * 0.35,
  //       child: ListView.builder(
  //         scrollDirection: Axis.horizontal,
  //           itemCount: dbMap.length, itemBuilder: (context, index) {
  //             return Container(
  //               width: MediaQuery.of(context).size.width * 0.6,
  //               child: Card(
  //                 color: Colors.blue,
  //                 child: Container(
  //                   child: Center(child: Text(dbMap[index]['name'].toString(), style: TextStyle(color: Colors.white, fontSize: 36.0),)),
  //                 ),
  //               ),
  //             );
  //       }),
  //     ),
    
  //   ),
  //   ),
  //
  ],
  ),
    

           
                
          
        
//
          ],
        ),
    ),
    );
      
  }


    
  }
 




