import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_app_agumentik/UI/splash_screen.dart';
import 'Style/Theme/theme_class.dart';
import 'Style/Theme/themes.dart';
import 'UI/homeScreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    darkTheme: darkTheme,
    theme: lightTheme,
    themeMode: ThemeServices().theme,
    home: SplashScreen(),
    getPages: [
      GetPage(name: '/home', page: () => HomeScreen()),

    ],
  ));
}
