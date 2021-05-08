// To parse this JSON data, do
//
//     final shopModelRegister = shopModelRegisterFromJson(jsonString);

import 'dart:convert';

ShopModelRegister shopModelRegisterFromJson(String str) =>
    ShopModelRegister.fromJson(json.decode(str));

String shopModelRegisterToJson(ShopModelRegister data) =>
    json.encode(data.toJson());

class ShopModelRegister {
  ShopModelRegister({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ShopModelRegister.fromJson(Map<String, dynamic> json) =>
      ShopModelRegister(
        status: json["status"],
        message: json["message"],
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
    this.name,
    this.phone,
    this.email,
    this.id,
    this.image,
    this.token,
  });

  String name;
  String phone;
  String email;
  int id;
  String image;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        image: json["image"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
        "id": id,
        "image": image,
        "token": token,
      };
}
