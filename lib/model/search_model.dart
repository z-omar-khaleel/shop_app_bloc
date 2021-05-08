// To parse this JSON data, do
//
//     final shopModelSearchProduct = shopModelSearchProductFromJson(jsonString);

import 'dart:convert';

import 'get_fav.dart';

ShopModelSearchProduct shopModelSearchProductFromJson(String str) =>
    ShopModelSearchProduct.fromJson(json.decode(str));

String shopModelSearchProductToJson(ShopModelSearchProduct data) =>
    json.encode(data.toJson());

class ShopModelSearchProduct {
  ShopModelSearchProduct({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory ShopModelSearchProduct.fromJson(Map<String, dynamic> json) =>
      ShopModelSearchProduct(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.data,
    this.firstPageUrl,
    this.from,
    this.total,
  });

  var currentPage;
  List<Product> data;
  String firstPageUrl;
  var from;
  var lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  var perPage;
  String prevPageUrl;
  var to;
  var total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
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
