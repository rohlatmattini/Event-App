import 'package:meta/meta.dart';
import 'dart:convert';

class ItemList {
  List<Item> items;

  ItemList({
    required this.items,
  });

  factory ItemList.fromRawJson(String str) => ItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  int id;
  String name;
  String locationType;
  int locationId;
  int price;
  int quantity;
  String imageUrl;
  DateTime createdAt;
  DateTime updatedAt;

  Item({
    required this.id,
    required this.name,
    required this.locationType,
    required this.locationId,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    name: json["name"],
    locationType: json["location_type"],
    locationId: json["location_ID"],
    price: json["price"],
    quantity: json["quantity"],
    imageUrl: json["image_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location_type": locationType,
    "location_ID": locationId,
    "price": price,
    "quantity": quantity,
    "image_url": imageUrl,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
