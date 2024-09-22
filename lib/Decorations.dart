
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Cart_Page.dart';
import 'Decoration_item_info.dart';
import 'Decoration_list.dart';
import 'ID.dart';
import 'Navo.dart';
import 'Theme/themecontroller.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;

class Decorations extends StatefulWidget {
  int id;

  Decorations(this.id);

  @override
  State<Decorations> createState() => Decorations1();
}

class Decorations1 extends State<Decorations> {
  DecorationsList decorationsList =
      DecorationsList(decorationsList: <DecorationsListElement>[]);

  getDecorations() async {
    var headers = {
      'order_ID': ID.getID().toString(),
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://key-guided-walleye.ngrok-free.app/api/decorations_list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        decorationsList = DecorationsList.fromRawJson(info);
        print(decorationsList);
      });
    } else {
      print(response.reasonPhrase);
    }
  }


  final ThemeController themeController = Get.find();

  @override
  void initState() {
    getDecorations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text(
          "Decorations".tr,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.grey[600],
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    showSearch(
                        context: context, delegate: Search(decorationsList));
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Cart_Page()));
                  },
                  icon: Icon(Icons.add_shopping_cart_outlined))
            ],
          ),
        ],
      ),
      // bottomNavigationBar: Navo(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:decorationsList.decorationsList.isEmpty?Center(child: CircularProgressIndicator()):
        SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: decorationsList.decorationsList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, i) {
                    final decoration = decorationsList.decorationsList[i];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DecorationItem(decoration.id)));
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
                                decoration.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(decoration.name),
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  final DecorationsList decorationsList;

  Search(this.decorationsList);


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
    final filteredDecorations = query.isEmpty
        ? decorationsList.decorationsList
        : decorationsList.decorationsList
            .where((decoration) =>
                decoration.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return GridView.builder(
      itemCount: filteredDecorations.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final decoration = filteredDecorations[index];
        return InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DecorationItem(decoration.id)));
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
                    decoration.image,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 30),
                Text(decoration.name),
              ],
            ),
          ),
        );
      },
    );
  }
}
