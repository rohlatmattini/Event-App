
import 'dart:convert';

class OrderList {
  List<OrderListElement> orderList;

  OrderList({
    required this.orderList,
  });

  factory OrderList.fromRawJson(String str) => OrderList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    orderList: List<OrderListElement>.from(json["order_list"].map((x) => OrderListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "order_list": List<dynamic>.from(orderList.map((x) => x.toJson())),
  };
}

class OrderListElement {
  int id;
  int userId;
  int people;
  DateTime date;
  String category;
  int hallId;
  int totalPrice;
  int complete;
  DateTime createdAt;
  DateTime updatedAt;

  OrderListElement({
    required this.id,
    required this.userId,
    required this.people,
    required this.date,
    required this.category,
    required this.hallId,
    required this.totalPrice,
    required this.complete,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderListElement.fromRawJson(String str) => OrderListElement.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory OrderListElement.fromJson(Map<String, dynamic> json) => OrderListElement(
    id: json["id"],
    userId: json["user_ID"],
    people: json["people"],
    date: DateTime.parse(json["date"]),
    category: json["category"],
    hallId: json["hall_ID"],
    totalPrice: json["total_price"],
    complete: json["complete"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_ID": userId,
    "people": people,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "category": category,
    "hall_ID": hallId,
    "total_price": totalPrice,
    "complete": complete,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}


