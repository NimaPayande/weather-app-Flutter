import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:weather/screens/home_screen.dart';
import 'package:weather/screens/search_screen.dart';

//* Bottom Navigation manager
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List screens = [const HomeScreen(), const SearchScreen()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.home),
                activeIcon: Icon(IconlyBold.home),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(IconlyLight.search),
                activeIcon: Icon(IconlyBold.search),
                label: 'search')
          ]),
    );
  }
}
