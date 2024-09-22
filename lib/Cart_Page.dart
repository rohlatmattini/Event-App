import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:new_event_app/party_type.dart';
import 'Global.dart';
import 'Cart_item.dart';
import 'ID.dart';
import 'Navo.dart';
import 'package:http/http.dart' as http;

import 'Theme/themecontroller.dart';
import 'Token.dart';

class Cart_Page extends StatefulWidget {
  @override
  State<Cart_Page> createState() => Cart_Page1();
}

class Cart_Page1 extends State<Cart_Page> {
  var undo = false;
  final ThemeController themeController = Get.find();

  void undoDelete(int index, Item deletedItem) {
    setState(() {
      Global.cart.insert(index, deletedItem);
    });
  }

  buycart() async {
    final items = jsonEncode({'cart': Global.cart});
    var headers = {'Authorization': 'Bearer ${Token.getToken()}'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/purchase'));
    request.fields.addAll({
      'items': items,
      'order_ID': ID.id.toString(),
      'total_price': Global.getCartPrice().toString(),
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(jsonEncode(Global.cart));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            buycart();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Party_Type()));
            Global.cart = [];
          },
          child: Text("Buy")),
      backgroundColor: Colors.grey[500],
      // bottomNavigationBar: Navo(),
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Text(Global.getCartPrice().toStringAsFixed(1) + ' SYP'),
              Icon(
                Icons.wallet,
                color: Colors.white,
              ),
            ],
          )
        ],
        title: Text("Your Cart"),
        backgroundColor: Colors.grey[600],
      ),
      body: Global.cart.isEmpty
          ? Center(child: Text("Your Cart is empty"))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: Global.cart.length,
                itemBuilder: (context, i) {
                  final cartItem = Global.cart[i];
                  final itemPrice = cartItem.price * cartItem.quantity;
                  return Dismissible(
                    key: Key(cartItem.id.toString()),
                    onDismissed: (direction) {
                      setState(() {
                        final deletedItem = Global.cart.removeAt(i);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Item deleted"),
                          action: SnackBarAction(
                            label: "Undo",
                            onPressed: () {
                              undo = true;
                              undoDelete(i, deletedItem);
                            },
                          ),
                        ));
                      });
                      Timer(const Duration(seconds: 7), () {
                        if (!undo) {
                          // u;
                        }
                        undo = false;
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    direction: DismissDirection.endToStart,
                    child: Card(
                      color: themeController.isDarkMode.value
                          ? themeController.darkTheme.primaryColor
                          : themeController.lightTheme.primaryColor,
                      child: ListTile(
                        title: Text(cartItem.name),
                        subtitle: Text(itemPrice.toString()),
                        trailing: Text("Qty: ${cartItem.quantity.toString()}"),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
