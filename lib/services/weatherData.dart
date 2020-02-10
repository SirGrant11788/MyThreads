import 'package:weather/weather.dart';


Future<String>loadWeatherToday(weatherToday) async {
WeatherStation weatherStation = new WeatherStation("996cc4f3b136aea607960591dd64e7a5");
Weather weather = (await weatherStation.currentWeather());
weatherToday= '${weather.weatherMain} ${weather.tempMin.celsius.round()}°C/${weather.tempMax.celsius.round()}°C';
return weatherToday;
}


