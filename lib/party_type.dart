
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:new_event_app/public_event.dart';

import 'Cart_Page.dart';
import 'ID.dart';
import 'LoginSignup.dart';
import 'Navo.dart';
import 'Section.dart';
import 'Theme/themecontroller.dart';
import 'Token.dart';
import 'drawer.dart';
import 'order_id.dart';

class Party_Type extends StatefulWidget {
  State<Party_Type> createState() => Party_Type1();
}

class Party_Type1 extends State<Party_Type> {
  TextEditingController date = TextEditingController();
  TextEditingController people = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey();

  String? name_of_image;

  List photo = [
    {'path': 'image/birthday.jpg', 'name': 'birthday'},
    {'path': 'image/gender_reveal.jpg', 'name': 'gender_reveal'},
    {'path': 'image/wedding.webp', 'name': 'wedding'},
    {'path': 'image/graduation.jpg', 'name': 'graduation'},
    {'path': 'image/condolences.jpg', 'name': 'condolences'}
  ];

  final ThemeController themeController = Get.find();


  // Future<void> _selectData() async {
  //   DateTime? _picked = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now(),
  //       lastDate: DateTime(2030),
  //       builder: (context, child) {
  //         return Theme(
  //             data: Theme.of(context).copyWith(
  //                 colorScheme: themeController.isDarkMode.value
  //             ? ColorScheme.dark(
  //               primary: themeController.darkTheme.secondaryHeaderColor,
  //             )
  //               : ColorScheme.light(
  //         primary: themeController.lightTheme.secondaryHeaderColor,
  //         ),),
  //             child: child!);
  //       });
  //
  //   //  String t= Token.getToken();
  //
  //   if (_picked != null) {
  //     setState(() {
  //       date.text = _picked.toString().split(" ")[0];
  //     });
  //   }
  // }
  Future<void> _selectData() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: themeController.isDarkMode.value
                ? ColorScheme.dark(
              primary: Colors.blue, // Ensuring the selected date is always blue
              onPrimary: Colors.white, // Text color on the selected date
              surface: themeController.darkTheme.primaryColor,
              onSurface: Colors.white,
            )
                : ColorScheme.light(
              primary: Colors.blue, // Ensuring the selected date is always blue
              onPrimary: Colors.white, // Text color on the selected date
              surface: themeController.lightTheme.primaryColor,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: themeController.isDarkMode.value
                ? themeController.darkTheme.primaryColor
                : themeController.lightTheme.primaryColor,
          ),
          child: child!,
        );
      },
    );

    if (_picked != null) {
      setState(() {
        date.text = _picked.toString().split(" ")[0];
      });
    }
  }

  OrderList order = OrderList(order: <Order>[]);

  postorder() async {
    var headers = {'Authorization': 'Bearer ${Token.getToken()}'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://key-guided-walleye.ngrok-free.app/api/order'));
    request.fields.addAll({
      'category': name_of_image.toString(),
      'date': date.text,
      'people': people.text
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info = (await response.stream.bytesToString());
      setState(() {
        order = new OrderList.fromRawJson(info);
        ID.StoreID(order.order[0].id);
      });
      print(info);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Sections(ID.id)));
    } else {
      print(response.reasonPhrase);
    }
  }






  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
        appBar: AppBar(
          actions: [IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Cart_Page()));
          }, icon: Icon(Icons.add_shopping_cart_outlined))],
          elevation: 0,
          backgroundColor: Colors.grey[500],
        ),
        drawer: MyDrawer(),
        // bottomNavigationBar: Navo(),

      // bottomNavigationBar:   SafeArea(
      //   child: Scaffold(
      //     body: PageView(
      //       children:_pages,
      //       onPageChanged: (index){
      //         setState(() {
      //           _selectedItem=index;
      //         });
      //       },
      //       controller:_PagecController,
      //     ),
      //     //screen[_currentIndex], // عرض الصفحة المحددة بناءً على المؤشر الحالي
      //     bottomNavigationBar: CurvedNavigationBar(
      //       index: _selectedItem, // ضبط المؤشر الحالي
      //       height: 60.0,         // ارتفاع شريط التنقل
      //       items: <Widget>[
      //         Icon(Icons.star, size: 30),          // العنصر الأول
      //         Icon(Icons.shopping_cart, size: 30), // العنصر الثاني (غير الأيقونة إلى Shopping Cart)
      //         Icon(Icons.celebration, size: 30),   // العنصر الثالث
      //       ],
      //       color: Colors.white,           // لون الخلفية
      //       buttonBackgroundColor: Colors.white, // لون خلفية الزر النشط
      //       backgroundColor: Colors.blueAccent,  // لون الخلفية للشاشة
      //       animationCurve: Curves.easeInOut,    // نوع التحريك
      //       animationDuration: Duration(milliseconds: 600), // مدة التحريك
      //       onTap: (index) {
      //         setState(() {
      //           _selectedItem = index;
      //           _PagecController.animateToPage(_selectedItem, duration:Duration(milliseconds: 200), curve:Curves.linear);// تحديث المؤشر بناءً على العنصر المحدد
      //         });
      //       },
      //
      //     ),
      //   ),
      // ),


        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.grey[500],
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("image/event_type.jpg"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                          Colors.black.withOpacity(.2),
                          Colors.black.withOpacity(.2),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10, top: 170),
                          child: Form(
                            key: formState,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "The Field is empty"; // Translate error message
                                      }
                                    },
                                    controller: people,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "people".tr,
                                      hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge!.color),
                                      fillColor: themeController.isDarkMode.value
                                          ? themeController.darkTheme.primaryColor
                                          : themeController.lightTheme.primaryColor,
                                      prefixIcon: Icon(Icons.people), // Corrected icon
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: TextFormField(
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return "The Field is empty"; // Use translation key for error message
                                      }
                                    },
                                    controller: date,
                                    keyboardType: TextInputType.none,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.date_range),
                                      hintText: "date".tr, // Use translation key for hint text
                                      hintStyle: TextStyle(fontSize: 14, color: Theme.of(context).textTheme.bodyLarge!.color),
                                      fillColor: themeController.isDarkMode.value
                                          ? themeController.darkTheme.primaryColor
                                          : themeController.lightTheme.primaryColor,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.indigo),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onTap: () {
                                      _selectData();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: photo.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () {
                          name_of_image = photo[i]['name'];
                          if (formState.currentState!.validate()) {
                            postorder();
                          }
                        },
                        child: Card(
                          color: Colors.grey[500],
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(photo[i]['path']),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),


    );
  }


}










