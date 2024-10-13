import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_models/theme_view_model.dart';
import 'add_edit_news_screen.dart';
import 'home_screen.dart';
import 'setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var themeViewModel = Get.find<ThemeViewModel>();
  final _selectedIndex = ValueNotifier<int>(0);

  List<Widget> get _pages {
    List<Widget> pages = [
      HomeScreen(),
      SettingScreen(),
    ];
    return pages;
  }

  List<BottomNavigationBarItem> get _bottomNavItems {
    List<BottomNavigationBarItem> items = [
      const BottomNavigationBarItem(
        label: 'Home',
        icon: Icon(Icons.home),
      ),
      const BottomNavigationBarItem(
        label: 'Inbox',
        icon: Icon(Icons.inbox),
      ),
    ];
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return themeViewModel.isDarkTheme.value
              ? Image.asset('assets/images/logo.png', height: 30)
              : Image.asset('assets/images/logo_dark.png', height: 30);
        }),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddEditNewsScreen());
            },
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: _selectedIndex,
            builder: (context, index, child) {
              return IndexedStack(
                index: index,
                children: _pages,
              );
            }),
      ),
      bottomNavigationBar: ValueListenableBuilder(
          valueListenable: _selectedIndex,
          builder: (context, index, child) {
            return BottomNavigationBar(
              currentIndex: index,
              onTap: (index) {
                _selectedIndex.value = index;
              },
              items: _bottomNavItems,
              selectedItemColor: const Color(0xFF8D7D70),
              unselectedItemColor: const Color(0xFF8D7D70),
            );
          }),
    );
  }
}