import 'package:meta/meta.dart';
import 'dart:convert';

class HallList {
  List<HallsList> hallsList;

  HallList({
    required this.hallsList,
  });

  factory HallList.fromRawJson(String str) => HallList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HallList.fromJson(Map<String, dynamic> json) => HallList(
    hallsList: List<HallsList>.from(json["halls_list"].map((x) => HallsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "halls_list": List<dynamic>.from(hallsList.map((x) => x.toJson())),
  };
}

class HallsList {
  int id;
  String name;
  int ownerId;
  String location;
  int maxNum;
  String categories;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  HallsList({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.location,
    required this.maxNum,
    required this.categories,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HallsList.fromRawJson(String str) => HallsList.fromJson(json.decode(str));


  String toRawJson() => json.encode(toJson());

  factory HallsList.fromJson(Map<String, dynamic> json) => HallsList(
    id: json["id"],
    name: json["name"],
    ownerId: json["owner_ID"],
    location: json["location"],
    maxNum: json["max_num"],
    categories: json["categories"],
    imageUrl: json["image_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "owner_ID": ownerId,
    "location": location,
    "max_num": maxNum,
    "categories": categories,
    "image_url": imageUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}