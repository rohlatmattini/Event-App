import 'package:meta/meta.dart';
import 'dart:convert';

class UserInfo {
  List<User> user;

  UserInfo({
    required this.user,
  });

  factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": List<dynamic>.from(user.map((x) => x.toJson())),
  };
}

class User {
  int id;
  String name;
  String email;
  dynamic emailVerifiedAt;
  String mobileNumber;
  String role;
  int balance;
  DateTime createdAt;
  DateTime updatedAt;

  User({
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

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
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
