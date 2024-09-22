import 'dart:convert';

class OrderList {
  List<Order> order;

  OrderList({
    required this.order,
  });

  factory OrderList.fromRawJson(String str) => OrderList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    order: List<Order>.from(json["order"].map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order": List<dynamic>.from(order.map((x) => x.toJson())),
  };
}

class Order {
  int userId;
  DateTime date;
  String category;
  String people;
  bool complete;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Order({
    required this.userId,
    required this.date,
    required this.category,
    required this.people,
    required this.complete,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["user_ID"],
    date: DateTime.parse(json["date"]),
    category: json["category"],
    people: json["people"],
    complete: json["complete"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_ID": userId,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "category": category,
    "people": people,
    "complete": complete,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "id": id,
  };
}
