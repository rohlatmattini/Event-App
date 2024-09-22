import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Cart_item.dart';
import 'Decoration_item_info_list.dart';
import 'Decoration_singlItem.dart';
import 'Post_Rating.dart';
import 'Restaurant_SingleItem.dart';
import 'Restaurant_item_info_list.dart';
import 'Star_Rating.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';

class RestaurantsItem_info extends StatefulWidget {
  final int id;

  RestaurantsItem_info(this.id);

  @override
  State<RestaurantsItem_info> createState() => RestaurantsItem_info1();
}

class RestaurantsItem_info1 extends State<RestaurantsItem_info> {
  final controller = CarouselController();
  int counter = 1;

  RestaurantInfoList restaurantInfoList =
      RestaurantInfoList(restaurantItemList: <RestaurantItemList>[]);
  ItemList items = ItemList(items: <Item>[]);


  late double value=0.0;

//////////////
  void updateRating( double rating) {
    setState(() {
      value = rating;
    });
  }

  getRestaurantinfo() async {
    var headers = {
      'id': widget.id.toString(),
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://key-guided-walleye.ngrok-free.app/api/get_restaurant'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        restaurantInfoList = RestaurantInfoList.fromRawJson(info);
        print(info);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  getRestaurantItems() async {
    var headers = {
      'id': widget.id.toString(),
      'type': 'Restaurants',
    };
    var request = http.Request(
      'GET',
      Uri.parse('https://key-guided-walleye.ngrok-free.app/api/items_list'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        items = ItemList.fromRawJson(info);
        print(info);
      });
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
      'type': 'Hall',
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
    getRestaurantinfo();
    getRestaurantItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: restaurantInfoList.restaurantItemList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  // Top image section with fade-in effect
                  FadeInUp(
                    duration: Duration(milliseconds: 800),
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              restaurantInfoList.restaurantItemList[0].image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade700.withOpacity(.9),
                              Colors.grey.withOpacity(.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Details section
                  Expanded(
                    child: Transform.translate(
                      offset: Offset(0, -40),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color:  themeController.isDarkMode.value
                                    ? themeController.darkTheme.primaryColor
                                    : themeController.lightTheme.primaryColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1300),
                                      child: Text(
                                        restaurantInfoList
                                            .restaurantItemList[0].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.indigo,
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FadeInUp(
                                          child: Icon(
                                            Icons.location_on,
                                            color: Colors.indigo,
                                          ),
                                        ),
                                        FadeInUp(
                                          duration:
                                              Duration(milliseconds: 1400),
                                          child: Text(
                                            restaurantInfoList
                                                .restaurantItemList[0].location,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        restaurantInfoList
                                            .restaurantItemList[0].categories,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    FadeInUp(
                                      child: Text(
                                        "Owner Info:".tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                // Owner info section
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        restaurantInfoList
                                            .restaurantItemList[0].owner.name,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        restaurantInfoList
                                            .restaurantItemList[0].owner.email,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        restaurantInfoList.restaurantItemList[0]
                                            .owner.mobileNumber
                                            .toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeInUp(child:  Star_Rating(restaurantInfoList.restaurantItemList[0].rating.toInt(),true)),

                                    // FadeInUp(child:  Star_Rating(restaurantInfoList.restaurantItemList[0].rating.toInt(),true)),
                                    FadeInUp(child: MaterialButton(
                                      onPressed: () {
                                        // bookhall();
                                        showDialog(
                                            context: context,
                                            builder: (context){
                                              return AlertDialog(

                                                title: Icon(Icons.star_rate),
                                                content:Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text("Did You like this restaurant's services  ?".tr),
                                                    SingleChildScrollView(child: Row(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [ Post_Rating(value, false, updateRating),
                                                      ],))
                                                  ],),
                                                actions: [
                                                  TextButton(onPressed: ()async{
                                                    Navigator.of(context).pop();
                                                    // await bookhall() ;

                                                  },
                                                      child:Text("cancel".tr) ),

                                                  TextButton(onPressed: ()async{

                                                    print(value);
                                                    Navigator.of(context).pop();
                                                    // await bookhall();
                                                    await postRating();
                                                  },


                                                      child:Text("submit".tr) )
                                                ],
                                              );
                                            }
                                        );
                                      },

                                      child: Icon(Icons.add,color: Colors.indigo,size: 40,),
                                    ))

                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    FadeInUp(
                                      duration: Duration(milliseconds: 1400),
                                      child: Text(
                                        "Restaurant Items:".tr,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                // Carousel Slider section
                                CarouselSlider.builder(
                                  carouselController: controller,
                                  itemCount: items.items.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final item = items.items[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RestaurantSingle(
                                                    restaurantItem: item),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          image: DecorationImage(
                                            image: NetworkImage(item.imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width:
                                            200, // Adjust the width as needed
                                      ),
                                    );
                                  },
                                  options: CarouselOptions(
                                    height: 200,
                                    viewportFraction: 0.6,
                                    // Adjust image width in the carousel
                                    initialPage: 0,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 2),
                                    enlargeCenterPage:
                                        true, // Enlarge the center image
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
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
