// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class ThemeController extends GetxController {
//   // Define the light and dark themes
//   // ThemeData lightTheme = ThemeData(brightness: Brightness.light);
//   // ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
//
//   ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.black),
//       displayLarge: TextStyle(color: Colors.black),
//       // Add more text styles as needed
//     ),
//   );
//
//   ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     textTheme: TextTheme(
//       bodyLarge: TextStyle(color: Colors.white),
//       displayLarge: TextStyle(color: Colors.white),
//       // Add more text styles as needed
//     ),
//   );
//
//   var isDarkMode=false.obs;
//
//   // Toggle between light and dark themes
//
//   void toggleTheme() {
//     isDarkMode.value=!isDarkMode.value;
//     if (Get.isDarkMode) {
//       Get.changeTheme(lightTheme);
//     } else {
//       Get.changeTheme(darkTheme);
//     }
//     saveThemeToPreferences();
//   }
//
//   // Save the theme mode to shared preferences
//   void saveThemeToPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool('isDarkMode', isDarkMode.value);
//   }
//
//   // Load the theme mode from shared preferences
//   void loadThemeFromPreferences() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
//     if (isDarkMode.value) {
//       Get.changeTheme(darkTheme);
//     } else {
//       Get.changeTheme(lightTheme);
//     }
//   }
//
//
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/palette.dart';

class ThemeController extends GetxController {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white, // Add this line
    secondaryHeaderColor:  Palette.backgroundColor,

    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      displayLarge: TextStyle(color: Colors.black26),
      // Add more text styles as needed
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black45, // Add this line
    secondaryHeaderColor:  Colors.grey[600],



    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      displayLarge: TextStyle(color: Colors.white),
      // Add more text styles as needed
    ),
  );

  var isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
    saveThemeToPreferences();
  }

  void saveThemeToPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', isDarkMode.value);
  }

  void loadThemeFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode.value) {
      Get.changeTheme(darkTheme);
    } else {
      Get.changeTheme(lightTheme);
    }
  }
}
