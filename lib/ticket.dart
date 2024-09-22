import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:new_event_app/public_event_infolist.dart';
import 'package:ticket_widget/ticket_widget.dart';
import 'package:http/http.dart'as http;

import 'Navo.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';
import 'drawer.dart';
import 'notification/noti.dart';

class Ticket extends StatefulWidget {
  final EventInfo eventInfo;

  Ticket({required this.eventInfo});

  @override
  State<Ticket> createState() => _TicketState();
}
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class _TicketState extends State<Ticket> {
  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
  }
  int counter = 1;
  final ThemeController themeController = Get.find();


  /// api for buyTickets
  buyticket()async{
    var headers = {
      'Authorization': 'Bearer ${Token.getToken()}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/buy_ticket'));

    request.fields.addAll({
      'event_ID': widget.eventInfo.id.toString(),
      'quantity': counter.toString(),
      'price': widget.eventInfo.price.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Noti.showBigTextNotification(
          title: 'Ticket Buyed',
          body: 'Your Ticket have been Buyed successfully',
          fln: flutterLocalNotificationsPlugin);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("the ticket has been booked successfully")));
    }
    else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("you do not have enough money")));
    }
  }


  @override
  Widget build(BuildContext context) {
    // Parsing the date
    DateTime eventDate = DateTime.parse(widget.eventInfo.date.toString());
    String year = eventDate.year.toString();
    String month = eventDate.month.toString().padLeft(2, '0');
    String day = eventDate.day.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        title: Text("Your Ticket".tr),
        backgroundColor: Colors.grey[600],
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: Navo(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Text(
                  "Thank you for your purchase!".tr,
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  "Save your ticket below".tr,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 30),
                TicketWidget(
                  color: themeController.isDarkMode.value
                      ? themeController.darkTheme.primaryColor
                      : themeController.lightTheme.primaryColor,
                  width: 300,
                  height: 420,
                  isCornerRounded: true,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Colors.indigo,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(widget.eventInfo.image),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.eventInfo.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.indigo,
                                ),
                                Text(
                                  widget.eventInfo.location,
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Time".tr,
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        "Price".tr,
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color:themeController.isDarkMode.value
                                              ? themeController.darkTheme.primaryColor
                                              : themeController.lightTheme.primaryColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.eventInfo.time,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: 25,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          color: themeController.isDarkMode.value
                                              ? themeController.darkTheme.primaryColor
                                              : themeController.lightTheme.primaryColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            widget.eventInfo.price.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "Date".tr,
                                        style: TextStyle(fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: themeController.isDarkMode.value
                                              ? themeController.darkTheme.primaryColor
                                              : themeController.lightTheme.primaryColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '$year-$month-$day',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (counter > 1) {
                            counter--;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Text(
                      "$counter",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if(counter < widget.eventInfo.tickets)
                            counter++;
                        });
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  color: Colors.indigo,
                  child: Text("Buy Ticket".tr),
                  onPressed: () {
                    buyticket();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
