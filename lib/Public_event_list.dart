import 'package:meta/meta.dart';
import 'dart:convert';

class PublicEventList {
  List<Event> events;

  PublicEventList({
    required this.events,
  });

  factory PublicEventList.fromRawJson(String str) => PublicEventList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PublicEventList.fromJson(Map<String, dynamic> json) => PublicEventList(
    events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "events": List<dynamic>.from(events.map((x) => x.toJson())),
  };
}

class Event {
  int id;
  String name;
  String location;
  String category;
  int maxNum;
  int tickets;
  int price;
  DateTime date;
  String time;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.category,
    required this.maxNum,
    required this.tickets,
    required this.price,
    required this.date,
    required this.time,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    category: json["category"],
    maxNum: json["capacity"],
    tickets: json["tickets"],
    price: json["price"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "category": category,
    "max_num": maxNum,
    "tickets": tickets,
    "price": price,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
