import 'package:weather/models/current_weather.dart';
import 'package:weather/models/forecast.dart';
import 'package:weather/services/api.dart';

const apiKey = '51cb0eb01768fc94ee0cc1baf2488a4c';
// get your apiKey: https://openweathermap.org/
const weatherUrl = 'http://api.openweathermap.org/data/2.5/weather';
const forecastUrl = 'https://api.openweathermap.org/data/2.5/forecast';

Future<CurrentWeather> currentLocationWeather(
    {required double latitude, required double longitude}) async {
  String url =
      '$weatherUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: false);
  return await api.getData();
}

Future<Forecast> currentLocationForecast(
    {required double lat, required double lon}) async {
  String url = '$forecastUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: true);
  return await api.getData();
}

Future<CurrentWeather> cityWeather(String city) async {
  String url = '$weatherUrl?q=$city&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: false);
  return await api.getData();
}

Future<Forecast> cityForecast(String city) async {
  String url = '$forecastUrl?q=$city&appid=$apiKey&units=metric';
  API api = API(url: url, isforecast: true);
  return await api.getData();
}
