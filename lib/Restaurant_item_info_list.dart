import 'package:meta/meta.dart';
import 'dart:convert';

class RestaurantInfoList {
  List<RestaurantItemList> restaurantItemList;

  RestaurantInfoList({
    required this.restaurantItemList,
  });

  factory RestaurantInfoList.fromRawJson(String str) => RestaurantInfoList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantInfoList.fromJson(Map<String, dynamic> json) => RestaurantInfoList(
    restaurantItemList: List<RestaurantItemList>.from(json["restaurantItemList"].map((x) => RestaurantItemList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "restaurantItemList": List<dynamic>.from(restaurantItemList.map((x) => x.toJson())),
  };
}

class RestaurantItemList {
  int id;
  String name;
  String location;
  String categories;
  int ownerId;
  String image;
  double rating;
  DateTime createdAt;
  DateTime updatedAt;
  Owner owner;

  RestaurantItemList({
    required this.id,
    required this.name,
    required this.location,
    required this.categories,
    required this.ownerId,
    required this.image,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
  });

  factory RestaurantItemList.fromRawJson(String str) => RestaurantItemList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RestaurantItemList.fromJson(Map<String, dynamic> json) => RestaurantItemList(
    id: json["id"],
    name: json["name"],
    location: json["location"],
    categories: json["categories"],
    ownerId: json["owner_ID"],
    image: json["image"],
    rating: double.parse(json["rating"].toString()),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "location": location,
    "categories": categories,
    "owner_ID": ownerId,
    "image": image,
    "rating": rating,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "owner": owner.toJson(),
  };
}

class Owner {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String mobileNumber;
  String role;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;

  Owner({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.mobileNumber,
    required this.role,
    required this.balance,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Owner.fromRawJson(String str) => Owner.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    mobileNumber: json["mobile_number"],
    role: json["role"],
    balance: json["balance"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "mobile_number": mobileNumber,
    "role": role,
    "balance": balance,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
