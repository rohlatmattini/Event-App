
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/order_infolist.dart';
import 'package:new_event_app/party_type.dart';
import 'ID.dart';
import 'Navo.dart';
import 'Section.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';
import 'order_info.dart';
import 'orders_list.dart';

class Order_Page extends StatefulWidget {
  @override
  State<Order_Page> createState() => _Order_PageState();
}

class _Order_PageState extends State<Order_Page> {
  String? id_order;
  OrderList orderList = OrderList(orderList: <OrderListElement>[]);
  OrderList filteredOrderList = OrderList(orderList: <OrderListElement>[]);
  String searchQuery = '';
  String selectedCategory = 'All';

  bool isLoading = true;

  final ThemeController themeController = Get.find();



  @override
  void initState() {
    super.initState();
    getOrderInfo();
  }

  getOrderInfo() async {
    var headers = {'Authorization': 'Bearer ${Token.getToken()}'};
    var request = http.MultipartRequest(
        'GET', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/orders_list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        orderList = OrderList.fromRawJson(info);
        filteredOrderList = OrderList(orderList: List.from(orderList.orderList));
        isLoading = false;
      });
    } else {
      print(response.reasonPhrase);
      setState(() {
        isLoading = false;
      });
    }
  }

  deleteOrder() async {
    var headers = {
      'id': id_order.toString(),
      'Authorization': 'Bearer ${Token.getToken()}'
    };
    var request = http.Request(
        'DELETE', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/delete_order'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void undoDelete(int index, OrderListElement delete1) {
    setState(() {
      filteredOrderList.orderList.insert(index, delete1);
    });
  }

  void filterOrders() {
    setState(() {
      if (selectedCategory == 'All') {
        filteredOrderList = OrderList(orderList: List.from(orderList.orderList));
      } else {
        filteredOrderList.orderList = orderList.orderList.where((order) {
          return order.category.toLowerCase() == selectedCategory.toLowerCase();
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[500],
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Party_Type()));
        },
        child: Icon(Icons.add, color: Colors.indigo),
      ),
      appBar: AppBar(
        title: Text("Your Orders".tr),
        backgroundColor: Colors.grey[600],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                  filterOrders();
                });
              },
              items: [
                DropdownMenuItem(value: 'All', child: Text('All'.tr)),
                DropdownMenuItem(value: 'birthday', child: Text('birthday'.tr)),
                DropdownMenuItem(value: 'gender_reveal', child: Text('gender_reveal'.tr)),
                DropdownMenuItem(value: 'wedding', child: Text('wedding'.tr)),
                DropdownMenuItem(value: 'graduation', child: Text('graduation'.tr)),
                DropdownMenuItem(value: 'condolences', child: Text('condolences'.tr)),
              ],
              isExpanded: true,
              icon: Icon(Icons.arrow_downward),
              elevation: 16,
              underline: Container(
                height: 2,
                // color: Colors.deepPurpleAccent,
              ),
            ),
          ),          Expanded(
            child: filteredOrderList.orderList.isEmpty
                ? Center(
              child: Text("You don't have any orders yet".tr),
            )
                : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: filteredOrderList.orderList.length,
                itemBuilder: (context, i) {
                  int year = filteredOrderList.orderList[i].date.year;
                  int month = filteredOrderList.orderList[i].date.month;
                  int day = filteredOrderList.orderList[i].date.day;
                  return Dismissible(
                    key: Key(filteredOrderList.orderList[i].id.toString()),
                    onDismissed: (direction) {
                      final delete1 = filteredOrderList.orderList.removeAt(i);
                      setState(() {
                        id_order = delete1.id.toString();
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Order deleted".tr),
                          action: SnackBarAction(
                            label: "Undo".tr,
                            onPressed: () {
                              undoDelete(i, delete1);
                            },
                          ),
                        ),
                      );
                      Timer(const Duration(seconds: 7), () {
                        if (!filteredOrderList.orderList.contains(delete1)) {
                          deleteOrder();
                        }
                      });
                    },
                    background: Container(
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 20.0),
                    ),
                    direction: DismissDirection.endToStart,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            ID.StoreID(filteredOrderList.orderList[i].id);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Order_Info(
                                  orderListElement: orderList.orderList[i],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: themeController.isDarkMode.value
                                ? themeController.darkTheme.primaryColor
                                : themeController.lightTheme.primaryColor,
                            child: ListTile(
                              title: Text(filteredOrderList.orderList[i].category),
                              subtitle: Text(filteredOrderList.orderList[i].people.toString()),
                              leading: Text('$year-$month-$day'),
                              trailing: Text(filteredOrderList.orderList[i].totalPrice.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
