
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/Restaurants.dart';
import 'dart:convert';

import 'Cars.dart';
import 'Decorations.dart';
import 'ID.dart';
import 'LoginSignup.dart';
import 'Order_ItemList.dart';
import 'Theme/themecontroller.dart';
import 'halls.dart';
import 'notification/noti.dart';
import 'order_id.dart';
import 'order_infolist.dart';
import 'orders_list.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class Order_Info extends StatefulWidget {

  final OrderListElement orderListElement;


  Order_Info({required this.orderListElement,});

  @override
  State<Order_Info> createState() => Order_Info1();
}

class Order_Info1 extends State<Order_Info> {

  final ThemeController themeController = Get.find();


  OrderInfo orderInfo = OrderInfo(orderInfo: <OrderInfoElement>[]);
  OrderItemList orderItemList =
      OrderItemList(decorationItems: <Item>[], restaurantItems: <Item>[]);

  getsubmit() async {
    var headers = {
      'id':ID.id.toString(),
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





  getOrderItem() async {
    var headers = {
      'id': ID.id.toString(),
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://key-guided-walleye.ngrok-free.app/api/order_items_list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        orderItemList = OrderItemList.fromRawJson(info);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getOrderInfo() async {
    var headers = {
      'id': ID.id.toString(),
    };
    var request = http.Request(
      'GET',
      Uri.parse('https://key-guided-walleye.ngrok-free.app/api/get_order'),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        orderInfo = OrderInfo.fromRawJson(info);
      });
    } else {
      print("Failed to load orders: ${response.reasonPhrase}");
    }
  }

  @override
  void initState() {
    Noti.initialize(flutterLocalNotificationsPlugin);
    super.initState();
    getOrderInfo();
    getOrderItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        title: Text("Order Details".tr),
      ),
      body: ListView.builder(

        itemCount: orderInfo.orderInfo.length,
        itemBuilder: (context, i) {


          int year = widget.orderListElement.date.year;
          int month = widget.orderListElement.date.month;
          int day = widget.orderListElement.date.day;


          final order = orderInfo.orderInfo[i];
          final itemdecoration = i < orderItemList.decorationItems.length
              ? orderItemList.decorationItems[i]
              : null;
          final itemrestaurant = i < orderItemList.restaurantItems.length
              ? orderItemList.restaurantItems[i]
              : null;
          return Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.orderListElement.category ,style: TextStyle(color:themeController.isDarkMode.value
                        ? themeController.darkTheme.primaryColor
                        : themeController.lightTheme.primaryColor,fontSize:25 ),),

                    Text('$year-$month-$day',style: TextStyle(color:themeController.isDarkMode.value
                        ? themeController.darkTheme.primaryColor
                        : themeController.lightTheme.primaryColor,fontSize:25 ),

                    ),
                  ],),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text("${widget.orderListElement.totalPrice.toString()}  SY" ,style: TextStyle(color:themeController.isDarkMode.value
                      ? themeController.darkTheme.primaryColor
                      : themeController.lightTheme.primaryColor,fontSize:25 ),),
                ],),

                SizedBox(height: 20,),


                if (order.hall.id != 0) ...[
                  Row(
                    children: [
                      Image.network(
                        order.hall.imageUrl,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: order.hall.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                text: 'Location:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: order.hall.location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            RichText(
                              text: TextSpan(
                                text: 'Price:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: '${order.hall.price.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 150),
                ],
                if (order.hall.id == 0) ...[
                  Row(
                    children: [
                      Container(
                        //width: double.infinity,
                        // height: 150,
                       // color: Colors.grey[300],
                        child:Text("You haven't booked a hall yet ".tr,style: TextStyle(fontSize: 18),),
                       ),


                    ],
                  ),
                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [ MaterialButton(
                      child: Text("Book now =>".tr),
                      onPressed:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Halls(order.hallId)));
                      }

                  )],),

                  Container(color: Colors.indigo,width: 250,height: 2,),

                  SizedBox(height: 15),
                ],
                if (order.car.id != 0) ...[
                  Row(

                    children: [
                      Image.network(
                        order.car.image,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: order.car.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Model:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: order.car.model,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Plate Number: '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: order.car.plateNumber.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Price:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: '${order.car.rentPrice.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(height: 20),
                ],
                if (order.car.id == 0) ...[
                  Row(

                    children: [
                      Container(
                        //width: double.infinity,
                        // height: 150,
                        // color: Colors.grey[300],
                        child:Text("You haven't booked a car yet ".tr,style: TextStyle(fontSize: 18),),
                      ),


                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [  MaterialButton(
                      child: Text("Book now =>".tr),
                      onPressed:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Cars()));
                      }

                  )],),
                  Container(color: Colors.indigo,width: 250,height: 2,),

                  SizedBox(height: 15),
                ],
                if (itemdecoration != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Image.network(
                        itemdecoration.item.imageUrl,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: itemdecoration.item.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Quantity:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: itemdecoration.quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Price:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: '${itemdecoration.price.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
                if (itemdecoration == null) ...[
                  Row(

                    children: [
                      Container(
                        //width: double.infinity,
                        // height: 100,
                        // color: Colors.grey[300],
                        child:Text("You haven't booked a Decoration yet ".tr,style: TextStyle(fontSize: 18),),
                      ),

                    ],
                  ),
                  SizedBox(height: 5,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    MaterialButton(
                        child: Text("Book now =>".tr),
                        onPressed:(){
                           Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Decorations(ID.id)));
                        }

                    )],),
                  Container(color: Colors.indigo,width: 250,height: 2,),

                  SizedBox(height: 15),
                ],
                if (itemrestaurant != null) ...[
                  Row(
                    children: [
                      Image.network(
                        itemrestaurant.item.imageUrl,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: 'Name:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: itemrestaurant.item.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Quantity:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: itemrestaurant.quantity.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 7),
                            RichText(
                              text: TextSpan(
                                text: 'Price:   '.tr,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: '${itemrestaurant.price.toString()}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
                if (itemrestaurant == null) ...[
                  Row(

                    children: [
                      Container(
                        //width: double.infinity,
                        // height: 150,
                        // color: Colors.grey[300],
                        child:Text("You haven't booked a restaurant yet ".tr,style: TextStyle(fontSize: 18),),
                      ),


                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [  MaterialButton(
                      child: Text("Book now =>".tr),
                      onPressed:(){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>Restaurants()));
                      }

                  )],),
                  SizedBox(height: 10),
                  MaterialButton(
                      color: Colors.indigo,
                      child: Text("Submit".tr),
                      onPressed: () {
                        getsubmit();
                      })
          ],
              ],
            ),
          );
        },
      ),
    );
  }
}

