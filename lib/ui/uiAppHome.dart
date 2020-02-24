import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mythreads/services/db.dart';
import 'package:mythreads/ui/uiAddProduct.dart';
import 'package:mythreads/ui/uiViewer.dart';
import 'package:weather/weather.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyThreads',
      theme: ThemeData(
        // This is the theme of your application.

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'MyThreads'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = DatabaseHelper.instance;
  var dbMap; //testing
  List<String> dbList = List<String>(); //testing
  List<Tab> catTabList = List<Tab>();
  List<Widget> contTabList = List<Widget>();
  String weatherToday = "weather";
  String weatherIcon = '01d';
  WeatherStation weatherStation =
      new WeatherStation("996cc4f3b136aea607960591dd64e7a5");

  Future<void> loadWeatherToday() async {
    Weather weather = (await weatherStation.currentWeather());
    weatherToday =
        '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
    weatherIcon = weather.weatherIcon;
    print(weatherIcon.toString() + " WeatherState: " + weatherToday);
    //return weatherToday;
  }

  int chipPref = 0; //use to 'search' in tabs
  //loads the items into the correct tabs
  loadList() {
    contTabList.clear();

    for (int i = 0; i < catTabList.length; i++) {
      //run for number of available tabs

      contTabList.add(
        ListView.builder(
          itemCount: dbMap.length,
          itemBuilder: (ctx, index) {
            return
             catTabList[i].text == dbMap[index]['cat']? 
                new Card(
                    child: new ListTile(
                      leading:'${dbMap[index]['pic'].toString()}'!="" ||'${dbMap[index]['pic'].toString()}'!=null
                      ? Image.file(new File('${dbMap[index]['pic'].toString().substring(6).replaceAll("'", "")}'))
                      : CircleAvatar(child: Icon(Icons.accessibility)),
                      title: Text('${dbMap[index]['name']}'),
                      subtitle: Text(
                          '${dbMap[index]['fit']} ${dbMap[index]['size']} ${dbMap[index]['cat']}'),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: 'Item pressed',
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                    ),
                  )
                : new Card();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    
    _query();//fetches items from db
    
//default if nothing is in the db
    final _kTabPages = <Tab>[
      Tab(text: 'Welcome to MyThreads'), //todo proper intro
    ];
    final _kTabs = <Tab>[
      Tab(text: 'WELCOME'),
    ];

    
return FutureBuilder(
      future: loadWeatherToday(),
      builder: (context, snapshot){
    return DefaultTabController(
      length: catTabList.length == 0
          ? _kTabs.length
          : catTabList.length, 
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'http://openweathermap.org/img/wn/$weatherIcon@2x.png',
                fit: BoxFit.contain,
                height: 32,
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(weatherToday,style: new TextStyle(fontSize:17.64),)),
                onTap: () {
                  loadWeatherToday();
                },
              ),
            ],
          ),
          leading: PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                child: Text('Shop'),
              ),
              const PopupMenuItem<String>(
                child: Text('Backup'),
              ),
              const PopupMenuItem<String>(
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                child: Text('Info'),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'search pressed',
                  toastLength: Toast.LENGTH_LONG,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'account pressed',
                  toastLength: Toast.LENGTH_LONG,
                );
              },
            ),
          ],
          //¯\_(ツ)_/¯
          ),body: new ListView(
        children: <Widget>[
new Container(
            alignment: Alignment.center,
            color: Colors.blueGrey[50],//testing todo
            height:  MediaQuery.of(context).size.height / 3.3,//fit a percentage of the device screen
            child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Padding(padding:const EdgeInsets.all(8.0),),
              Container(
                width: 160.0,
                color: Colors.red,
              ),
              Padding(padding:const EdgeInsets.all(8.0),),
              Container(
                width: 160.0,
                color: Colors.blue,
              ),
              Padding(padding:const EdgeInsets.all(8.0),),
              Container(
                width: 160.0,
                color: Colors.green,
              ),
              Padding(padding:const EdgeInsets.all(8.0),),
              Container(
                width: 160.0,
                color: Colors.yellow,
              ),
              Padding(padding:const EdgeInsets.all(8.0),),
              Container(
                width: 160.0,
                color: Colors.orange,
              ),
              Padding(padding:const EdgeInsets.all(8.0),),
            ],
          ),
          ),
          new Container(
            decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
            alignment: Alignment.center,
            child:TabBar(
            isScrollable: true,
            tabs: catTabList.length == 0 ? _kTabs : catTabList, 
          ),
          ),
          new Container(
            alignment: Alignment.center,
            color: Colors.blueGrey[50],//testing todo
            height:  MediaQuery.of(context).size.height / 2.08,//fit a percentage of the device screen
            child:TabBarView(
          children: catTabList.length == 0
              ? _kTabPages
              : contTabList, 
        ),
          ),
        ],),
        //¯\_(ツ)_/¯
        //   bottom: TabBar(
        //     isScrollable: true,
        //     tabs: catTabList.length == 0 ? _kTabs : catTabList, 
        //   ),
        // ),
        // body: 
        // TabBarView(
        //   children: catTabList.length == 0
        //       ? _kTabPages
        //       : contTabList, 
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.accessibility_new),
          mini: true,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewerPage()));
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 2.0,
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ToDo()),
                    // );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddProductPage()),
                    );
                  }),
              IconButton(
                icon: Icon(Icons.shopping_basket),
                onPressed: () {
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (BuildContext context) => MyWebView(
                  //           title: "Macarbi Website",
                  //           selectedUrl: "https://www.macarbi.com",
                  //         )));
                  Fluttertoast.showToast(
                    msg: 'button pressed',
                    toastLength: Toast.LENGTH_LONG,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
      });
  }


  _query() async {
    final allRows = await db.queryAllRows();
    //print('query all rows:');
    //allRows.forEach((row) => print(row));
    //dbList.clear();
    //dbMap.clear();
    //  allRows.forEach((row) => dbMap.putIfAbsent(row['_id'].toString(), row['name']));
    //  print('dbMap: $dbMap');
    //print('dblist: ${dbList.toSet().toList()}');
    //return dbList.toSet().toList();
    //print('LIST: ${dbHome.length}');
    //  setState(() {
    //    dbList.toSet().toList();
    //  });
    //Tab(text: 'NK')

    catTabList.clear();
    //allRows.forEach((row) => catTabList.add(Tab(text: '${row['cat']}')));
    allRows.forEach((row) {
      if (!catTabList.toString().contains('${row['cat']}')) {
        //print('TEST: ${allRows[1]["cat"]}');
        catTabList.add(Tab(text: '${row['cat']}'));
        //print('if');
      }
    });

    dbMap = allRows;
    //catTabList = catTabList.toSet().toList();
    //allRows.forEach((row) => catTabList.add(row['cat']));
    //LENGTH: 3 TAB: [Tab(text: "Suit"), Tab(text: "Suit"), Tab(text: "Shorts")]
    //print('LENGTH: ${catTabList.length} TAB: ${catTabList}');
    //return catTabList;

    loadList();
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   mainAxisSize: MainAxisSize.max, //chips pref
//   children: [
//     ChoiceChip(
//       label: Text('all'),
//       selected: chipPref == 0,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 0;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('cold'),
//       selected: chipPref == 1,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 1;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('chilly'),
//       selected: chipPref == 2,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 2;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('mild'),
//       selected: chipPref == 3,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 3;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('warm'),
//       selected: chipPref == 4,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 4;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('hot'),
//       selected: chipPref == 5,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 5;
//         });
//       },
//     ),
//     ChoiceChip(
//       label: Text('other'),
//       selected: chipPref == 6,
//       onSelected: (value) {
//         setState(() {
//           chipPref = 6;
//         });
//       },
//     )
//   ],
// ),
