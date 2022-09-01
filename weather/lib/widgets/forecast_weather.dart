import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/main_page.dart';
import 'package:weather/screens/search_screen.dart';
import 'package:weather/widgets/weather_screen.dart';
import 'package:weather/models/forecast.dart';

// ignore: must_be_immutable
class ForecastCard extends StatefulWidget {
  ForecastCard({required this.future, Key? key}) : super(key: key);
  Future<Forecast> future;

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  //formate the time like this => 12:00 am
  var dateFormat = DateFormat('hh:mm a');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data;
          return Flexible(
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.1),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SlideInDown(
                            child: Image.asset(
                              CurrentLocationWeather.weatherImage(
                                  data!.list[index].weather.first.id),
                              height: 50,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            dateFormat
                                .format(data.list[index].dtTxt)
                                .toLowerCase(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              '${data.list[index].main.temp.toStringAsFixed(0)}°',
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        } else if (snapshot.hasError) {
          if (SearchScreen.isQuerySearch) {
            return Padding(
              padding: const EdgeInsets.only(top: 500),
              child: Center(
                child: Column(
                  children: [
                    const Text('Please enter the city name correctly'),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          SearchScreen.isQuerySearch = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPage()));
                      },
                      child: const Text(
                        'my location weather',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }
        // return nothing
        return const Center();
      },
    );
  }
}
