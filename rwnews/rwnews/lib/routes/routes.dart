import 'package:flutter/material.dart';

import '../views/main_page.dart';

class AppRoutes{
  static const String home = '/';
  static const String add_news = '/add-news';
  static const String detail = '/detail';

  static Map<String, WidgetBuilder> routes ={
    home: (context) => const MainScreen(),
  };

}