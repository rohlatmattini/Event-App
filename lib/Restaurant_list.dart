import 'package:meta/meta.dart';
import 'dart:convert';

class ListRestaurants {
  List<RestaurantsList> restaurantsList;

  ListRestaurants({
    required this.restaurantsList,
  });

  factory ListRestaurants.fromRawJson(String str) => ListRestaurants.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ListRestaurants.fromJson(Map<String, dynamic> json) => ListRestaurants(
    restaurantsList: List<RestaurantsList>.from(json["restaurants_list"].map((x) => RestaurantsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurants_list": List<dynamic>.from(restaurantsList.map((x) => x.toJson())),
  };
}

class RestaurantsList {
  int id;
  String name;
  String location;
  String categories;
  int ownerId;
  String image;
  DateTime createdAt;
  DateTime updatedAt;

  RestaurantsList({
    required this.id,
    required this.name,
    required this.location,
    required this.categories,
    required this.ownerId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RestaurantsList.fromRawJson(String str) => RestaurantsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantsList.fromJson(Map<String, dynamic> json) => RestaurantsList(
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