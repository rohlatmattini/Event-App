import 'dart:convert';

class OrderInfo {
    List<OrderInfoElement> orderInfo;

    OrderInfo({
        required this.orderInfo,
    });

    factory OrderInfo.fromRawJson(String str) => OrderInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderInfo.fromJson(Map<String, dynamic> json) => OrderInfo(
        orderInfo: List<OrderInfoElement>.from(json["order_info"].map((x) => OrderInfoElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_info": List<dynamic>.from(orderInfo.map((x) => x.toJson())),
    };
}

class OrderInfoElement {
    int id;
    int userId;
    int people;
    DateTime date;
    String category;
    int hallId;
    int carId;
    int totalPrice;
    int complete;
    DateTime createdAt;
    DateTime updatedAt;
    Hall hall;
    Car car;

    OrderInfoElement({
        required this.id,
        required this.userId,
        required this.people,
        required this.date,
        required this.category,
        required this.hallId,
        required this.carId,
        required this.totalPrice,
        required this.complete,
        required this.createdAt,
        required this.updatedAt,
        required this.hall,
        required this.car,
    });

    factory OrderInfoElement.fromRawJson(String str) => OrderInfoElement.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderInfoElement.fromJson(Map<String, dynamic> json) => OrderInfoElement(
        id: json["id"],
        userId: json["user_ID"],
        people: json["people"],
        date: DateTime.parse(json["date"]),
        category: json["category"],
        hallId: json["hall_ID"],
        carId: json["car_ID"],
        totalPrice: json["total_price"],
        complete: json["complete"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        hall: Hall.fromJson(json["hall"]),
        car: Car.fromJson(json["car"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_ID": userId,
        "people": people,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "category": category,
        "hall_ID": hallId,
        "car_ID": carId,
        "total_price": totalPrice,
        "complete": complete,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "hall": hall.toJson(),
        "car": car.toJson(),
    };
}

class Car {
    int id;
    String name;
    String model;
    int rentPrice;
    String image;
    int ownerId;
    String plateNumber;
    int rating;
    DateTime createdAt;
    DateTime updatedAt;

    Car({
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
    });

    factory Car.fromRawJson(String str) => Car.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        model: json["model"],
        rentPrice: json["rent_price"],
        image: json["image"],
        ownerId: json["owner_ID"],
        plateNumber: json["plate_number"],
        rating: json["rating"],
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
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}

class Hall {
    int id;
    String name;
    int ownerId;
    String location;
    int maxNum;
    String categories;
    String imageUrl;
    int price;
    double rating;
    DateTime createdAt;
    DateTime updatedAt;

    Hall({
        required this.id,
        required this.name,
        required this.ownerId,
        required this.location,
        required this.maxNum,
        required this.categories,
        required this.imageUrl,
        required this.price,
        required this.rating,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Hall.fromRawJson(String str) => Hall.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Hall.fromJson(Map<String, dynamic> json) => Hall(
        id: json["id"],
        name: json["name"],
        ownerId: json["owner_ID"],
        location: json["location"],
        maxNum: json["max_num"],
        categories: json["categories"],
        imageUrl: json["image_url"],
        price: json["price"],
        rating: json["rating"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
        "rating": rating,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
