import 'package:meta/meta.dart';
import 'dart:convert';

class CarList {
  List<CarsList> carsList;

  CarList({
    required this.carsList,
  });

  factory CarList.fromRawJson(String str) => CarList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarList.fromJson(Map<String, dynamic> json) => CarList(
    carsList: List<CarsList>.from(json["cars_list"].map((x) => CarsList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cars_list": List<dynamic>.from(carsList.map((x) => x.toJson())),
  };
}

class CarsList {
  int id;
  String name;
  String model;
  int rentPrice;
  String image;
  int ownerId;
  String plateNumber;
  DateTime createdAt;
  DateTime updatedAt;

  CarsList({
    required this.id,
    required this.name,
    required this.model,
    required this.rentPrice,
    required this.image,
    required this.ownerId,
    required this.plateNumber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarsList.fromRawJson(String str) => CarsList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CarsList.fromJson(Map<String, dynamic> json) => CarsList(
    id: json["id"],
    name: json["name"],
    model: json["model"],
    rentPrice: json["rent_price"],
    image: json["image"],
    ownerId: json["owner_ID"],
    plateNumber: json["plate_number"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "model": model,
    "rent_price": rentPrice,
    "image": image,
    "owner_ID": ownerId,
    "plate_number": plateNumber,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}