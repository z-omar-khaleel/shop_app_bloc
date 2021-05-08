import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/observer/shop_app_register_states.dart';
import 'package:flutter_advance_abd/services/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit(ShopRegisterStates initialState) : super(initialState);

  static ShopRegisterCubit get(context) =>
      BlocProvider.of<ShopRegisterCubit>(context);
  void userRegister({
    @required String email,
    @required String password,
    @required String phone,
    @required String name,
  }) {
    emit(ShopRegisterLoadingState());

    register(
      {'email': email, 'password': password, 'phone': phone, 'name': name},
    ).then((value) {
      print(value.message);
      print('zecr3rt3o');
      emit(ShopRegisterSuccessState(value));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(ShopChangePasswordVisibilityState());
  }
}
