//                   TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 10),
//
//           RichText(
//             text: TextSpan(
//               text: 'rent price:    ',
//               style: TextStyle(color: Colors.indigo, fontSize: 20),
//               children: [
//                 TextSpan(
//                   text:
//                   " ${carsInfoList.carsInfo[0].rentPrice}",
//                   style:
//                   TextStyle(fontSize: 20, color: Colors.black),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//
//             ],
//         ),
//       ),
//     );
//   }
// }
import 'package:animate_do/animate_do.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/public_event_infolist.dart';
import 'package:new_event_app/ticket.dart';

import 'Car_item_info_list.dart';
import 'Theme/themecontroller.dart';

class PublicEventInfo extends StatefulWidget {
  final int id;

  PublicEventInfo(this.id);

  @override
  State<PublicEventInfo> createState() => _PublicEventInfoState();
}

class _PublicEventInfoState extends State<PublicEventInfo> {
  Eventinfolist eventinfolist = Eventinfolist(eventInfo: <EventInfo>[]);


  final ThemeController themeController = Get.find();


  geteventinfo() async {
    var headers = {
      'id': widget.id.toString(),
    };
    var request = http.Request('GET',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/get_event'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        eventinfolist = Eventinfolist.fromRawJson(info);
        print(info);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    geteventinfo();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: eventinfolist.eventInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 800),
                      child: Container(
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    eventinfolist.eventInfo[0].image),
                                fit: BoxFit.cover)),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomRight,
                                  colors: [
                                Colors.grey.shade700.withOpacity(.9),
                                Colors.grey.withOpacity(.0),
                              ])),
                        ),
                      )),
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, -40),
                      child: FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(30),
                            decoration: BoxDecoration(
                                color: themeController.isDarkMode.value
                                    ? themeController.darkTheme.primaryColor
                                    : themeController.lightTheme.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1300),
                                        child: Text(
                                          eventinfolist.eventInfo[0].name,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FadeInUp(
                                            child: Icon(
                                          Icons.location_on,
                                          color: Colors.indigo,
                                        )),
                                        FadeInUp(
                                            duration:
                                                Duration(milliseconds: 1400),
                                            child: Text(
                                              "${eventinfolist.eventInfo[0].location}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            )),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1400),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${eventinfolist.eventInfo[0].price.toString()} ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            Text("SYP".tr,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          ],
                                        )),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                        duration: Duration(milliseconds: 1400),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Available Quantity:  ".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20)),
                                            Text(
                                              "${eventinfolist.eventInfo[0].tickets}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FadeInUp(
                                    duration: Duration(milliseconds: 1700),
                                    child: MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) => Ticket(
                                                    eventInfo: eventinfolist
                                                        .eventInfo[0])));
                                      },
                                      height: 45,
                                      color: Colors.indigo,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Center(
                                        child: Text(
                                          "get Ticket".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
