import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'Cars_item_info.dart';
import 'Cars_list.dart';
import 'Cart_Page.dart';
import 'ID.dart';
import 'Navo.dart';
import 'Theme/themecontroller.dart';
import 'drawer.dart';

class Cars extends StatefulWidget {
  @override
  State<Cars> createState() => Cars1();
}

class Cars1 extends State<Cars> {
  CarList carList = CarList(carsList: <CarsList>[]);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCars();
  }

  getCars() async {
    var headers = {
      'order_ID': ID.id.toString(),
    };
    var request = http.Request('GET', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/car_list'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        carList = CarList.fromRawJson(info);
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }


  final ThemeController themeController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      appBar: AppBar(
        backgroundColor: Colors.grey[600],
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search(carList));
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart_Page()));                },
                icon: Icon(Icons.add_shopping_cart_outlined),
              ),

            ],
          )
        ],
        title: Text('Cars'.tr),
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: Navo(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: carList.carsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            final cars = carList.carsList[index];

            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Car_iteminfo(cars.id)));
              },
              child: Card(
                color: themeController.isDarkMode.value
                    ? themeController.darkTheme.primaryColor
                    : themeController.lightTheme.primaryColor,
                child: Column(
                  children: [

                Container(
                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                          cars.image,
                          fit: BoxFit.cover,
                        ),
                ),
                    SizedBox(height: 20),
                    Text(cars.name),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Search extends SearchDelegate<List<CarsList>> {
  final CarList carList;

  Search(this.carList);

  final ThemeController themeController = Get.find();


  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final filteredCars = query.isEmpty
        ? carList.carsList
        : carList.carsList.where((car) => car.name.toLowerCase().contains(query.toLowerCase())).toList();
    return GridView.builder(
      itemCount: filteredCars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final car = filteredCars[index];
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Car_iteminfo(car.id)));
          },
          child: Card(
            color: themeController.isDarkMode.value
                ? themeController.darkTheme.primaryColor
                : themeController.lightTheme.primaryColor,
            child: Column(
              children: [
                Container(
                  height: 110,
                  child: Image.network(
                      car.image,
                      fit: BoxFit.cover,
                    ),
                ),

                SizedBox(height: 20),
                Text(car.name),
              ],
            ),
          ),
        );
      },
    );
  }
}