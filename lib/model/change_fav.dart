import 'dart:convert';

ShopModelChangeFav shopModelChangeFavFromJson(String str) =>
    ShopModelChangeFav.fromJson(json.decode(str));

String shopModelChangeFavToJson(ShopModelChangeFav data) =>
    json.encode(data.toJson());

class ShopModelChangeFav {
  ShopModelChangeFav({
    this.status,
    this.message,
  });

  bool status;
  String message;

  factory ShopModelChangeFav.fromJson(Map<String, dynamic> json) =>
      ShopModelChangeFav(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
