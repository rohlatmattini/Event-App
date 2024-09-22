import 'package:meta/meta.dart';
import 'dart:convert';

class DecorationsList {
  List<DecorationsListElement> decorationsList;

  DecorationsList({
    required this.decorationsList,
  });

  factory DecorationsList.fromRawJson(String str) => DecorationsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DecorationsList.fromJson(Map<String, dynamic> json) => DecorationsList(
    decorationsList: List<DecorationsListElement>.from(json["decorations_list"].map((x) => DecorationsListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "decorations_list": List<dynamic>.from(decorationsList.map((x) => x.toJson())),
  };
}

class DecorationsListElement {
  int id;
  String name;
  String location;
  String categories;
  int ownerId;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  DecorationsListElement({
    required this.id,
    required this.name,
    required this.location,
    required this.categories,
    required this.ownerId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DecorationsListElement.fromRawJson(String str) => DecorationsListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DecorationsListElement.fromJson(Map<String, dynamic> json) => DecorationsListElement(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    categories: json["categories"],
    ownerId: json["owner_ID"],
    image: json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "categories": categories,
    "owner_ID": ownerId,
    "image": image,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
