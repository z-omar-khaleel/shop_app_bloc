import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightMode = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    primaryColor: Colors.deepOrange,
    primarySwatch: Colors.deepOrange,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange),
    textTheme:
        TextTheme(bodyText1: TextStyle(fontSize: 16, color: Colors.black87)),
    appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: Colors.white,
        backwardsCompatibility: false,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.light)),
    scaffoldBackgroundColor: Colors.white);
final ThemeData darkMode = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      enabledBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      errorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      focusedErrorBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    ),
    scaffoldBackgroundColor: Colors.black54,
    textTheme:
        TextTheme(bodyText1: TextStyle(fontSize: 16, color: Colors.white)),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.black54,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black54,
            statusBarBrightness: Brightness.dark)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black54,
        unselectedLabelStyle: TextStyle(color: Colors.white),
        showUnselectedLabels: true,
        unselectedItemColor: Colors.black54,
        selectedItemColor: Colors.deepOrange),
    primaryColor: Colors.black54);
