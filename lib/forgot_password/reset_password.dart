import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_event_app/LoginSignup.dart';
import 'package:new_event_app/config/palette.dart';
import 'package:new_event_app/forgot_password/forgot_password_controller.dart';
import 'package:new_event_app/forgot_password/success_reset_password.dart';
import 'package:new_event_app/forgot_password/verify_code.dart';

import 'package:http/http.dart' as http;

class ResetPassword extends StatefulWidget {
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  GlobalKey<FormState> formStatePassword = GlobalKey();
  TextEditingController email3 = TextEditingController();
  TextEditingController password3 = TextEditingController();
  TextEditingController rePassword = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    password3.dispose();
    email3.dispose();
    super.dispose();
  }

  Future<void> postDataResetPassword() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/reset_password'));
    request.fields.addAll({
      'newPassword': password3.text,
      'email': Email.email,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => SuccessResePassword(),
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
          'Reset password',
          style: TextStyle(
              color: const Color.fromARGB(214, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: formStatePassword,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'New Password',
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
                'Please Enter New Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(203, 44, 43, 43),
                    fontWeight: FontWeight.w400,
                    fontSize: 15),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: TextFormField(
              //     keyboardType: TextInputType.emailAddress,
              //     controller: email3,
              //     onChanged: (value) {
              //       setState(() {
              //         email3.text = value;
              //       });
              //     },
              //     validator: (val) {
              //       if (val!.isEmpty) {
              //         return "The Field is empty".tr;
              //       }
              //       if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
              //           .hasMatch(val)) {
              //         return "Must be a valid email address".tr;
              //       }
              //       return null;
              //     },
              //     decoration: InputDecoration(
              //       prefixIcon: Icon(
              //         Icons.email,
              //         color: Colors.indigo,
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Palette.textColor1),
              //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Palette.textColor1),
              //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
              //       ),
              //       contentPadding: EdgeInsets.all(10),
              //       hintText: "Enter Your Email".tr,
              //       hintStyle: TextStyle(
              //           fontSize: 14,
              //           color: Theme.of(context).textTheme.bodyLarge!.color),
              //     ),
              //     style: TextStyle(
              //         color: Theme.of(context).textTheme.bodyLarge!.color),
              //   ),
              // ),

              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: _obscureText,
                  controller: password3,
                  onChanged: (value) {
                    setState(() {
                      password3.text = value;
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
                    hintText: "Enter Your New Password",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color),
                ),
              ),
              // SizedBox(
              //   height: 15,
              // ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 25),
              //   child: TextFormField(
              //     keyboardType: TextInputType.text,
              //     obscureText: _obscureText,
              //     controller: rePassword,
              //     onChanged: (value) {
              //       setState(() {
              //         rePassword.text = value;
              //       });
              //     },
              //     validator: (val) {
              //       if (val!.isEmpty) {
              //         return "The Field is empty".tr;
              //       }
              //       if (val.length < 5) {
              //         return "must be at least 5 elements".tr;
              //       }
              //     },
              //     decoration: InputDecoration(
              //       suffixIconColor: Colors.indigo,
              //       suffixIcon: IconButton(
              //         onPressed: () {
              //           setState(() {
              //             _obscureText = !_obscureText;
              //           });
              //         },
              //         icon: _obscureText
              //             ? Icon(Icons.visibility)
              //             : Icon(Icons.visibility_off),
              //       ),
              //       prefixIcon: Icon(
              //         Icons.lock,
              //         color: Colors.indigo,
              //       ),
              //       enabledBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Palette.textColor1),
              //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //         borderSide: BorderSide(color: Palette.textColor1),
              //         borderRadius: BorderRadius.all(Radius.circular(35.0)),
              //       ),
              //       contentPadding: EdgeInsets.all(10),
              //       hintText: "Re Enter You Password",
              //       hintStyle: TextStyle(
              //           fontSize: 14,
              //           color: Theme.of(context).textTheme.bodyLarge!.color),
              //     ),
              //     style: TextStyle(
              //         color: Theme.of(context).textTheme.bodyLarge!.color),
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0)),
                onPressed: () async {
                  if (formStatePassword.currentState!.validate()) {
                    // validation successful, submit the form
                    postDataResetPassword();
                  }
                },
                child: Text(
                  "save",
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
