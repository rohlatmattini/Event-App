import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'Global.dart';
import 'List_UserInfo.dart';
import 'LoginSignup.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';
import 'order_page.dart';
import 'party_type.dart';
import 'public_event.dart';
import 'setting.dart';

class MyDrawer extends StatefulWidget {
  State<MyDrawer> createState() => MyDrawer1();
}

class MyDrawer1 extends State<MyDrawer> {
  UserInfo userInfo = UserInfo(user: <User>[]);

  getUserInfo() async {
    var headers = {'Authorization': 'Bearer ${Token.getToken()} '};
    var request = http.Request(
        'GET', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/get_user'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = await response.stream.bytesToString();
      setState(() {
        userInfo = new UserInfo.fromRawJson(info);
      });
    } else {
      print(response.reasonPhrase);
    }
  }

  logout() async {
    var headers = {'Authorization': 'Bearer ${Token.getToken()}'};
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://127.0.0.1:8000/api/logout'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        userInfo = UserInfo(user: []); // Clear user info
      });
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeController.isDarkMode.value
          ? themeController.darkTheme.primaryColor
          : themeController.lightTheme.primaryColor,
      child: userInfo.user.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 100),
        child: Column(
          children: [
            userInfo.user.isNotEmpty // Check if user list is not empty
                ? Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.person, color: Colors.indigo),
                      title: Text(
                        userInfo.user[0].name,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 25),
                      ),
                      subtitle: Text(
                        userInfo.user[0].email,
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            )
                : Container(),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.attach_money, color: Colors.indigo),
                      title: Text(
                        "your money".tr,
                        style: TextStyle(fontSize: 15),
                      ),
                      subtitle: Text(
                        userInfo.user[0].balance.toString(),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.home, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => Party_Type()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Home".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.shopping_cart, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Order_Page()),
                          );
                        },
                        child: Text(
                          "orders".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.settings, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Setting()),
                          );
                        },
                        child: Text(
                          "Setting".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.celebration, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Public_event()),
                          );
                        },
                        child: Text(
                          "Public event".tr,
                          style: TextStyle(
                              color: Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      leading: Icon(Icons.logout_sharp, color: Colors.indigo),
                      title: TextButton(
                        onPressed: () async {
                          Global.cart = [];
                          SharedPreferences pref = await SharedPreferences.getInstance();
                          await pref.clear();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginSignupScreen()),
                                (route) => false,
                          );
                          logout();
                        },
                        child: Text(
                          "Logout".tr,
                          style: TextStyle(color: Colors.red, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
