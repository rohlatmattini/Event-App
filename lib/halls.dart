import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'Cart_Page.dart';
import 'Halls_iteminfo.dart';
import 'ID.dart';
import 'Navo.dart';
import 'Theme/themecontroller.dart';
import 'drawer.dart';
import 'Hall_itemlist.dart';
import 'halls_list.dart';

class Halls extends StatefulWidget {
  int id;

  Halls(this.id);

  @override
  State<Halls> createState() => HallsState();
}

class HallsState extends State<Halls> {
  HallList hallList = HallList(hallsList: <HallsList>[]);

  gethalllist() async {
    var headers = {
      'order_ID': ID.getID().toString(),
    };
    var request = http.MultipartRequest('GET',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/halls_list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        hallList = new HallList.fromRawJson(info);
        print(hallList);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  final ThemeController themeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    gethalllist();
  }

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
                    showSearch(context: context, delegate: Search(hallList));
                  },
                  icon: Icon(Icons.search)),

              IconButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart_Page()));
              }, icon: Icon(Icons.add_shopping_cart_outlined))],
          )
        ],
        title: Text('Halls'.tr),
      ),
      drawer: MyDrawer(),
      // bottomNavigationBar: Navo(),
      body: hallList.hallsList.isEmpty? Center(child: CircularProgressIndicator()):
      Padding(
        padding: EdgeInsets.only(top: 10),
        child: GridView.builder(
          itemCount: hallList.hallsList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            final hall = hallList.hallsList[index];

            return InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HallItem(hall.id)));
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
                        hallList.hallsList[index].imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(hallList.hallsList[index].name),
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

////////////////////////////////////////////////////////////////////////////////

class Search extends SearchDelegate {
  final HallList hallList;

  Search(this.hallList);


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
    final filteredHalls = query.isEmpty
        ? hallList.hallsList
        : hallList.hallsList
        .where(
            (hall) => hall.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return GridView.builder(
      itemCount: filteredHalls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {

        final hall = filteredHalls[index];

        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HallItem(hall.id)));
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
                    filteredHalls[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),
                Text(filteredHalls[index].name),
              ],
            ),
          ),
        );
      },
    );
  }
}
