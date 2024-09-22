import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Car_item_info_list.dart';
import 'ID.dart';
import 'Post_Rating.dart';
import 'Star_Rating.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';

class Car_iteminfo extends StatefulWidget {
  int id;

  @override
  State<Car_iteminfo> createState() => Car_iteminfo1();

  Car_iteminfo(this.id);
}

class Car_iteminfo1 extends State<Car_iteminfo> {
  int counter = 1;

  CarInfolist carsInfoList = CarInfolist(carsInfo: <CarsInfo>[]);
  late double value=0.0;

//////////////
  void updateRating( double rating) {
    setState(() {
      value = rating;
    });
  }

  getCarsinfo() async {
    var headers = {
      'id': widget.id.toString(),
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/get_car'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = (await response.stream.bytesToString());
      setState(() {
        carsInfoList = CarInfolist.fromRawJson(info);
        print(carsInfoList);
      });
    } else {
      print(response.reasonPhrase);
    }
  }



  ///Api for bookhall
  bookcar() async {
    var headers = {
      'order_ID': ID.id.toString(),
      'car_ID': widget.id.toString(),
      'Authorization': 'Bearer ${Token.getToken()}',
    };
    var request = http.Request('PUT',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/book_car'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("the car has been booked successfully")),
      );

    } else {
      print(response.reasonPhrase);
    }
  }
  postRating()async{
    var headers = {
      'Authorization': 'Bearer ${Token.getToken()}'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/rate'));
    request.fields.addAll({
      'id': widget.id.toString(),
      'type': 'Car',
      'rating': value.toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  final ThemeController themeController = Get.find();


  @override
  void initState() {
    super.initState();
    getCarsinfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: carsInfoList.carsInfo.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  NetworkImage(carsInfoList.carsInfo[0].image),
                              fit: BoxFit.cover)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                colors: [
                              Colors.grey.shade700.withOpacity(.9),
                              Colors.grey.withOpacity(.0),
                            ])),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeInUp(
                                duration: Duration(milliseconds: 1000),
                                child: Container(
                                  width: 90,
                                  margin: EdgeInsets.only(bottom: 60),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 4,
                                        margin: EdgeInsets.only(right: 5),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
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
                                      carsInfoList.carsInfo[0].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  FadeInUp(
                                    duration: Duration(milliseconds: 1400),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          carsInfoList.carsInfo[0].rentPrice.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        Text(
                                          "SYP".tr,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                             Row(children: [
                               SizedBox(height: 10),
                               FadeInUp(
                                 child: Text("Owner Info:".tr,
                                     style: TextStyle(
                                         fontSize: 20,
                                         fontWeight: FontWeight.bold)),
                               ),
                               SizedBox(height: 10),],),
                             Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        carsInfoList.carsInfo[0].owner.name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        carsInfoList.carsInfo[0].owner.email,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        carsInfoList
                                            .carsInfo[0].owner.mobileNumber
                                            .toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FadeInUp(child:  Star_Rating(carsInfoList.carsInfo[0].rating.toInt(),true)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 1700),
                                child: MaterialButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context){
                                          return AlertDialog(

                                            title: Icon(Icons.star_rate),
                                            content:Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text("enjoying event application ?".tr),
                                                SingleChildScrollView(child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [ Post_Rating(value, false, updateRating),
                                                  ],))
                                              ],),
                                            actions: [
                                              TextButton(onPressed: ()async{
                                                Navigator.of(context).pop();
                                                await bookcar() ;

                                              },
                                                  child:Text("cancel".tr) ),

                                              TextButton(onPressed: ()async{

                                                print(value);
                                                Navigator.of(context).pop();
                                                await bookcar();
                                                await postRating();
                                              },


                                                  child:Text("submit".tr) )
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  height: 45,
                                  color: Colors.indigo,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Text(
                                      "Book Now".tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
