import 'package:flutter_advance_abd/model/register_model.dart';
import 'package:flutter_advance_abd/model/show_model_auth.dart';

abstract class ShopRegisterStates {}

class InitialRegisterState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {
  final ShopModelRegister shopModel;

  ShopRegisterSuccessState(this.shopModel);
}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String message;

  ShopRegisterErrorState(this.message);
}

class ShopChangePasswordVisibilityState extends ShopRegisterStates {}
