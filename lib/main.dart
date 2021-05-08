import 'dart:io';

import 'package:connectivity_platform_interface/src/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/services/share_pref.dart';
import 'package:flutter_advance_abd/utils/theme/app_theme.dart';
import 'package:flutter_advance_abd/views/screens/login.dart';
import 'package:flutter_advance_abd/views/screens/main_screen.dart';
import 'package:flutter_advance_abd/views/screens/on_boarding.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controller/cubit/observer/observer.dart';

String token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Widget widget;
  token = await SharePref.getData(key: 'token');
  bool isBoarding = await SharePref.getData(key: 'isBoarding') ?? false;
  Bloc.observer = MyBlocObserver();

  if (!isBoarding) {
    widget = OnBoardingScreen();
  } else {
    if (token != null)
      widget = MainPageScreen();
    else
      widget = ShopLoginScreen();
  }
  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({this.widget});
  getResult() async {
    final result = await InternetAddress.lookup('google.com');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopAppCubit(InitialAppState())
        ..getHomeData()
        ..getCategoryData()
        ..initConnectivity()
        ..getFaviourte()
        ..getProfileData(),
      child: BlocConsumer<ShopAppCubit, ShopAppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          bool isConnect = false;
          final ConnectivityResult connectionState =
              ShopAppCubit.get(context).result;

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightMode,
            home: connectionState == ConnectivityResult.mobile ||
                    connectionState == ConnectivityResult.wifi
                ? widget
                : state is InternetConnectError
                    ? Scaffold(
                        body: Center(
                          child: Text('No Internet Connection'),
                        ),
                      )
                    : widget,
          );
        },
      ),
    );
  }
}
