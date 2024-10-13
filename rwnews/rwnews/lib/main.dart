import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/detail_binding.dart';
import 'routes/routes.dart';
import 'view_models/theme_view_model.dart';

void main() async {
  runApp(MainPage());
}

class MainPage extends StatelessWidget {
  final ThemeViewModel _themeViewModel = Get.put(ThemeViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RWNews',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: _themeViewModel.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
        initialBinding: DetailBinding(),
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
      );
    });
  }
}