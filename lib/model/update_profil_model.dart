// To parse this JSON data, do
//
//     final shopModelUpdateProfile = shopModelUpdateProfileFromJson(jsonString);

import 'dart:convert';

ShopModelUpdateProfile shopModelUpdateProfileFromJson(String str) =>
    ShopModelUpdateProfile.fromJson(json.decode(str));

String shopModelUpdateProfileToJson(ShopModelUpdateProfile data) =>
    json.encode(data.toJson());

class ShopModelUpdateProfile {
  ShopModelUpdateProfile({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  Data data;

  factory ShopModelUpdateProfile.fromJson(Map<String, dynamic> json) =>
      ShopModelUpdateProfile(
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
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.points,
    this.credit,
    this.token,
  });

  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        points: json["points"],
        credit: json["credit"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "points": points,
        "credit": credit,
        "token": token,
      };
}
