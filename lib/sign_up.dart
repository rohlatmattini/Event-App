// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
//
// class Sign_up extends StatefulWidget {
//   State<Sign_up>createState()=>Sign_up1();
// }
// class Sign_up1 extends State<Sign_up>{
//
//   TextEditingController name=TextEditingController();
//   TextEditingController phone=TextEditingController();
//   TextEditingController email=TextEditingController();
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
//               ])),
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
//                           "Sign_up",
//                           style: TextStyle(color: Colors.white, fontSize: 40),
//                         )),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     FadeInUp(
//                         duration: Duration(milliseconds: 1300),
//                         child: Text(
//                           "Welcome ",
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         )),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     height: MediaQuery.of(context).size.height,
//
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(60),
//                             topRight: Radius.circular(60))),
//                     child: Padding(
//                       padding: EdgeInsets.all(30),
//                       child: Column(
//                         children: <Widget>[
//                           SizedBox(
//                             height: 60,
//                           ),
//                           FadeInUp(
//                               duration: Duration(milliseconds: 1400),
//
//                               child: Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(10),
//                                     boxShadow: [
//                                       BoxShadow(
//                                           color: Colors.purple.shade200,
//                                           blurRadius: 20,
//                                           offset: Offset(0, 10))
//                                     ]),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Container(
//                                       padding: EdgeInsets.all(10),
//                                       decoration: BoxDecoration(
//                                           border: Border(
//                                               bottom: BorderSide(
//                                                   color: Colors.grey.shade200))),
//                                       child: Form(
//                                           key: formstate,
//                                           child:Column(children: [
//
//
//                                             TextFormField(
//
//                                               validator: (value){
//                                                 if(value!.isEmpty){
//                                                   return"the field is empty";
//                                                 }},
//                                               controller: name,
//                                               decoration: InputDecoration(
//                                                 prefixIcon: Icon(Icons.person),
//                                                   prefixIconColor: Colors.purple,
//                                                   hintText: "name",
//                                                   hintStyle:
//                                                   TextStyle(color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//
//
//
//                                             Container(
//                                               padding: EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       bottom: BorderSide(
//                                                           color: Colors.grey.shade200))),),
//
//
//                                             TextFormField(
//                                               validator: (value){
//                                                 if(value!.isEmpty){
//                                                   return"the field is empty";
//                                                 }},
//                                               controller: phone,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons.phone),
//                                                   prefixIconColor: Colors.purple,
//                                                   hintText: "phone",
//                                                   hintStyle:
//                                                   TextStyle(color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//
//
//                                             Container(
//                                               padding: EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       bottom: BorderSide(
//                                                           color: Colors.grey.shade200))),),
//
//
//                                             TextFormField(
//                                               validator: (value){
//                                                 if(value!.isEmpty){
//                                                   return"the field is empty";
//                                                 }},
//                                               controller: email,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons.email),
//                                                   prefixIconColor: Colors.purple,
//                                                   hintText: "email",
//                                                   hintStyle:
//                                                   TextStyle(color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//
//
//
//                                             Container(
//                                               padding: EdgeInsets.all(5),
//                                               decoration: BoxDecoration(
//                                                   border: Border(
//                                                       bottom: BorderSide(
//                                                           color: Colors.grey.shade200))),),
//
//
//
//                                             TextFormField(
//                                               validator: (value){
//                                                 if(value!.isEmpty){
//                                                   return"the field is empty";
//                                                 }
//                                                 if(value.length<=5){
//                                                   return"must be more than 5";
//                                                 }
//                                               },
//                                               controller: password,
//                                               obscureText: true,
//                                               decoration: InputDecoration(
//                                                   prefixIcon: Icon(Icons.lock),
//                                                   prefixIconColor: Colors.purple,
//                                                   hintText: "Password",
//                                                   hintStyle:
//                                                   TextStyle(color: Colors.grey),
//                                                   border: InputBorder.none),
//                                             ),
//
//                                           ],)
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               )),
//                           SizedBox(
//                             height: 40,
//                           ),
//
//                           FadeInUp(
//                               duration: Duration(milliseconds: 1600),
//                               child: MaterialButton(
//                                 onPressed: () {
//                                   if(formstate.currentState!.validate()){
//                                   }
//                                 },
//                                 height: 50,
//                                 // margin: EdgeInsets.symmetric(horizontal: 50),
//                                 color: Colors.purple[400],
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(50),
//                                 ),
//                                 // decoration: BoxDecoration(
//                                 // ),
//                                 child: Center(
//                                   child: Text(
//                                     "Sign_up",
//                                     style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                               )),
//                           SizedBox(
//                             height: 50,
//                           ),
//                         ],
//                       ),
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
