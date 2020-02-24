import 'dart:io';
import 'package:mythreads/ui/uiAppHome.dart';
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

// final itemSize = 1.0;//testing Todo
  ScrollController _controller = ScrollController();
  TrackingScrollController _trackingScrollController = TrackingScrollController();

@override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }
   @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // int chipPrefWeather = 0;
  // int chipPrefCat = 0;
  var dbMap;
  List<Widget> catListWidget = List<Widget>(); //
  //List<Widget> weatherListWidget = List<Widget>(); //
  //List<ChoiceChip> chipWeather = List<ChoiceChip>();
  List<ChoiceChip> chipCat = List<ChoiceChip>();
  List catList = List();
  //List weatherList = List();
  List<String> prefListCat = List(); //what not to display
  //List<String> prefListweather = List();//what not to display

  _query() async {
    print('_query called');
    final allRows = await db.queryAllRows();
    //print('Viewer allrows ${allRows}');
    dbMap = allRows;

    //finds the catagories and adds to catList
    catList.clear();
    allRows.forEach((row) {
      if (!catList.toString().contains('${row['cat']}')) {
        catList.add(Tab(text: '${row['cat']}'));
      }
    });

    //   //finds the weathers and adds to weatherList
    //   weatherList.clear();
    //   allRows.forEach((row) {
    //     if (!weatherList.toString().contains('${row['weather']}')) {
    //       weatherList.add(Tab(text: '${row['weather']}'));
    //     }

    // });
    // chipWeather.clear();
    chipCat.clear();

    //create choice chips


    for (int i = 0; i < catList.length; i++) {
      chipCat.add(
        ChoiceChip(
          label: Text('${catList[i].text}'),
          selected: prefListCat.contains('${catList[i].text}') == false,
          onSelected: (value) {
            setState(() {
              //chipPrefCat = i+1;
              if (prefListCat.contains('${catList[i].text}') == true) {
                prefListCat.remove('${catList[i].text}');
                //print('if Remove $prefListCat');
              } else {
                prefListCat.add('${catList[i].text}');
                //print('else add $prefListCat');
              }
              //print(prefListCat);
            });
          },
        ),
      );
    }
// for(int i=0;i<weatherList.length;i++){
// chipWeather.add(
//   ChoiceChip(
//                   label: Text('${weatherList[i].text}'),
//                   selected: prefListweather.contains('${weatherList[i].text}')==false,
//                   onSelected: (value) {
//                     setState(() {
//                       if(prefListweather.contains('${weatherList[i].text}')==true){
// prefListweather.remove('${weatherList[i].text}');
//                       }else{
// prefListweather.add('${weatherList[i].text}');
//                       }
//                     });
//                   },
//                 ),
// );
// }
  }

  // _onStartScroll(ScrollMetrics metrics) {
  //   setState(() {
  //     //print("Scroll Start $metrics" );
  //   });
  // }

  // _onUpdateScroll(ScrollMetrics metrics) {
  //   setState(() {
  //     //print("Scroll update $metrics" );
  //   });
  // }

  // _onEndScroll(ScrollMetrics metrics) {
  //   setState(() {
  //     //print("Scroll end $metrics" );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // testing
    //_query();
    
                     _trackingScrollController.jumpTo((MediaQuery.of(context).size.width/2));

    return FutureBuilder(
        future: _query(),
        builder: (context, snapshot) {
          return Scaffold(
            
            appBar: AppBar(
              //leading: Icon(Icons.accessibility_new),
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: chipCat),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   mainAxisSize: MainAxisSize.max,
                  //   children:
                  //      chipWeather
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      new Center(
                        child: new Container(
                          width: MediaQuery.of(context).size.height * 0.5294,
                          color: Colors.green,
                          // height: MediaQuery.of(context).size.height * 0.765,//with second chip row
                          height: MediaQuery.of(context).size.height * 0.822,//without second chip row
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: catList.length,
                              itemBuilder: (context, index) {
                                return !prefListCat
                                        .contains(catList[index].text)
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: Card(
                                          //color: Colors.red,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            color: Colors.blue,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.2,//size of
                                            child: Center(
                                              child: 
                                              
// NotificationListener<ScrollNotification>(
//               onNotification: (scrollNotification) {
//                 if (scrollNotification is ScrollStartNotification) {
//                   _onStartScroll(scrollNotification.metrics);
//                 } else if (scrollNotification is ScrollUpdateNotification) {
//                   _onUpdateScroll(scrollNotification.metrics);
//                 } else if (scrollNotification is ScrollEndNotification) {
//                   _onEndScroll(scrollNotification.metrics);
//                  // debugPrint('end scroll ${scrollNotification.metrics.pixels}');
//                   //scrollNotification.context.size = end scroll Size(424.0, 81.6)
                  
//                 }
//                 return false;
//               },
// child:
                                              ListView.builder(
                                                controller: _trackingScrollController,
                                               // controller: _controller,
                                                shrinkWrap: true,
                                                        physics: PageScrollPhysics(),//stepping through the scroll 
                                                  // physics: ScrollPhysics(),   
                                                          
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: dbMap.length,
                                                 
                                                  itemBuilder: (context, ind) {
                                                    return catList[index]
                                                                .text ==
                                                            dbMap[ind]['cat']
                                                        //&& !prefListweather.contains(weatherList.toString())
                                                        ? Container(
                                                            // width: MediaQuery.of(
                                                            //             context)
                                                            //         .size
                                                            //         .width *
                                                            //     0.5,
                                                           width: (MediaQuery.of(context).size.width/1.019),///3,//remove three card will fill
                                                            child: Card(
                                                              color: Colors.amber,
                                                              child: ListTile(
                                                                title: '${dbMap[ind]['pic'].toString()}' !=
                                                                            "" ||
                                                                        '${dbMap[ind]['pic'].toString()}' !=
                                                                            null
                                                                    ? Image.file(
                                                                        new File(
                                                                            '${dbMap[ind]['pic'].toString().substring(6).replaceAll("'", "")}'),height: MediaQuery.of(context).size.height *0.18,)
                                                                    : CircleAvatar(
                                                                        child: Icon(
                                                                            Icons.accessibility)),
                                                                leading: Text(
                                                                    '${dbMap[ind]['name'].toString()}',textAlign: TextAlign.center,),
                                                               trailing: Text(
                                                                   '${dbMap[ind]['size'].toString()} \n${dbMap[ind]['fit'].toString()}'),
                                                              ),
                                                            ),
                                                          )
                                                        : Container();
                                                  }),
                                            //),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container();
                              }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
