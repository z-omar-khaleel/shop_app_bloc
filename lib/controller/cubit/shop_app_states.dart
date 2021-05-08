import 'package:flutter_advance_abd/model/change_fav.dart';

abstract class ShopAppStates {}

class InitialAppState extends ShopAppStates {}

class ChangeCurrentIndexState extends ShopAppStates {}

class HomePageSuccessState extends ShopAppStates {}

class HomePageLoadingsState extends ShopAppStates {}

class HomePageErrorState extends ShopAppStates {
  final String message;

  HomePageErrorState({this.message});
}

class CategoryPageLoadingsState extends ShopAppStates {}

class CategoryPageErrorState extends ShopAppStates {
  final String message;

  CategoryPageErrorState({this.message});
}

class CategoryPageSuccessState extends ShopAppStates {}

class InternetConnectSuccess extends ShopAppStates {}

class InternetConnectError extends ShopAppStates {
  final String message;

  InternetConnectError(this.message);
}

class InternetConnectLoading extends ShopAppStates {}

class ChangeFavState extends ShopAppStates {}

class ChangeFavDataState extends ShopAppStates {
  final ShopModelChangeFav dataState;

  ChangeFavDataState(this.dataState);
}

class ChangeFavErrorState extends ShopAppStates {}

class GetFavLoading extends ShopAppStates {}

class GetFavSuccess extends ShopAppStates {}

class GetFavError extends ShopAppStates {}

class GetProfileLoading extends ShopAppStates {}

class GetProfileSuccess extends ShopAppStates {}

class GetProfileError extends ShopAppStates {}

class UpdateProfileLoading extends ShopAppStates {}

class UpdateProfileSuccess extends ShopAppStates {}

class UpdateProfileError extends ShopAppStates {}
