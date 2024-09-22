import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:new_event_app/config/palette.dart';
import 'package:new_event_app/forgot_password/forgot_password_controller.dart';
import 'package:new_event_app/forgot_password/reset_password.dart';
import 'package:new_event_app/forgot_password/verify_code.dart';

import 'package:http/http.dart' as http;

class VerifyCode extends StatefulWidget {
  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}
 

class _VerifyCodeState extends State<VerifyCode> {
  @override
  Widget build(BuildContext context) {
    // TextEditingController email1 = TextEditingController();

    // @override
    // void dispose() {
    //   // email1.dispose();
    //   super.dispose();
    // }

    Future<void> postDataVerfyCode(String verification_code) async {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/verify_email'));
      request.fields.addAll({
        'email': Email.email,
        'verification_code': verification_code,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ResetPassword(),
          ),
        );
      } else {
        print(response.reasonPhrase);
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(
          'Verify Code',
          style: TextStyle(
              color: const Color.fromARGB(214, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              'Check Code',
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
              'Please Enter The Digit Code Sent To ',
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
              child: OtpTextField(
                autoFocus: true,
                enabledBorderColor: Color.fromARGB(131, 44, 43, 43),
                focusedBorderColor: Colors.indigo,
                borderRadius: BorderRadius.circular(20),
                fieldWidth:40 ,
                numberOfFields: 5,
                borderColor: Color(0xFF512DA8),
                //set to true to show as box or false to show as dash
                showFieldAsBox: true,
                //runs when a code is typed in
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                //runs when every textfield is filled
                onSubmit: (String verificationCode) {
                  postDataVerfyCode(verificationCode);
                }, // end onSubmit
              ),
            ),
          ],
        ),
      ),
    );
  }
}
