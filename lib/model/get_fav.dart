// To parse this JSON data, do
//
//     final shopModelGetFav = shopModelGetFavFromJson(jsonString);

import 'dart:convert';

ShopModelGetFav shopModelGetFavFromJson(String str) =>
    ShopModelGetFav.fromJson(json.decode(str));

String shopModelGetFavToJson(ShopModelGetFav data) =>
    json.encode(data.toJson());

class ShopModelGetFav {
  ShopModelGetFav({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  dynamic message;
  Data data;

  factory ShopModelGetFav.fromJson(Map<String, dynamic> json) =>
      ShopModelGetFav(
        status: json["status"] ?? false,
        message: json["message"] ?? '',
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  var currentPage;
  List<Datum> data;
  String firstPageUrl;
  var from;
  var lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  var perPage;
  dynamic prevPageUrl;
  var to;
  var total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    this.id,
    this.product,
  });

  var id;
  Product product;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product.toJson(),
      };
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  var id;
  var price;
  var oldPrice;
  var discount;
  String image;
  String name;
  String description;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
        oldPrice: json["old_price"] == null ? null : json["old_price"],
        discount: json["discount"] != null ? json["discount"] : null,
        image: json["image"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
        "old_price": oldPrice,
        "discount": discount,
        "image": image,
        "name": name,
        "description": description,
      };
}
