import 'package:flutter/material.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:weather/widgets/forecast_weather.dart';
import 'package:weather/widgets/weather_screen.dart';
import 'package:weather/models/current_weather.dart';
import 'package:weather/screens/search_screen.dart';
import 'package:weather/services/weather.dart';
import '../models/forecast.dart';
import '../services/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<CurrentWeather> weatherFuture = cityWeather(''); //for error handling
  Future<Forecast> forecastFuture = cityForecast(''); //for error handling
  Location location = Location();
  double lat = 51.4215;
  double lon = 35.6944;
  @override
  void initState() {
    // if Searching
    if (SearchScreen.isQuerySearch && SearchScreen.controller.text.isNotEmpty) {
      weatherFuture = cityWeather(SearchScreen.controller.text);
      forecastFuture = cityForecast(SearchScreen.controller.text);
    } else {
      getData();
    }
    super.initState();
  }

  getData() async {
    await location.getCurrentLocation().then((v) {
      setState(() {
        lat = location.latitude!;
        lon = location.longitude!;
        weatherFuture = currentLocationWeather(latitude: lat, longitude: lon);
        forecastFuture = currentLocationForecast(lat: lat, lon: lon);
      });
    });
  }

  Icon themeModeIcon() {
    return ThemeProvider.controllerOf(context).currentThemeId == 'dark_theme'
        ? const Icon(Icons.sunny)
        : const Icon(Icons.nights_stay);
  }

  bool isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              //world map image
              'assets/kindpng_2812855.png',
              height: 500,
              color: Colors.grey.withOpacity(.3),
            ),
          ),
          SafeArea(
              child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: IconButton(
                        onPressed: () {
                          isDarkMode = !isDarkMode;
                          //changing the theme
                          ThemeProvider.controllerOf(context).nextTheme();
                        },
                        icon: themeModeIcon(),
                      )))),
          Column(
            children: [
              CurrentLocationWeather(
                future: weatherFuture,
              ),
              ForecastCard(
                future: forecastFuture,
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    Future.delayed(Duration.zero, () {
      SearchScreen.controller.clear();
      SearchScreen.isQuerySearch = false;
    });
    super.dispose();
  }
}
