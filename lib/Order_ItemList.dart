import 'dart:convert';

class OrderItemList {
    List<Item> decorationItems;
    List<Item> restaurantItems;

    OrderItemList({
        required this.decorationItems,
        required this.restaurantItems,
    });

    factory OrderItemList.fromRawJson(String str) => OrderItemList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory OrderItemList.fromJson(Map<String, dynamic> json) => OrderItemList(
        decorationItems: List<Item>.from(json["Decoration items"].map((x) => Item.fromJson(x))),
        restaurantItems: List<Item>.from(json["Restaurant items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "Decoration items": List<dynamic>.from(decorationItems.map((x) => x.toJson())),
        "Restaurant items": List<dynamic>.from(restaurantItems.map((x) => x.toJson())),
    };
}

class Item {
    int id;
    int orderId;
    int itemId;
    int quantity;
    int price;
    DateTime createdAt;
    DateTime updatedAt;
    ItemClass item;

    Item({
        required this.id,
        required this.orderId,
        required this.itemId,
        required this.quantity,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
        required this.item,
    });

    factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_ID"],
        itemId: json["item_ID"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        item: ItemClass.fromJson(json["item"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_ID": orderId,
        "item_ID": itemId,
        "quantity": quantity,
        "price": price,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "item": item.toJson(),
    };
}

class ItemClass {
    int id;
    String name;
    String locationType;
    int locationId;
    int price;
    int quantity;
    String imageUrl;
    DateTime createdAt;
    DateTime updatedAt;

    ItemClass({
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

    factory ItemClass.fromRawJson(String str) => ItemClass.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ItemClass.fromJson(Map<String, dynamic> json) => ItemClass(
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
