// To parse this JSON data, do
//
//     final shopModelGetProfile = shopModelGetProfileFromJson(jsonString);

import 'dart:convert';

ShopModelGetProfile shopModelGetProfileFromJson(String str) =>
    ShopModelGetProfile.fromJson(json.decode(str));

String shopModelGetProfileToJson(ShopModelGetProfile data) =>
    json.encode(data.toJson());

class ShopModelGetProfile {
  ShopModelGetProfile({
    this.status,
    this.data,
  });

  bool status;
  Data data;

  factory ShopModelGetProfile.fromJson(Map<String, dynamic> json) =>
      ShopModelGetProfile(
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
