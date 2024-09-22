import 'package:meta/meta.dart';
import 'dart:convert';

class HallitemInfo {
  List<HallInfo> hallInfo;

  HallitemInfo({
    required this.hallInfo,
  });

  factory HallitemInfo.fromRawJson(String str) => HallitemInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HallitemInfo.fromJson(Map<String, dynamic> json) => HallitemInfo(
    hallInfo: List<HallInfo>.from(json["hall_info"].map((x) => HallInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "hall_info": List<dynamic>.from(hallInfo.map((x) => x.toJson())),
  };
}

class HallInfo {
  int id;
  String name;
  int ownerId;
  String location;
  int maxNum;
  String categories;
  String imageUrl;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> images;
  Owner owner;

  HallInfo({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.location,
    required this.maxNum,
    required this.categories,
    required this.imageUrl,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
    required this.owner,
  });

  factory HallInfo.fromRawJson(String str) => HallInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HallInfo.fromJson(Map<String, dynamic> json) => HallInfo(
    id: json["id"],
    name: json["name"],
    ownerId: json["owner_ID"],
    location: json["location"],
    maxNum: json["max_num"],
    categories: json["categories"],
    imageUrl: json["image_url"],
    price: json["price"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    images: List<String>.from(json["images"].map((x) => x)),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "owner_ID": ownerId,
    "location": location,
    "max_num": maxNum,
    "categories": categories,
    "image_url": imageUrl,
    "price": price,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "images": List<dynamic>.from(images.map((x) => x)),
    "owner": owner.toJson(),
  };
}

class Owner {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  int mobileNumber;
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
