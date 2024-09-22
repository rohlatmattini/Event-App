// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// import 'Hall_itemlist.dart';
// import 'ID.dart';
// import 'Navo.dart';
// import 'drawer.dart';
// import 'halls.dart';
// import 'halls_list.dart';
// import 'package:http/http.dart' as http;
//
// class HallItem extends StatefulWidget {
//   int id;
//
//   HallItem(this.id);
//
//   @override
//   State<HallItem> createState() => _HallItemState();
// }
//
// class _HallItemState extends State<HallItem> {
//   int activeIndex = 0;
//   final controller = CarouselController();
//
//   HallitemInfo hallitemInfo = HallitemInfo(hallInfo: <HallInfo>[]);
//
//   gethallInfo() async {
//     var headers = {
//       'id': widget.id.toString(),
//     };
//     var request = http.Request('GET',
//         Uri.parse('http://10.0.2.2:8000/api/get_hall'));
//
//     request.headers.addAll(headers);
//
//     http.StreamedResponse response = await request.send();
//
//     if (response.statusCode == 200) {
//       String info = await response.stream.bytesToString();
//       setState(() {
//         hallitemInfo = new HallitemInfo.fromRawJson(info);
//         print(info);
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }
//
//   @override
//   void initState() {
//     gethallInfo();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[500],
//       appBar: AppBar(
//         title: Text("Hall Detlais".tr),
//         backgroundColor: Colors.grey[600],
//       ),
//       drawer: MyDrawer(),
//       bottomNavigationBar: Navo(),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 40),
//         child: hallitemInfo.hallInfo.isEmpty
//             ? Center(child: CircularProgressIndicator())
//             : Stack(children: [
//                 Column(
//                   children: [
//                     CarouselSlider.builder(
//                         carouselController: controller,
//                         itemCount: hallitemInfo.hallInfo[0].images.length,
//                         itemBuilder: (context, index, realIndex) {
//                           final urlImage =
//                               hallitemInfo.hallInfo[0].images[index];
//                           return buildImage(urlImage, index);
//                         },
//                         options: CarouselOptions(
//                             height: 200,
//                             autoPlay: true,
//                             enableInfiniteScroll: false,
//                             autoPlayAnimationDuration: Duration(seconds: 2),
//                             enlargeCenterPage: true,
//                             onPageChanged: (index, reason) =>
//                                 setState(() => activeIndex = index))),
//                     SizedBox(height: 12),
//                     buildIndicator(),
//                     Padding(
//                       padding: const EdgeInsets.all(50),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//
//                           RichText(
//                               text: TextSpan(
//                                   text: 'name:    '.tr,
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text: " ${hallitemInfo.hallInfo[0].name}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//
//                           SizedBox(height: 10),
//                           RichText(
//                               text: TextSpan(
//                                   text: 'location:    ',
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text:
//                                         " ${hallitemInfo.hallInfo[0].location}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//
//                           SizedBox(height: 10),
//                           // Text(hallitemInfo.hallInfo[0].maxNum.toString(),style: TextStyle(fontSize: 20),),
//                           RichText(
//                               text: TextSpan(
//                                   text: 'capacity:    '.tr,
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text: " ${hallitemInfo.hallInfo[0].maxNum}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//                           SizedBox(height: 10),
//
//                           RichText(
//                               text: TextSpan(
//                                   text: 'owner_name:    ',
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text:
//                                         " ${hallitemInfo.hallInfo[0].owner.name}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//                           SizedBox(height: 10),
//
//                           RichText(
//                               text: TextSpan(
//                                   text: 'mobile:    ',
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text:
//                                         " ${hallitemInfo.hallInfo[0].owner.mobileNumber}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//
//                           SizedBox(height: 10),
//                           RichText(
//                               text: TextSpan(
//                                   text: 'email:    ',
//                                   style: TextStyle(
//                                     color: Colors.indigo,
//                                     fontSize: 20,
//                                   ),
//                                   children: [
//                                 TextSpan(
//                                     text:
//                                         " ${hallitemInfo.hallInfo[0].owner.email}",
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.black)),
//                               ])),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ]),
//       ),
//     );
//   }
//
//   Widget buildIndicator() => AnimatedSmoothIndicator(
//         onDotClicked: animateToSlide,
//         effect:
//             ExpandingDotsEffect(dotWidth: 10, activeDotColor: Colors.indigo),
//         activeIndex: activeIndex,
//         count: hallitemInfo.hallInfo.isNotEmpty
//             ? hallitemInfo.hallInfo[0].images.length
//             : 0,
//       );
//
//   void animateToSlide(int index) => controller.animateToPage(index);
//
//   Widget buildImage(String urlImage, int index) =>
//       Container(child: Image.network(urlImage, fit: BoxFit.cover));
// }
