import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_models/theme_view_model.dart';

class SettingScreen extends StatelessWidget {
  final ThemeViewModel _themeViewModel = Get.find<ThemeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Theme app',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Obx(() {
                      return Switch(
                        value: _themeViewModel.isDarkTheme.value,
                        onChanged: (value) {
                          _themeViewModel.toggleTheme();
                        },
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}