import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_event_app/LoginSignup.dart';

class SuccessResePassword extends StatelessWidget {
  const SuccessResePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        elevation: 0,
        title: Text(
          'Success',
          style: TextStyle(
              color: const Color.fromARGB(214, 255, 255, 255),
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Icon(
                Icons.check_circle_outline,
                size: 200,
                color: Colors.indigo,
              ),
            ),
             const SizedBox(
              height: 20,
            ),
            Text(
              'Password Changed Successfuly',
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
              'Please GO To Your Login Page And Try Your New Password',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(203, 44, 43, 43),
                  fontWeight: FontWeight.w400,
                  fontSize: 15),
            ),
                        SizedBox(
              height: 10,
            ),
            MaterialButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginSignupScreen();
                  }),
                );
              },
              child: Text(
                "Go To Login",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}
