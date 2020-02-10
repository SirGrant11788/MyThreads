import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mythreads/services/weatherData.dart';
import 'package:weather/weather.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  String weatherToday = "weather";

  
//   Future<String>loadWeather() async {
// WeatherStation weatherStation = new WeatherStation("996cc4f3b136aea607960591dd64e7a5");
// Weather weather = (await weatherStation.currentWeather());
// weatherToday= '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
// return weatherToday;
// }
loadWeatherState(){
loadWeatherToday(weatherToday);
print("WeatherState: "+ weatherToday);
setState(() {});//weatherToday;
}
int chipPref = 0;//use to 'search' in tabs
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    loadWeatherState();
    
    //print(loadWeather());
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          mini: true,
          onPressed: () {
            Fluttertoast.showToast(
                msg: 'button pressed',
                toastLength: Toast.LENGTH_LONG,
              );
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
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ToDo()),
                    // );
                    Fluttertoast.showToast(
                msg: 'button pressed',
                toastLength: Toast.LENGTH_LONG,
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(weatherToday),//Text(widget.title),
        title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              //     Image.asset(
              //    'assets/logo.png',
              //     fit: BoxFit.contain,
              //     height: 32,
              // ),
              Icon(Icons.ac_unit),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text(weatherToday))
            ],

          ),
        leading:PopupMenuButton<String>(
     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
    const PopupMenuItem<String>(
      child: Text('Stuff!'),
    ),
    const PopupMenuItem<String>(
      child: Text('Other Stuff!'),
    ),
    const PopupMenuItem<String>(
      child: Text('Backup'),
    ),
    const PopupMenuItem<String>(
      child: Text('Settings'),
    ),
  ],
),
actions: <Widget>[
  IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Fluttertoast.showToast(
                msg: 'button pressed',
                toastLength: Toast.LENGTH_LONG,
              );
                },
            ),
  IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Fluttertoast.showToast(
                msg: 'button pressed',
                toastLength: Toast.LENGTH_LONG,
              );
                },
            ),
            
],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          children: <Widget>[
            Row(//favs carasole
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,//chips pref
children: [ChoiceChip(label: Text('all'), selected: chipPref==0, onSelected: (value){setState(() {
  chipPref = 0;
});},),
ChoiceChip(label: Text('cold'), selected: chipPref==1, onSelected: (value){setState(() {
  chipPref = 1;
});},),
ChoiceChip(label: Text('chilly'), selected: chipPref==2, onSelected: (value){setState(() {
  chipPref = 2;
});},),
ChoiceChip(label: Text('mild'), selected: chipPref==3, onSelected: (value){setState(() {
  chipPref = 3;
});},),
ChoiceChip(label: Text('warm'), selected: chipPref==4, onSelected: (value){setState(() {
  chipPref = 4;
});},),
ChoiceChip(label: Text('hot'), selected: chipPref==5, onSelected: (value){setState(() {
  chipPref = 5;
});},),
          ChoiceChip(label: Text('swim'), selected: chipPref==6, onSelected: (value){setState(() {
  chipPref = 6;
});},)],
            ),
            Row(//tabs and list

            )
          ],
        ),
      ),
      
    );
  }
}