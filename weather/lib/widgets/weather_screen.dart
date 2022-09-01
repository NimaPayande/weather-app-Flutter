import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/models/current_weather.dart';

// ignore: must_be_immutable
class CurrentLocationWeather extends StatelessWidget {
  Future<CurrentWeather> future;
  CurrentLocationWeather({required this.future, Key? key}) : super(key: key);

  static String weatherImage(int condition) {
    // check weather id from the server and return the specific image
    late String assetImage;
    if (condition < 300) {
      if (condition < 210 || (condition > 230 && condition < 233)) {
        assetImage = 'assets/cloud/17.png';
      } else if (condition < 220) {
        assetImage = 'assets/cloud/12.png';
      }
    } else if (condition < 400) {
      assetImage = 'assets/cloud/7.png';
    } else if (condition < 600) {
      assetImage = 'assets/rain/39.png';
    } else if (condition < 700) {
      assetImage = 'assets/cloud/18.png';
    } else if (condition < 800) {
      if (condition == 781) {
        assetImage = 'assets/Tornado.png';
      }
      assetImage = 'assets/cloud/22.png';
    } else if (condition == 800) {
      assetImage = 'assets/sun/26.png';
    } else if (condition < 805) {
      assetImage = 'assets/cloud/35.png';
    }
    return assetImage;
  }

  // format the Date like this => 31,Aug,2022
  var dateFormat = DateFormat('dd,MMM,yyyy');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CurrentWeather>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        dateFormat.format(DateTime.now()),
                        style: const TextStyle(),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                          ),
                          Text(
                            '${snapshot.data!.name},',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!.sys.country,
                            style: const TextStyle(),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Column(
                      children: [
                        Swing(
                          child: Image.asset(
                            weatherImage(snapshot.data!.weather.first.id),
                            height: 150,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          snapshot.data!.weather.first.main,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            FadeInDown(
                              from: 20,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  snapshot.data!.main.temp.toStringAsFixed(0),
                                  style: const TextStyle(
                                      fontSize: 96,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 150, bottom: 30),
                              child: Text('°',
                                  style: TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 72,
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          // return nothing
          return const Center();
        }
        // return nothing
        return const Padding(
          padding: EdgeInsets.only(top: 400),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
