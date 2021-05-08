import 'dart:convert';

import 'package:flutter_advance_abd/main.dart';
import 'package:flutter_advance_abd/model/change_fav.dart';
import 'package:flutter_advance_abd/model/get_fav.dart';
import 'package:flutter_advance_abd/model/register_model.dart';
import 'package:flutter_advance_abd/model/search_model.dart';
import 'package:flutter_advance_abd/model/shop_model_category.dart';
import 'package:flutter_advance_abd/model/shop_model_home.dart';
import 'package:flutter_advance_abd/model/shop_model_profile.dart';
import 'package:flutter_advance_abd/model/show_model_auth.dart';
import 'package:flutter_advance_abd/model/update_profil_model.dart';
import 'package:flutter_advance_abd/services/share_pref.dart';
import 'package:http/http.dart' as http;

Future<ShopModelAuth> login(Map<String, dynamic> data) async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/login');
  final res = await http.post(cleanUrl,
      headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      body: json.encode(data));
  if (res.statusCode > 400) {
    throw (shopModelFromJson(res.body).message);
  }
  if (!shopModelFromJson(res.body).status) {
    print('${shopModelFromJson(res.body).message} ggg');
    throw (shopModelFromJson(res.body).message);
  }
  return shopModelFromJson(res.body);
}

Future<ShopModelRegister> register(Map<String, dynamic> data) async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/register');
  final res = await http.post(cleanUrl,
      headers: {'lang': 'ar', 'Content-Type': 'application/json'},
      body: json.encode(data));
  if (res.statusCode > 400) {
    throw (shopModelFromJson(res.body).message);
  }
  if (!shopModelFromJson(res.body).status) {
    print('${shopModelFromJson(res.body).message} ggg');
    throw (shopModelFromJson(res.body).message);
  }
  return shopModelRegisterFromJson(res.body);
}

Future<ShopModelHome> getHomeApi() async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/home');
  final res = await http.get(cleanUrl, headers: {
    'lang': 'en',
    'Content-Type': 'application/json',
    'Authorization': await SharePref.getData(key: 'token')
  });
  if (res.statusCode > 400) {
    throw ('Error Occur');
  }
  print(token);
  return shopModelHomeFromJson(res.body);
}

Future<ShopModelCategory> getCategoryApi() async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/categories');
  final res = await http.get(
    cleanUrl,
    headers: {
      'lang': 'en',
    },
  );
  if (res.statusCode > 400) {
    throw ('Error Occur');
  }
  return shopModelCategoryFromJson(res.body);
}

Future<ShopModelChangeFav> postChangeFav(int productId) async {
  print(productId);
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/favorites');
  final res = await http.post(cleanUrl,
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': await SharePref.getData(key: 'token')
      },
      body: json.encode({"product_id": productId}));
  if (res.statusCode > 400) {
    throw ('Error Occur');
  }
  print(res.body);
  print(await SharePref.getData(key: 'token'));
  return shopModelChangeFavFromJson(res.body);
}

Future<ShopModelGetFav> getFav() async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/favorites');
  final res = await http.get(cleanUrl, headers: {
    'lang': 'en',
    'Content-Type': 'application/json',
    'Authorization': await SharePref.getData(key: 'token')
  });
  if (res.statusCode > 400) {
    throw ('Error Occur');
  }
  return shopModelGetFavFromJson(res.body);
}

Future<ShopModelGetProfile> getProfile() async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/profile');
  final res = await http.get(cleanUrl, headers: {
    'lang': 'en',
    'Content-Type': 'application/json',
    'Authorization': await SharePref.getData(key: 'token')
  });
  if (res.statusCode > 400) {
    throw ('Error Occur');
  }
  return shopModelGetProfileFromJson(res.body);
}

Future<ShopModelUpdateProfile> updateProfileApi(
    Map<String, dynamic> data) async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/update-profile');
  final res = await http.put(cleanUrl,
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': await SharePref.getData(key: 'token')
      },
      body: jsonEncode(data));
  if (res.statusCode > 400) {
    print(res.statusCode);
    print('status Error');
    throw ('Error Occur');
  }
  return shopModelUpdateProfileFromJson(res.body);
}

Future<ShopModelSearchProduct> searchApi(String txt) async {
  var cleanUrl = Uri.parse('https://student.valuxapps.com/api/products/search');
  final res = await http.post(cleanUrl,
      headers: {
        'lang': 'en',
        'Content-Type': 'application/json',
        'Authorization': await SharePref.getData(key: 'token')
      },
      body: jsonEncode({"text": txt}));
  if (res.statusCode > 400) {
    print(res.statusCode);
    print('status Error');
    throw ('Error Occur');
  }
  print(res.body);
  return shopModelSearchProductFromJson(res.body);
}
