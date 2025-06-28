import 'package:flutter/material.dart';
import 'homepage.dart'; // Your HomePage content (with API calls, etc.)
import 'top_gainers_page.dart'; // Top Gainers page
import 'top_losers_page.dart'; // Top Losers page
import 'top_trending_page.dart'; // Top Trending page
import '../models/crypto.dart';

// import 'package:flutter/services.dart';

List<Crypto> cryptoList = [];

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    TopGainersPage(),
    TopLosersPage(),
    TopTrendingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF021F37),
        ),
        child: SafeArea(
          top: false,
          child: ClipRRect(
            // borderRadius: const BorderRadius.only(
            //   topLeft: Radius.circular(20),
            //   topRight: Radius.circular(20),
            // ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color(0xFF021F37),
              currentIndex: _selectedIndex,
              selectedItemColor: const Color(0xFF71EEA1),
              unselectedItemColor: Colors.blueGrey,
              selectedFontSize: 12,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
              onTap: _onItemTapped,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_up_rounded),
                  label: 'Top Gainers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trending_down_rounded),
                  label: 'Top Losers',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: 'Trending',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
