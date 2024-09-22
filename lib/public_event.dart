
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:new_event_app/public_event_info.dart';

import 'Navo.dart';
import 'Public_event_list.dart';
import 'Theme/themecontroller.dart';
import 'drawer.dart';

class Public_event extends StatefulWidget{
  State<Public_event>createState()=>Public_event1();
}

class Public_event1 extends State<Public_event>{

  PublicEventList event=PublicEventList(events: <Event>[]);

  final ThemeController themeController = Get.find();


  getevent()async{
    var request = http.Request('GET', Uri.parse('https://key-guided-walleye.ngrok-free.app/api/events_list'));

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String info=(await response.stream.bytesToString());
      setState(() {
        event=new PublicEventList.fromRawJson(info);
        print(event);
      });
    }
    else {
      print(response.reasonPhrase);
    }
  }
  @override

  void initState() {
    // TODO: implement initState
    getevent();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.grey[500],
        appBar: AppBar(
          title: Text("Upcoming Events ".tr),
          backgroundColor: Colors.grey[600],
        ),
        drawer: MyDrawer(),
        // bottomNavigationBar: ,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: event.events.length,
                    itemBuilder: (context,i){
                      final even= event.events[i];
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PublicEventInfo(even.id)));
                        },
                        child: Card(
                          color: Colors.grey[300],
                          child: ListTile(
                            tileColor:  themeController.isDarkMode.value
                          ? themeController.darkTheme.primaryColor
                              : themeController.lightTheme.primaryColor,

                            title: Text(event.events[i].name,style: TextStyle(color:Theme.of(context).textTheme.bodyLarge!.color),),
                            subtitle:  Text(event.events[i].location,style: TextStyle(color:Theme.of(context).textTheme.bodyLarge!.color),),
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(even.image),
                                  fit: BoxFit.cover,
                                ),
                              ),

                            ) ,


                          ),
                        ),
                      );
                    }
                ),
              )
            ],
          ),
        ),

    );
  }

}