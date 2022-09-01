import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:weather/models/current_weather.dart';
import 'package:weather/models/forecast.dart';

class API {
  String url;
  final bool isforecast;
  API({required this.url, required this.isforecast});
  Future getData() async {
    final response = //timeout error
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 6));
    // if succeed
    if (response.statusCode == 200) {
      return isforecast
          ? forecastFromJson(response.body)
          : currentWeatherFromJson(response.body);
    } else {
      throw TimeoutException('Failed to load');
    }
  }
}
