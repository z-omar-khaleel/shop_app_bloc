import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_applogin_states.dart';
import 'package:flutter_advance_abd/services/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit(ShopLoginStates initialState) : super(initialState);

  static ShopLoginCubit get(context) =>
      BlocProvider.of<ShopLoginCubit>(context);
  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());

    login(
      {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.message);
      print('zecr3rt3o');
      emit(ShopLoginSuccessState(value));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
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
