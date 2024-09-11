import 'package:build_app_flutter/pages/about_screen.dart';
import 'package:build_app_flutter/pages/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    AboutScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Lato',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Lato',
      ),
      home: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'About',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepPurple,
          onTap: _onItemTapped,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleTheme,
          child: _themeMode == ThemeMode.light
              ? Transform.rotate(
                  angle: 4.0, // 90 degrees in radians
                  child: Icon(Icons.nightlight_outlined),
                )
              : Icon(Icons.wb_sunny),
        ),
      ),
    );
  }
}
