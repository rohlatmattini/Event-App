// // import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// //
// // import 'package:flutter/material.dart';
// // import 'package:new_event_app/party_type.dart';
// // import 'package:new_event_app/public_event.dart';
// //
// // import 'Section.dart';
// //
// // class Navo extends StatefulWidget {
// //   @override
// //   _NavoState createState() => _NavoState();
// // }
// //
// // class _NavoState extends State<Navo> {
// //   int ?_currentIndex ; // Set initial index to 1 for the 'Shopping Cart' icon
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return CurvedNavigationBar(
// //       // index: _currentIndex,
// //       backgroundColor: Colors.grey,
// //       color: Colors.grey.shade400,
// //       animationDuration: Duration(milliseconds: 0),
// //       items: [
// //         Icon(Icons.star),
// //         Icon(Icons.celebration),
// //         Icon(Icons.home),
// //       ],
// //       onTap: (index) {
// //         setState(() {
// //           _currentIndex = index; // Update the current index
// //           if (index == 2) {
// //             Navigator.of(context).pushReplacement(MaterialPageRoute(
// //               builder: (context) => Party_Type(),
// //             )).then((_) {
// //               // This code executes after the Party_Type page is popped
// //               setState(() {
// //                 _currentIndex = 2; // Update _currentIndex to reflect the Party_Type page
// //               });
// //             });
// //
// //           } else if (index == 0) {
// //             Navigator.of(context).pushReplacement(MaterialPageRoute(
// //               builder: (context) => Public_event(),
// //             )).then((_) {
// //               // This code executes after the Party_Type page is popped
// //               setState(() {
// //                 _currentIndex = 0; // Update _currentIndex to reflect the Party_Type page
// //               });
// //             });
// //
// //           } else if (index == 1) {
// //             Navigator.of(context).pushReplacement(MaterialPageRoute(
// //               builder: (context) => Sections(0),
// //             )).then((_) {
// //               // This code executes after the Party_Type page is popped
// //               setState(() {
// //                 _currentIndex = 1; // Update _currentIndex to reflect the Party_Type page
// //               });
// //             });
// //
// //           }
// //         });
// //       },
// //     );
// //   }
// // }
// //
// //
//
// import 'package:flutter/material.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//
// class Navo extends StatefulWidget {
//   @override
//   _NavoState createState() => _NavoState();
// }
//
// class _NavoState extends State<Navo> {
//   int _selectedItem = 0; // المؤشر الحالي
//
//   var _pages = [
//     Public_event(), // الصفحة الأولى
//     Sections(0),   // الصفحة الثانية
//     Party_Type(),   // الصفحة الثالثة
//   ];
//   var _PagecController=PageController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return
//     SafeArea(
//       child: Scaffold(
//         body: PageView(
//           children:_pages,
//           onPageChanged: (index){
//             setState(() {
//               _selectedItem=index;
//             });
//           },
//           controller:_PagecController,
//         ),
//         //screen[_currentIndex], // عرض الصفحة المحددة بناءً على المؤشر الحالي
//         bottomNavigationBar: CurvedNavigationBar(
//           index: _selectedItem, // ضبط المؤشر الحالي
//           height: 60.0,         // ارتفاع شريط التنقل
//           items: <Widget>[
//             Icon(Icons.star, size: 30),          // العنصر الأول
//             Icon(Icons.shopping_cart, size: 30), // العنصر الثاني (غير الأيقونة إلى Shopping Cart)
//             Icon(Icons.celebration, size: 30),   // العنصر الثالث
//           ],
//           color: Colors.white,           // لون الخلفية
//           buttonBackgroundColor: Colors.white, // لون خلفية الزر النشط
//           backgroundColor: Colors.blueAccent,  // لون الخلفية للشاشة
//           animationCurve: Curves.easeInOut,    // نوع التحريك
//           animationDuration: Duration(milliseconds: 600), // مدة التحريك
//           onTap: (index) {
//             setState(() {
//               _selectedItem = index;
//               _PagecController.animateToPage(_selectedItem, duration:Duration(milliseconds: 200), curve:Curves.linear);// تحديث المؤشر بناءً على العنصر المحدد
//             });
//           },
//
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
