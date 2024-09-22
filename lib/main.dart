import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:new_event_app/firebase_options.dart';
import 'package:new_event_app/party_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Halls_iteminfo.dart';
import 'LoginSignup.dart';
import 'Theme/themecontroller.dart';
import 'locale/locale.dart';
import 'locale/locale_controller.dart';
import 'welcome.dart';

SharedPreferences? sharedpref;


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //sharedpreferences
  await Firebase.initializeApp();

//  requestNotificationPremission();

// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  sharedpref = await SharedPreferences.getInstance(); //sharedpreferences
  // Get.put(MyLocaleController());
  Get.put(ThemeController());
  // Get.put(RememberMeController());

  // bool isLoggedIn = sharedpref?.getBool('isLoggedIn') ?? false;

  runApp(MyApp());
  // isLoggedIn: isLoggedIn
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final bool isLoggedIn;

  // MyApp({required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    MyLocaleController controller = Get.put(MyLocaleController());

    return GetMaterialApp(
      theme: Get.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      // initialRoute: isLoggedIn ? '/party_type' : '/welcome',
      // locale: Get.deviceLocale,
      locale: controller.initialLocale,
      translations: MyLocale(),
      getPages: [
        GetPage(name: "/", page: () => Welcome()),
        // GetPage(name: '/party_type', page: () => Party_Type()),

        // isLoggedIn ? Party_Type() : Welcome()
      ],
      debugShowCheckedModeBanner: false,
      // home: Welcome()
    );
  }
}
