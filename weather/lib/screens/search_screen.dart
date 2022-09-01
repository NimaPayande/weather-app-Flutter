import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/main_page.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static bool isQuerySearch = false;
  static final controller = TextEditingController();
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for city'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                //world map image
                'assets/kindpng_2812855.png',
                color: Colors.grey.withOpacity(.3),
              ),
            ),
            Center(
              child: ClipRect(
                // for background blur
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: TextField(
                    controller: SearchScreen.controller,
                    decoration: InputDecoration(
                        hintText: 'city name...',
                        filled: true,
                        fillColor: Colors.grey.withOpacity(.2),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30))),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Center(
                child: ElevatedButton(
                  onPressed: (() {
                    setState(() {
                      SearchScreen.isQuerySearch = true;
                    });
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainPage(),
                        ));
                  }),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
