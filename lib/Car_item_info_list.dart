import 'package:meta/meta.dart';
import 'dart:convert';

class CarInfolist {
  List<CarsInfo> carsInfo;

  CarInfolist({
    required this.carsInfo,
  });

  factory CarInfolist.fromRawJson(String str) => CarInfolist.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarInfolist.fromJson(Map<String, dynamic> json) => CarInfolist(
    carsInfo: List<CarsInfo>.from(json["cars_info"].map((x) => CarsInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cars_info": List<dynamic>.from(carsInfo.map((x) => x.toJson())),
  };
}

class CarsInfo {
  int id;
  String name;
  String model;
  double rentPrice;
  String image;
  int ownerId;
  String plateNumber;
  double rating;
  DateTime createdAt;
  DateTime updatedAt;
  Owner owner;

  CarsInfo({
    required this.id,
    required this.name,
    required this.model,
    required this.rentPrice,
    required this.image,
    required this.ownerId,
    required this.plateNumber,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
  });

  factory CarsInfo.fromRawJson(String str) => CarsInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarsInfo.fromJson(Map<String, dynamic> json) => CarsInfo(
    id: json["id"],
    name: json["name"],
    model: json["model"],
    rentPrice: double.parse(json["rent_price"].toString()),
    image: json["image"],
    ownerId: json["owner_ID"],
    plateNumber: json["plate_number"],
    rating: double.parse(json["rating"].toString()),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    owner: Owner.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "model": model,
    "rent_price": rentPrice,
    "image": image,
    "owner_ID": ownerId,
    "plate_number": plateNumber,
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
