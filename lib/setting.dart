
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Theme/themecontroller.dart';
import 'locale/locale_controller.dart';
class Setting extends StatefulWidget {
  State<Setting> createState() => Setting1();
}

class Setting1 extends State<Setting> {

  bool isDark = false;
  String? language;




  @override
  Widget build(BuildContext context) {

   MyLocaleController controllerlang = Get.find();
   ThemeController themecontroller=Get.find();

    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          // actions: [
          //   IconButton(
          //       onPressed: (){
          //         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Party_Type()));
          //       },
          //       icon: Icon(Icons.arrow_back))],
          title:Text(
            "Setting".tr,
            style: TextStyle(color:Theme.of(context).textTheme.bodyLarge!.color, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 10,right: 10,top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading:
                            Icon(Icons.dark_mode_rounded, color: Colors.indigo),
                        title: Text(
                          "Dark mode".tr,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                          ),
                        ),
                        trailing: Obx(()=>Switch(value:themecontroller.isDarkMode.value, onChanged:(state){
                          themecontroller.toggleTheme();
                        }))
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height:5,),

              Row(
                children: [
                  Expanded(
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.language,
                          color: Colors.indigo,
                        ),
                        title: Text(
                          "Language".tr,
                          style: TextStyle(fontSize: 20,color:Theme.of(context).textTheme.bodyLarge!.color),
                        ),

                        // child: Text("your Language $language",textAlign: TextAlign.center,style:TextStyle(fontSize:20),)
                      ),
                    ),
                  ),

                ],
              ),
              MaterialButton(
                onPressed: (){
                  controllerlang.changeLang("en");
                },
                child: Text("English",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),),
              ),
              MaterialButton(
                onPressed: (){
                  controllerlang.changeLang('ar');
                  // controllerlang.currentLocale();

                },
                child: Text("arabic",style: TextStyle(color: Theme.of(context).textTheme.bodyLarge!.color),),
              )

             ],

          ),
        ),

    );
  }
}
