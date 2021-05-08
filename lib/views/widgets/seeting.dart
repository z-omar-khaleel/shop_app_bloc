import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_cubit.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopAppStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (ShopAppCubit.get(context).shopProfile == null)
          ShopAppCubit.get(context).getProfileData();
        return ConditionalBuilder(
          condition: ShopAppCubit.get(context).shopProfile != null,
          builder: (c) => buildSetting(context, state),
          fallback: (c) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget buildSetting(context, state) {
    final name = TextEditingController();
    final email = TextEditingController();
    final phone = TextEditingController();
    final data = ShopAppCubit.get(context).shopProfile;
    final updateData = ShopAppCubit.get(context).shopModelUpdateProfile;

    name.text = data.data.name;
    email.text = data.data.email;
    phone.text = data.data.phone;

    if (state is UpdateProfileSuccess) {
      name.text = updateData.data.name;
      email.text = updateData.data.email;
      phone.text = updateData.data.phone;
    }
    return state is UpdateProfileLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateProfileLoading)
                    Column(
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            ShopAppCubit.get(context).updateProfile(
                                name: name.text,
                                phone: phone.text,
                                email: email.text);
                          },
                          child: Text('Edit Profile')))
                ],
              ),
            ),
          );
  }
}
