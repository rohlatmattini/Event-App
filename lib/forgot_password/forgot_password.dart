import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_event_app/Token.dart';
import 'package:new_event_app/config/palette.dart';
import 'package:new_event_app/forgot_password/forgot_password_controller.dart';
import 'package:new_event_app/forgot_password/verify_code.dart';
import 'package:new_event_app/party_type.dart';

import 'package:http/http.dart' as http;

class ForgotPassword extends StatefulWidget {
  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formStateEmail = GlobalKey();
  TextEditingController email3 = TextEditingController();

  @override
  void dispose() {
    email3.dispose();
    super.dispose();
  }

  Future<void> postDataForgotPassword() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/send_code'));
    request.fields.addAll({
      'email': email3.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => VerifyCode(),
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(
          'Forgot password',
          style: TextStyle(
              color: const Color.fromARGB(214, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: formStateEmail,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Check Email',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                    fontSize: 40),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Please Enter Your Email To Recive A Verification Code!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(203, 44, 43, 43),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email3,
                  onChanged: (value) {
                    setState(() {
                      email3.text = value;
                      Email.email=email3.text;
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
                    hintText: "Enter Your Email".tr,
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                onPressed: () async {
                  if (formStateEmail.currentState!.validate()) {
                    // validation successful, submit the form
                    postDataForgotPassword();
                  }
                },
                child: Text(
                  "Check",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
