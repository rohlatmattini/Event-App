import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/notification/noti.dart';

import 'Cars.dart';
import 'Cart_Page.dart';
import 'Decorations.dart';
import 'ID.dart';
import 'Navo.dart';
import 'Restaurants.dart';
import 'drawer.dart';
import 'halls.dart';

class Sections extends StatefulWidget {
  int id;

  Sections(this.id);

  State<Sections> createState() => Sections1(id);
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

///
class Sections1 extends State<Sections> {
  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }

  int id;

  Sections1(this.id);

  getsubmit() async {
    var headers = {
      'id': id.toString(),
    };
    var request =
        http.Request('PUT', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/submit_order'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Noti.showBigTextNotification(
          title: 'Oreder Submited',
          body: 'Your order have been submited successfully',
          fln: flutterLocalNotificationsPlugin);

      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
// bottomNavigationBar: Navo(),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Scaffold(
            backgroundColor: Colors.grey[500],
            drawer: MyDrawer(),
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Cart_Page()));
                    },
                    icon: Icon(Icons.add_shopping_cart_outlined))
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "image/Section.jpg",
                            ),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black.withOpacity(.2),
                              Colors.black.withOpacity(.2)
                            ]),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Halls(ID.id)));
                            },
                            child: Container(
                              width: 310,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Halls".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Decorations(ID.id)));
                            },
                            child: Container(
                              width: 310,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Decorations".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Restaurants()));
                            },
                            child: Container(
                              width: 310,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text("Restaurants".tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Cars()));
                            },
                            child: Container(
                              width: 310,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Cars".tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          MaterialButton(
                              color: Colors.indigo,
                              child: Text("Submit".tr),
                              onPressed: () {
                                getsubmit();
                              })
                        ]),
                  ),
                ])),
          )),
    );
  }
}
