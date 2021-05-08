import 'package:flutter_advance_abd/model/show_model_auth.dart';

abstract class ShopLoginStates {}

class InitialLoginState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopModelAuth shopModel;

  ShopLoginSuccessState(this.shopModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String message;

  ShopLoginErrorState(this.message);
}

class ShopChangePasswordVisibilityState extends ShopLoginStates {}
