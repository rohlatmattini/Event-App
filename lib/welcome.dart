import 'dart:convert';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_event_app/party_type.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import 'LoginSignup.dart';
import 'Token.dart';

class Welcome extends StatefulWidget {
  State<Welcome> createState() => Welcome1();
}

class Welcome1 extends State<Welcome> {
  GlobalKey<FormState> formState1 = GlobalKey();
  GlobalKey<FormState> formState2 = GlobalKey();
  TextEditingController email1 = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email2 = TextEditingController();
  TextEditingController password1 = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController User_Name = TextEditingController();
  bool isRememberMe = false;
  final colorizeColors = [
    Colors.white,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
  }

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
  //api for signup
  Future<void> postData1() async {
    var headers = {
      'Cookie':
      'XSRF-TOKEN=eyJpdiI6ImJQQ1JVOUpKRlA5cFNqUzExeGdwbkE9PSIsInZhbHVlIjoiRSt5TUtXSVdqQklwODBSUXoyZmREUGRIMlBaK21RNEViMnB0VVZCUWxLWXE4YWFIZGQ0V1IyRDVDTUpBK3EyWkJBcWVQcjcrdFhwNUJob3VaUFJvRnk0RFh6VjdhSWROSkwwMktiMzFPUE5vU3Zzc29oQ1BYcmRXZVBnTHNjQTQiLCJtYWMiOiJlYzkwODIwYTJmMGMyYzk2OWE2Yzk1ZTRlMWMyNGM2MWE5OWRlZjZlOTgzOGM1OTI5YTMwZmEwYmM5ZmMxMzdmIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IkhoQkp1UzJ4U1QyL2lFQ0hCcENWR0E9PSIsInZhbHVlIjoiVGMrSTFlRjB4aSt3SER3UkUvTHlQQ1JJVDFZT1E1VDNnUFZrMWd1Q1Z1QmZoOHBBa3BsUC81OHNPUHZVekJPcWtBTk5pMUhxRndOUHdSSnhHUUx0N2ZVNXpmRitSWEdDdXNmclNxMXAzZXBPU01rTVlhWHYyc0U3VGFSRXNUTHQiLCJtYWMiOiIxMzRiZTNiY2E5ZGQ0ZjFmNmJkYWI3NDYwM2RmNzIzNzg5ZTU1NjU0ZDg0MTU5ZDlkNTY1YzE4YWYzMTA5OWFlIiwidGFnIjoiIn0%3D'
    };

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
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Party_Type()));
    } else {
      print(request.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.indigo,
        content: Text("Your Password or Email is incorrect".tr),
        duration: Duration(seconds: 3),
      ));
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
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("image/welcome.png"), fit: BoxFit.cover),
        ),
        child: Container(
            decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.6),
            Colors.black.withOpacity(.8),
            Colors.black.withOpacity(.3),
          ]),
        ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20,top: 220),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ColorizeAnimatedText(
                        'Event App',
                        textStyle:TextStyle(color: Colors.white,fontSize: 60,fontWeight: FontWeight.bold) ,
                        colors: colorizeColors,
                      ),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),


              SizedBox(height:225),

              Padding(
                  padding:EdgeInsets.all(30),
              child:  MaterialButton(
                height: 45,
                minWidth: 300,
                shape: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginSignupScreen()));
                },
                child:  Text("Let's start ".tr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
              ),

              
              ],
            ),
          )

        )


          ),

    );
  }
}
