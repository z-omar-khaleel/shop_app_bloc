import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/services/share_pref.dart';
import 'package:flutter_advance_abd/utils/navigation/navigate.dart';
import 'package:flutter_advance_abd/views/screens/login.dart';
import 'package:flutter_advance_abd/views/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final refApp = ShopAppCubit.get(context);
        return Scaffold(
          body: refApp.screens[refApp.index],
          appBar: AppBar(
            title: Text('Main Page'),
            actions: [
              IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () async {
                    ShopAppCubit.get(context).logout(context);
                  }),
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    refApp.getHomeData();
                    pushNav(context, SearchScreen());
                  })
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: [...refApp.barItems],
            onTap: (index) {
              refApp.changeCurrentIndex(index);
            },
            currentIndex: refApp.index,
          ),
        );
      },
    );
  }
}
