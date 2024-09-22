// import 'package:meta/meta.dart';
// import 'dart:convert';
//
// class Public {
//   List<Event> events;
//
//   Public({
//     required this.events,
//   });
//
//   factory Public.fromRawJson(String str) => Public.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Public.fromJson(Map<String, dynamic> json) => Public(
//     events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "events": List<dynamic>.from(events.map((x) => x.toJson())),
//   };
// }
//
// class Event {
//   String name;
//   String location;
//   DateTime date;
//   String category;
//   int maxNum;
//   int tickets;
//   int price;
//
//   Event({
//     required this.name,
//     required this.location,
//     required this.date,
//     required this.category,
//     required this.maxNum,
//     required this.tickets,
//     required this.price,
//   });
//
//   factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Event.fromJson(Map<String, dynamic> json) => Event(
//     name: json["name"],
//     location: json["location"],
//     date: DateTime.parse(json["date"]),
//     category: json["category"],
//     maxNum: json["max_num"],
//     tickets: json["tickets"],
//     price: json["price"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "name": name,
//     "location": location,
//     "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//     "category": category,
//     "max_num": maxNum,
//     "tickets": tickets,
//     "price": price,
//   };
// }
