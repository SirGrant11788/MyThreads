import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mythreads/services/db.dart';
import 'package:mythreads/services/weatherDialog.dart';
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
  var dbMap;
  var dbMapFav;
  List<String> favList = List(); //diplsay fav 'cat' horizontal
  //List<String> dbList = List<String>(); //testing
  List<Tab> catTabList = List<Tab>();
  List<Widget> contTabList = List<Widget>();
  String weatherToday = "MyThreads";
  String weatherIcon = '';
  WeatherStation weatherStation =
      new WeatherStation("996cc4f3b136aea607960591dd64e7a5");
      
  // int chipPref = 0; //use to 'search' in tabs

  @override
  Widget build(BuildContext context) {

    //_query(); //fetches items from db
//loadWeatherToday();
//default if nothing is in the db
    final _kTabPages = <Tab>[
      Tab(text: 'Welcome\nadd an item to begin'), //TODO proper intro
    ];
    final _kTabs = <Tab>[
      Tab(text: 'WELCOME'),
    ];

    return FutureBuilder(
        future: _query(),
        // future: loadWeatherToday(),
        builder: (context, snapshot) {
          return DefaultTabController(
            length: catTabList.length == 0 ? _kTabs.length : catTabList.length,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: 
                weatherIcon == ''
                      ? [Text("")]
                      : [
                          Image.network(
                            'http://openweathermap.org/img/wn/$weatherIcon@2x.png',
                            fit: BoxFit.contain,
                            height: 32,
                          ),
                          InkWell(
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  weatherToday,
                                  style: new TextStyle(fontSize: 17.64),
                                )),
                            onTap: () {
                              showDialogWeather(context);
                            },
                          ),           
                        ],
                ),
                
                leading: PopupMenuButton<String>(
                  onSelected: (value) => value == 'Settings'
                      ? _delTables()
                      : null, //TODO settings page

                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      child: Text('Shop'),
                      value: 'Shop',
                    ),
                    const PopupMenuItem<String>(
                      child: Text('Backup'),
                      value: 'Backup',
                    ),
                    const PopupMenuItem<String>(
                      child: Text('Settings'),
                      value: 'Settings',
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
              ),
              body: new ListView(
                children: <Widget>[
                  new Container(
                    alignment: Alignment.center,
                    color: Colors.blueGrey[50],
                    height: MediaQuery.of(context).size.height /
                        3.3, //fit a percentage of the device screen TODO DYNAMIC
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      //padding: const EdgeInsets.all(8.0),
                      itemCount: favList.length,
                      itemBuilder: (BuildContext context, int ind) {
                        return Container(
                            decoration: BoxDecoration(
                              border: Border(
                                left:
                                    BorderSide(width: 1.0, color: Colors.blue),
                                right:
                                    BorderSide(width: 1.0, color: Colors.blue),
                                top: BorderSide(),
                              ),
                            ),
                            width: 160.0,
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                //padding: const EdgeInsets.all(8.0),
                                itemCount: dbMapFav.length,
                                itemBuilder: (BuildContext context, int i) {
                                  return favList[ind] == dbMapFav[i]['fav']
                                      ? Card(
                                          child: Stack(
                                            children: <Widget>[
                                              '${dbMap[dbMapFav[i]['_id']]['pic'].toString()}' !=
                                                          "" ||
                                                      '${dbMap[dbMapFav[i]['_id']]['pic'].toString()}' !=
                                                          null
                                                  ? Image.file(new File(
                                                      '${dbMap[dbMapFav[i]['_id']]['pic'].toString().substring(6).replaceAll("'", "")}'))
                                                  : CircleAvatar(
                                                      child: Icon(
                                                          Icons.accessibility)),
                                              Container(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                color: Colors.blue[500]
                                                    .withOpacity(0.5),
                                                child: Center(
                                                  // child: Text(
                                                  //   '${dbMap[dbMapFav[i]['_id']]['name']}',
                                                  //   textAlign: TextAlign.center,
                                                  //   style: TextStyle(
                                                  //     fontSize: 16.0,
                                                  //     //fontWeight: FontWeight.bold,
                                                  //     color: Colors.white,
                                                  //   ),
                                                  // ),
                                                  child:RichText(
                                                                        text: TextSpan(
                                                                            style: TextStyle(
                                                                              fontSize: 14.0,
                                                                              color: Colors.black,
                                                                            ),
                                                                            children: <TextSpan>[
                                                                              new TextSpan(
                                                                                text: '${dbMap[dbMapFav[i]['_id']]['name']}\n',
                                                                                style: new TextStyle(
                                                                                  fontSize: 16.0,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              new TextSpan(text: '${favList[ind]}', style: new TextStyle(fontSize: 10.0, color: Colors.white,)),
                                                                            ]),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        softWrap:
                                                                            true,
                                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container();
                                }));
                      },
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        color: Theme.of(context).primaryColor),
                    alignment: Alignment.center,
                    child: TabBar(
                      isScrollable: true,
                      tabs: catTabList.length == 0 ? _kTabs : catTabList,
                    ),
                  ),
                  new Container(
                    alignment: Alignment.center,
                    color: Colors.blueGrey[50],
                    height: MediaQuery.of(context).size.height /
                        2.08, //fit a percentage of the device screen TODO DYNAMIC
                    child: TabBarView(
                      children:
                          catTabList.length == 0 ? _kTabPages : contTabList,
                    ),
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.accessibility_new),
                mini: true,
                onPressed: () {
                  if (dbMap != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewerPage()));
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Add Items First',
                      toastLength: Toast.LENGTH_LONG,
                    );
                  }
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
                            MaterialPageRoute(
                                builder: (context) => AddProductPage()),
                          );
                        }),
                    IconButton(
                      icon: Icon(Icons.shopping_basket),
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (BuildContext context) => MyWebView(
                        //           title: "Store Website",
                        //           selectedUrl: "https://www.google.com",
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

  _delTables() async {
    print('_delTables executed');
    // await db.deleteAllTablePack();
    //  await db.deleteAllTableFav();
    //  await db.deleteAllTable();
    // await db.deleteAllTableFavRows();
  }

  _query() async {
    final allRows = await db.queryAllRows();
    final allRowsFav = await db.queryAllRowsFav();
// testing column name
final allColumns = await db.queryColumns();
    allColumns.forEach((column){print('${column['name']}');});
//testing

    catTabList.clear();
    allRows.forEach((row) {
      if (!catTabList.toString().contains('${row['cat']}')) {
        catTabList.add(Tab(text: '${row['cat']}'));
      }
    });

    favList.clear();
    allRowsFav.forEach((element) {
      if (!favList.toString().contains('${element['fav']}')) {
        favList.add('${element['fav']}');
      }
    });
    
    dbMap = allRows;
    dbMapFav = allRowsFav;
    loadList();
    //loadWeatherToday();
    Weather weather = (await weatherStation.currentWeather());
    if('${weather.weatherMain}'!=null && '${weather.tempMin.celsius.round()}' != null && '${weather.tempMax.celsius.round()}'!=null){
    weatherToday =
        '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
    if('${weather.weatherIcon}'!=null){
    weatherIcon = weather.weatherIcon;
    }
    }

    
  }

  // Future<void> loadWeatherToday() async {
  //   Weather weather = (await weatherStation.currentWeather());
  //   weatherToday =
  //       '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
  //   weatherIcon = weather.weatherIcon;
  //   //return weatherToday;
  //   print('weather');
  //   //loadWeatherToday();

  // }

  //loads the items into the correct tabs
  loadList() {
    contTabList.clear();
    for (int i = 0; i < catTabList.length; i++) {
      //run for number of available tabs
      contTabList.add(
        ListView.builder(
          itemCount: dbMap.length,
          itemBuilder: (ctx, index) {
            return catTabList[i].text == dbMap[index]['cat']
                ? new Card(
                    child: new ListTile(
                      leading: '${dbMap[index]['pic'].toString()}' != "" ||
                              '${dbMap[index]['pic'].toString()}' != null
                          ? Image.file(new File(
                              '${dbMap[index]['pic'].toString().substring(6).replaceAll("'", "")}'))
                          : CircleAvatar(child: Icon(Icons.accessibility)),
                      title: Text('${dbMap[index]['name']}'),
                      subtitle://TODO sort out mess of ifs
                       '${dbMap[index]['fit']}' !='null' && '${dbMap[index]['size']}' != 'null'?
                      Text('${dbMap[index]['fit']} ${dbMap[index]['size']}'):
                      '${dbMap[index]['fit']}' =='null' && '${dbMap[index]['size']}' == 'null'?
                          Text(''):
                          '${dbMap[index]['fit']}' =='null'?
                          Text('${dbMap[index]['size']}'):
                          '${dbMap[index]['size']}' =='null'?
                          Text('${dbMap[index]['fit']}'):
                          Text(''),
                      trailing: Icon(Icons.arrow_right),
                      onTap: () {
                        _showDialogItemInfo(context, dbMap[index]);
                      },
                    ),
                  )
                : new Container();
          },
        ),
      );
    }
  }

  _showDialogItemInfo(BuildContext context, var dbMapItem) {
    TextEditingController _textFieldControllerName = TextEditingController(text: '${dbMapItem['name']}');
    TextEditingController _textFieldControllerCat = TextEditingController(text: '${dbMapItem['cat']}');
    TextEditingController _textFieldControllerSize = TextEditingController(text: '${dbMapItem['size']}');
    TextEditingController _textFieldControllerFit = TextEditingController(text: '${dbMapItem['fit']}');
    TextEditingController _textFieldControllerWeather = TextEditingController(text: '${dbMapItem['weather']}');
    TextEditingController _textFieldControllerRating = TextEditingController(text: '${dbMapItem['rating']}');
    TextEditingController _textFieldControllerDesc = TextEditingController(text: '${dbMapItem['desc']}');
    File _cameraImage;
    String _photo = dbMapItem['pic'];
    Future _pickImageFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera);
    setState(() {
      _cameraImage = image;
      
    });
  }
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              scrollable: true,
              title: Column(children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.0, color: Colors.blue)),
                  child: '${dbMapItem['pic'].toString()}' != "" ||
                          '${dbMapItem['pic'].toString()}' != null
                      ? Image.file(new File(
                          '${dbMapItem['pic'].toString().substring(6).replaceAll("'", "")}'))
                      : CircleAvatar(child: Icon(Icons.accessibility)),
                ),
                // Container(
                //   padding: const EdgeInsets.all(8.0),
                //   width: MediaQuery.of(context).size.width,
                //  //decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.blue)),
                //   child: Text('${dbMapItem['name']}',textAlign: TextAlign.center,style: TextStyle(),),
                // ),
                // Container(
                //       width: MediaQuery.of(context).size.width,
                //       child: Text('NAME', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                //     ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerName,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Name',
                        labelText: 'Name',
                      ),
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('SIZE', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerSize,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Size',
                        labelText: 'Size',
                      ),
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('FIT', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerSize,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Fit',
                        labelText: 'Fit',
                      ),
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('CATEGORY', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerCat,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Category',
                        labelText: 'Category',
                      ),
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('WEATHER', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerWeather,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Weather',
                        labelText: 'Weather',
                      ),
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('RATING', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerRating,
                      //add limit to ten and only numbers
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Rating',
                        labelText: 'Rating',
                      ),
                      inputFormatters: [ WhitelistingTextInputFormatter(RegExp("[0-9]")),],maxLength: 1,
                      keyboardType: TextInputType.number,
                    )),
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Text('NOTE', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    // ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller:_textFieldControllerDesc,
                      //expand to three lines
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'Note',
                        labelText: 'Note',
                      ),
                      maxLines: 3,
                    )),
                //option to take another pic
                Container(
                      width: MediaQuery.of(context).size.width,
                      child: Text('NEW PHOTO', style: TextStyle(fontSize: 14, color: Colors.blue),textAlign: TextAlign.center,),
                    ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width,
                    child: new RawMaterialButton(
                onPressed: () {
                      _pickImageFromCamera();
                }, //add pic
                child:_cameraImage == null ? new Icon(
                  Icons.camera_enhance,
                  color: Colors.blue,
                  size: 35.0,
                ): new Icon(
                  Icons.camera_alt,
                  color: Colors.red,
                  size: 35.0,
                ),
                shape: new CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.white,
                padding: const EdgeInsets.all(15.0),
              ),
                ),
              ],
              ),
              actions: <Widget>[
                  new FlatButton(
                    child: new Text('SAVE',textAlign: TextAlign.center,),
                    onPressed: () {
                      _cameraImage == null?
                      _updateItem(dbMapItem['_id'], _textFieldControllerName.text, _textFieldControllerCat.text, _textFieldControllerSize.text, _textFieldControllerFit.text, _textFieldControllerWeather.text, _textFieldControllerRating.text, _textFieldControllerDesc.text, _photo)
                      :
                      _updateItem(dbMapItem['_id'], _textFieldControllerName.text, _textFieldControllerCat.text, _textFieldControllerSize.text, _textFieldControllerFit.text, _textFieldControllerWeather.text, _textFieldControllerRating.text, _textFieldControllerDesc.text, _cameraImage.uri);
                    },
                  ),
                  new FlatButton(
                    child: new Text('DELETE',textAlign: TextAlign.center,),
                    onPressed: () {
                      _delItem(dbMapItem['_id'],dbMapItem['name']);
                //       Navigator.push(
                // context,
                // MaterialPageRoute(builder: (context) => MyApp()));
                    },
                  ),
                  new FlatButton(
                    child: new Text('CANCEL',textAlign: TextAlign.center,),
                    onPressed: () {
                      print('CANCEL ${_textFieldControllerName.text}');
                      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
                    },
                  ),
                ],
              );
        });
  }
//TODO FIX DELETE MISSHAP!
  _delItem(id,name) async {
    await db.deleteFavName('$name');
      await db.delete(id);
    Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
  }
  _updateItem(id,name,cat,size,fit,weather,rating,desc,pic) async{
await db.updateQuery(id, name, cat, size, fit, weather, rating, desc, pic);
await db.updateQueryFavName(id, name);

print('item updated');
Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
  }
}
