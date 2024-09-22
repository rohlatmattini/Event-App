import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Cart_Page.dart';
import 'Cart_item.dart';
import 'Decoration_item_info_list.dart';
import 'Global.dart';
import 'Theme/themecontroller.dart';

class DecorationSingle extends StatefulWidget {
  final Item decorationItem;

  DecorationSingle({required this.decorationItem});

  @override
  State<DecorationSingle> createState() => _DecorationSingleState();
}

class _DecorationSingleState extends State<DecorationSingle> {
  int counter = 1;
  TextEditingController number =TextEditingController();
  GlobalKey<FormState> con_num=GlobalKey();


  final ThemeController themeController = Get.find();


  @override
  Widget build(BuildContext context) {
    int inCart=0;
    int Available=0;
    for(int i=0;i<Global.cart.length;i++)
      if(Global.cart[i].id==widget.decorationItem.id)
        inCart=Global.cart[i].quantity;
    Available=widget.decorationItem.quantity-inCart;
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FadeInUp(
              duration: Duration(milliseconds: 800),
              child: Container(
                width: double.infinity,
                height: 400,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.decorationItem.imageUrl),
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
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
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
                      color:  themeController.isDarkMode.value
                    ? themeController.darkTheme.primaryColor
                        : themeController.lightTheme.primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInUp(
                                duration: Duration(milliseconds: 1300),
                                child: Text(
                                  widget.decorationItem.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              FadeInUp(
                                duration: Duration(milliseconds: 1400),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${widget.decorationItem.price.toString()} ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text("SYP".tr, style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                       Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FadeInUp(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FadeInUp(
                                      child: Text(
                                        "Available Quantity:".tr,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    FadeInUp(
                                      child: Text(
                                        Available.toString(),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              FadeInUp(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(

                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                            title: Text("Choose quantity"),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  if(con_num.currentState!.validate()) {
                                                    setState(() {
                                                      // Parse the input value to integer and assign it to counter

                                                      counter = int.tryParse(
                                                          number.text) ??
                                                          counter;
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  }

                                                },
                                                child: Text("Submit"),
                                              ),
                                            ],
                                            content: Form(
                                              key: con_num,
                                              child: TextFormField(
                                                  keyboardType: TextInputType.number,
                                                  controller: number,
                                                  decoration: InputDecoration(
                                                    hintText: "Counter",
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    border: InputBorder.none,

                                                  ),
                                                  validator: (value){
                                                    int? inputNumper=int.tryParse(value??"");
                                                    if(inputNumper!>widget.decorationItem.quantity){
                                                      return"out of the available quantity";
                                                    }
                                                  }
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.numbers),
                                    ),
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
                                        // color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                    Text(
                                      "$counter",
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (counter <
                                              widget.decorationItem.quantity)
                                            counter++;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.add,
                                        // color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // ),
                            ],
                          ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1700),
                          child: MaterialButton(
                            onPressed: () {
                              if (Available > 0) {
                                setState(() {
                                  bool there = false;
                                  for (int j = 0; j < Global.cart.length; j++) {
                                    if (Global.cart[j].id ==
                                        widget.decorationItem.id) {
                                      Global.cart[j].quantity += counter;
                                      there = true;
                                    }
                                  }
                                  if (!there) {
                                    Global.cart.add(Item(
                                        id: widget.decorationItem.id,
                                        name: widget.decorationItem.name,
                                        locationType:
                                            widget.decorationItem.locationType,
                                        locationId:
                                            widget.decorationItem.locationId,
                                        price: widget.decorationItem.price,
                                        quantity: counter,
                                        imageUrl:
                                            widget.decorationItem.imageUrl,
                                        createdAt:
                                            widget.decorationItem.createdAt,
                                        updatedAt:
                                            widget.decorationItem.updatedAt));
                                  }
                                  counter = 1; //
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("the item has been added successfully")));// Reset counter after adding to cart
                                });
                              }
                            },
                            height: 45,
                            color: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "Add to cart".tr,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Cart_Page(),
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.add_shopping_cart,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
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
