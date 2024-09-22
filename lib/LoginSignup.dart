import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis/chat/v1.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/Navo.dart';
import 'package:new_event_app/forgot_password/forgot_password.dart';
import 'package:new_event_app/main.dart';
import 'package:new_event_app/notification/noti.dart';
import 'package:new_event_app/party_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Term&Condition.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';
import 'config/palette.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  void initState() {
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  bool isSignupScreen = true;
  bool isRememberMe = false;
  bool _obscureText = true;
  String? verification_code;
  GlobalKey<FormState> formState1 = GlobalKey();
  GlobalKey<FormState> formState2 = GlobalKey();
  TextEditingController email1 = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController User_Name = TextEditingController();
  TextEditingController code1 = TextEditingController();
  TextEditingController code2 = TextEditingController();
  TextEditingController code3 = TextEditingController();
  TextEditingController code4 = TextEditingController();
  TextEditingController code5 = TextEditingController();

  // Save email and password
  void _handleRememberMe(bool value) {
    setState(() {
      isRememberMe = value;
    });

    if (isRememberMe) {
      _saveUserEmailPassword();
    } else {
      _removeUserEmailPassword();
    }
  }

  // Save user email and password
  Future<void> _saveUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email1.text);
    prefs.setString('password', password1.text);
    prefs.setBool('isRememberMe', isRememberMe);
  }

  // Load user email and password
  Future<void> _loadUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email1.text = (prefs.getString('email') ?? "");
      password1.text = (prefs.getString('password') ?? "");
      isRememberMe = (prefs.getBool('isRememberMe') ?? false);
    });
    if (isRememberMe && email1.text.isNotEmpty && password1.text.isNotEmpty) {
      // Auto-login if the user has chosen to be remembered
      postData2();
    }
  }

  // Remove user email and password
  Future<void> _removeUserEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('email');
    prefs.remove('password');
    prefs.remove('isRememberMe');
  }

  //Send the email
  sendEmail() async {
    var request = await http.post(
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/send_code2'),
        body: {
          'email': email2.text,
        });

    if (request.statusCode == 200) {
      verification_code =
          json.decode(request.body)['verification_code'].toString();
    } else {
      print(request.reasonPhrase);
    }
  }


  //api for signup
  Future<void> postData1() async {

    var request = await http.post(
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/register'),
        body: {
          'name': User_Name.text,
          'mobile_number': phone.text,
          'email': email2.text,
          'password': password2.text,
          'role': "client"
        });

    if (request.statusCode == 200) {
      final toke = json.decode(request.body)['token'];
      print(toke);
      Token.storeToken(toke);
      Noti.showBigTextNotification(
          title: 'Signed Up',
          body: 'You have been sign up successfuly',
          fln: flutterLocalNotificationsPlugin);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Party_Type()));
    } else {
      print(request.reasonPhrase);
    }
  }

  //api for login
  postData2() async {
    var request = await http.post(
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/login'),
        body: {
          'email': email1.text,
          'password': password1.text,
          'role': 'client'
        });

    if (request.statusCode == 200) {
      final toke = json.decode(request.body)['token'];
      print(toke);
      Token.storeToken(toke);
      Noti.showBigTextNotification(
          title: 'Signed Up',
          body: 'You have been sign up successfuly',
          fln: flutterLocalNotificationsPlugin);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Party_Type()));
    } else {
      print(request.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.indigo,
        content: Text("Your Password or Email is incorrect".tr),
        duration: Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Scaffold(
      // backgroundColor: Palette.backgroundColor,
      backgroundColor: themeController.isDarkMode.value
          ? themeController.darkTheme.secondaryHeaderColor
          : themeController.lightTheme.secondaryHeaderColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("image/background.jpg"),
                      fit: BoxFit.fill)),
              child: Container(
                padding: EdgeInsets.only(top: 195, left: 10),
                color: Colors.black.withOpacity(.30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        isSignupScreen
                            ? "Signup to Continue".tr
                            : "Signin to Continue".tr,
                        style: TextStyle(
                          fontSize: 20,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the shadow for the submit button
          //buildBottomHalfContainer(true),
          //Main Contianer for Login and Signup
          AnimatedPositioned(
            duration: Duration(milliseconds: 650),
            // curve: Curves.bounceInOut,
            top: isSignupScreen ? 250 : 250,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 650),
              curve: Curves.bounceInOut,
              height: isSignupScreen ? 380 : 250,
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: themeController.isDarkMode.value
                      ? themeController.darkTheme.primaryColor
                      : themeController.lightTheme.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.indigo.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 15),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSignupScreen = false;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "LOGIN".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: !isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (!isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.pink,
                                )
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSignupScreen = true;
                            });
                          },
                          child: Column(
                            children: [
                              Text(
                                "SIGNUP".tr,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSignupScreen
                                        ? Palette.activeColor
                                        : Palette.textColor1),
                              ),
                              if (isSignupScreen)
                                Container(
                                  margin: EdgeInsets.only(top: 3),
                                  height: 2,
                                  width: 55,
                                  color: Colors.pink,
                                )
                            ],
                          ),
                        )
                      ],
                    ),
                    if (isSignupScreen) buildSignupSection(),
                    if (!isSignupScreen) buildSigninSection()
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button
          buildBottomHalfContainer(false),
          // Bottom buttons
          Positioned(
            top: MediaQuery.of(context).size.height - 100,
            right: 0,
            left: 0,
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }

  Container buildSigninSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: formState1,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email1,
              onChanged: (value) {
                setState(() {
                  email1.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(val)) {
                  return "Must be a valid email address".tr;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.indigo,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "email".tr,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              controller: password1,
              onChanged: (value) {
                setState(() {
                  password1.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (val.length < 5) {
                  return "must be at least 5 elements".tr;
                }
              },
              decoration: InputDecoration(
                suffixIconColor: Colors.indigo,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: _obscureText
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                ),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.indigo,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "******",
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRememberMe,
                      activeColor: Palette.textColor2,
                      onChanged: (value) => _handleRememberMe(value!),
                    ),
                    Text("Remember me".tr,
                        style:
                            TextStyle(fontSize: 12, color: Palette.textColor1))
                  ],
                ),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ForgotPassword();
                        },
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 10, bottom: 20),
                    alignment: Alignment.topRight,
                    child: const Text(
                      "Forgot password ?",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container buildSignupSection() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Form(
        key: formState2,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: User_Name,
              onChanged: (value) {
                setState(() {
                  User_Name.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (val.length < 2) {
                  return "must be at least 2 characters".tr;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.indigo,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "User Name".tr,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: phone,
              onChanged: (value) {
                setState(() {
                  phone.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (val.length != 10) {
                  return "must be 10 numbers".tr;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.indigo,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "phone".tr,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            SizedBox(
              height: 5,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email2,
              onChanged: (value) {
                setState(() {
                  email2.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                    .hasMatch(val)) {
                  return "Must be a valid email address".tr;
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.indigo),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "email".tr,
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.text,
              obscureText: _obscureText,
              controller: password2,
              onChanged: (value) {
                setState(() {
                  password2.text = value;
                });
              },
              validator: (val) {
                if (val!.isEmpty) {
                  return "The Field is empty".tr;
                }
                if (val.length < 5) {
                  return "must be at least 5 elements".tr;
                }
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.indigo,
                ),
                suffixIconColor: Colors.indigo,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    icon: Icon(_obscureText
                        ? Icons.visibility
                        : Icons.visibility_off)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.textColor1),
                  borderRadius: BorderRadius.all(Radius.circular(35.0)),
                ),
                contentPadding: EdgeInsets.all(10),
                hintText: "******",
                hintStyle: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyLarge!.color),
              ),
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "By pressing 'Submit' you agree to our ".tr,
                    style: TextStyle(color: Palette.textColor2),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    TermsAndConditionsScreen()));
                          },
                        text: " term & conditions".tr,
                        style: TextStyle(color: Colors.pink),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final ThemeController themeController = Get.find();

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      //curve: Curves.bounceInOut,
      top: isSignupScreen ? 580 : 450,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
            height: 90,
            width: 90,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: themeController.isDarkMode.value
                  ? themeController.darkTheme.primaryColor
                  : themeController.lightTheme.primaryColor,
              borderRadius: BorderRadius.circular(50),
            ),
            child: //!showShadow
                //?
                Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.pinkAccent, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(.3),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: MaterialButton(
                onPressed: () async {
                  if (isSignupScreen) {
                    if (formState2.currentState!.validate()) {
                      sendEmail();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // title: Icon(Icons.star_rate),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("verification code".tr,
                                      style: TextStyle(color: Colors.indigo)),
                                  SingleChildScrollView(
                                      child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Form(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: TextFormField(
                                                controller: code1,
                                                onChanged: (value) {
                                                  if (value.length == 1) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: TextFormField(
                                                controller: code2,
                                                onChanged: (value) {
                                                  if (value.length == 2) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: TextFormField(
                                                controller: code3,
                                                onChanged: (value) {
                                                  if (value.length == 3) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: TextFormField(
                                                controller: code4,
                                                onChanged: (value) {
                                                  if (value.length == 4) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            SizedBox(
                                              height: 35,
                                              width: 35,
                                              child: TextFormField(
                                                controller: code5,
                                                onChanged: (value) {
                                                  if (value.length == 5) {
                                                    FocusScope.of(context)
                                                        .nextFocus();
                                                  }
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.center,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      1),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly,
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "cancel".tr,
                                      style: TextStyle(color: Colors.indigo),
                                    )),
                                ElevatedButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      String code = code1.text +
                                          code2.text +
                                          code3.text +
                                          code4.text +
                                          code5.text;
                                      if (verification_code == code) {
                                        postData1();
                                      } else {
                                        print("code" + code);
                                        print(verification_code);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          backgroundColor: Colors.indigo,
                                          content: Text("User not found ".tr),
                                          duration: Duration(seconds: 2),
                                        ));
                                      }
                                    },
                                    child: Text("submit".tr,
                                        style: TextStyle(color: Colors.indigo)))
                              ],
                            );
                          });
                    }
                  }
                  else {
                    if (formState1.currentState!.validate()) {
                      // validation successful, submit the form
                      print("object");
                      postData2();
                    }
                  }
                },
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            )
            // : Center(),
            ),
      ),
    );
  }
}
