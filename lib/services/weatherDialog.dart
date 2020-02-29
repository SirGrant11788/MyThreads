import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather/weather.dart';

List weather = List();

 showDialogWeather(BuildContext context) {
    
     showDialog(
    context: context,
    builder: (context) {
      return 
      FutureBuilder(
    future: weatherReport(),
  builder: (context, snapshot) { return
      AlertDialog(
        backgroundColor: Colors.blueGrey[100],
        scrollable: true,
        title: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.blue)),
              child: weather==null?
              CircularProgressIndicator()
              :
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
    new TextSpan(text: '${weather}', style: new TextStyle(fontSize: 16.0, color: Colors.black,) ),

                  ],
                ),
                textAlign:
                                                                            TextAlign.center,
                                                                        softWrap:
                                                                            true,
              ),
            ),
          ],
        ),
      );
    },
  );
  },
  );
}

Future weatherReport() async {
  WeatherStation weatherStation =
    new WeatherStation("996cc4f3b136aea607960591dd64e7a5");
    weather.clear();
 weather = (await weatherStation.fiveDayForecast());
//print(weather);
  // String weatherToday = "MyThreads";
  // if ('${weather.weatherMain}' != null &&
  //     '${weather.tempMin.celsius.round()}' != null &&
  //     '${weather.tempMax.celsius.round()}' != null) {
  //   weatherToday =
  //       '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
  // }
  // String weatherIcon = '';
  // if ('${weather.weatherIcon}' != null) {
  //   weatherIcon = weather.weatherIcon;
  // }
  
}