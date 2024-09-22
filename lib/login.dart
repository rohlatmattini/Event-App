// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
//
// class Login extends StatefulWidget {
//     State<Login>createState()=>Login1();
// }
// class Login1 extends State<Login>{
//
//   TextEditingController email_phone=TextEditingController();
//   TextEditingController password=TextEditingController();
//
//   GlobalKey<FormState> formstate=GlobalKey();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height,
//           decoration: BoxDecoration(
//               gradient: LinearGradient(begin: Alignment.topCenter, colors: [
//                 Colors.purple.shade300,
//                 Colors.purple.shade600,
//                 Colors.purple.shade900
//           ])),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     FadeInUp(
//                         duration: Duration(milliseconds: 1000),
//                         child: Text(
//                           "Login",
//                           style: TextStyle(color: Colors.white, fontSize: 40,fontFamily: "Hurricane"),
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     FadeInUp(
//                         duration: Duration(milliseconds: 1300),
//                         child: Text(
//                           "Welcome Back",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(60),
//                           topRight: Radius.circular(60))),
//                   child: Padding(
//                     padding: EdgeInsets.all(30),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 60,
//                         ),
//                         FadeInUp(
//                             duration: Duration(milliseconds: 1400),
//
//                             child: Container(
//                               decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow: [
//                                     BoxShadow(
//                                         color: Colors.purple.shade200,
//                                         blurRadius: 20,
//                                         offset: Offset(0, 10))
//                                   ]),
//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             bottom: BorderSide(
//                                                 color: Colors.grey.shade200))),
//                                     child: Form(
//                                       key: formstate,
//                                       child:Column(children: [
//                                           TextFormField(
//                                           validator: (value){
//                                     if(value!.isEmpty){
//                                     return"the field is empty";
//                                     }},
//                                       controller: email_phone,
//                                       decoration: InputDecoration(
//                                           prefixIcon: Icon(Icons.email),
//                                           prefixIconColor: Colors.purple,
//                                           hintText: "Email or Phone number",
//                                           hintStyle:
//                                           TextStyle(color: Colors.grey),
//                                           border: InputBorder.none),
//                                     ),
//
//
//
//                                   Container(
//                                     padding: EdgeInsets.all(5),
//                                     decoration: BoxDecoration(
//                                         border: Border(
//                                             bottom: BorderSide(
//                                                 color: Colors.grey.shade200))),),
//
//
//
//                                      TextFormField(
//                                       validator: (value){
//                                         if(value!.isEmpty){
//                                           return"the field is empty";
//                                         }
//                                         if(value.length<=5){
//                                           return"must be more than 5";
//                                         }
//                                       },
//                                       controller: password,
//                                       obscureText: true,
//                                       decoration: InputDecoration(
//                                           prefixIcon: Icon(Icons.lock),
//                                           prefixIconColor: Colors.purple,
//                                           hintText: "Password",
//                                           hintStyle:
//                                           TextStyle(color: Colors.grey),
//                                           border: InputBorder.none),
//                                     ),
//
//                                       ],)
//                                   ),
//                                  )
//                                 ],
//                               ),
//                             )),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         FadeInUp(
//                             duration: Duration(milliseconds: 1500),
//                             child: Text(
//                               "Forgot Password?",
//                               style: TextStyle(color: Colors.grey),
//                             )),
//                         SizedBox(
//                           height: 40,
//                         ),
//                         FadeInUp(
//                             duration: Duration(milliseconds: 1600),
//                             child: MaterialButton(
//                               onPressed: () {
//                                 if(formstate.currentState!.validate()){
//                                 }
//                               },
//                               height: 50,
//                               // margin: EdgeInsets.symmetric(horizontal: 50),
//                               color: Colors.purple[400],
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               // decoration: BoxDecoration(
//                               // ),
//                               child: Center(
//                                 child: Text(
//                                   "Login",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             )),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         // FadeInUp(
//                         //     duration: Duration(milliseconds: 1700),
//                         //     child: Text(
//                         //       "Continue with social media",
//                         //       style: TextStyle(color: Colors.grey),
//                         //     )),
//                         // SizedBox(
//                         //   height: 30,
//                         // ),
//                         // Row(
//                         //   children: <Widget>[
//                         //     Expanded(
//                         //       child: FadeInUp(
//                         //           duration: Duration(milliseconds: 1800),
//                         //           child: MaterialButton(
//                         //             onPressed: () {},
//                         //             height: 50,
//                         //             color: Colors.blue,
//                         //             shape: RoundedRectangleBorder(
//                         //               borderRadius: BorderRadius.circular(50),
//                         //             ),
//                         //             child: Center(
//                         //               child: Text(
//                         //                 "Facebook",
//                         //                 style: TextStyle(
//                         //                     color: Colors.white,
//                         //                     fontWeight: FontWeight.bold),
//                         //               ),
//                         //             ),
//                         //           )),
//                         //     ),
//                         //     SizedBox(
//                         //       width: 30,
//                         //     ),
//                         //     Expanded(
//                         //       child: FadeInUp(
//                         //           duration: Duration(milliseconds: 1900),
//                         //           child: MaterialButton(
//                         //             onPressed: () {},
//                         //             height: 50,
//                         //             shape: RoundedRectangleBorder(
//                         //               borderRadius: BorderRadius.circular(50),
//                         //             ),
//                         //             color: Colors.black,
//                         //             child: Center(
//                         //               child: Text(
//                         //                 "Github",
//                         //                 style: TextStyle(
//                         //                     color: Colors.white,
//                         //                     fontWeight: FontWeight.bold),
//                         //               ),
//                         //             ),
//                         //           )),
//                         //     )
//                        //   ],
//                        // )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
