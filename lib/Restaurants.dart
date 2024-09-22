
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Cart_Page.dart';
import 'Navo.dart';
import 'Restaurant_item_info.dart';
import 'Restaurant_list.dart';
import 'Theme/themecontroller.dart';
import 'drawer.dart';

class Restaurants extends StatefulWidget {
  @override
  State<Restaurants> createState() => Restaurants1();
}

class Restaurants1 extends State<Restaurants> {
  ListRestaurants listRestaurants=ListRestaurants(restaurantsList:<RestaurantsList>[]);
  bool isLoading = true; // Add a loading state

  getRestaurants() async {
    var request = http.Request('GET', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/restaurants_list'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        listRestaurants=new ListRestaurants.fromRawJson(info);
        isLoading = false; // Update loading state
        print(listRestaurants);
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false; // Update loading state even on error
      });
    }
  }
  @override
  void initState() {

    getRestaurants();
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
                    showSearch(context: context, delegate: Search(listRestaurants));
                  },
                  icon: Icon(Icons.search)),

              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Cart_Page()));
                  },
                  icon: Icon(Icons.add_shopping_cart_outlined))
            ],
          )
        ],
        title: Text('Restaurants'.tr),
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: Navo(),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading spinner
          : Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: listRestaurants.restaurantsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            final restaurant=listRestaurants.restaurantsList[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => RestaurantsItem_info(restaurant.id)));
              },
              child: Card(
                color: themeController.isDarkMode.value
                    ? themeController.darkTheme.primaryColor
                    : themeController.lightTheme.primaryColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 3),
                      child: Image.network(
                        restaurant.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(restaurant.name),
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

class Search extends SearchDelegate {
  final ListRestaurants restaurantList;

  Search(this.restaurantList);

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
    final filteredRestaurants = query.isEmpty
        ? restaurantList.restaurantsList
        : restaurantList.restaurantsList.where((restaurant) => restaurant.name.toLowerCase().contains(query.toLowerCase())).toList();
    return GridView.builder(
      itemCount: filteredRestaurants.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final restaurant = filteredRestaurants[index];
        return InkWell(
          onTap:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RestaurantsItem_info(restaurant.id)));

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
                      filteredRestaurants[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),

                SizedBox(height: 20),
                Text(filteredRestaurants[index].name),
              ],
            ),
          ),
        );
      },
    );
  }
}
