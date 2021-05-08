import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_advance_abd/controller/cubit/shop_app_states.dart';
import 'package:flutter_advance_abd/model/get_fav.dart';
import 'package:flutter_advance_abd/model/shop_model_category.dart';
import 'package:flutter_advance_abd/model/shop_model_home.dart';
import 'package:flutter_advance_abd/model/shop_model_profile.dart';
import 'package:flutter_advance_abd/model/update_profil_model.dart';
import 'package:flutter_advance_abd/services/http.dart';
import 'package:flutter_advance_abd/services/share_pref.dart';
import 'package:flutter_advance_abd/utils/navigation/navigate.dart';
import 'package:flutter_advance_abd/views/screens/login.dart';
import 'package:flutter_advance_abd/views/widgets/category.dart';
import 'package:flutter_advance_abd/views/widgets/faviourte.dart';
import 'package:flutter_advance_abd/views/widgets/product.dart';
import 'package:flutter_advance_abd/views/widgets/seeting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopAppCubit extends Cubit<ShopAppStates> {
  int index = 0;

  ShopAppCubit(ShopAppStates initialState) : super(initialState);
  List<Widget> screens = [
    ProductScreen(),
    CategoryScreen(),
    FavouriteScreen(),
    SettingsScreen()
  ];
  Map<int, bool> changeFaviourte = {};

  List<BottomNavigationBarItem> barItems = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ' Favourite'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  static ShopAppCubit get(context) => BlocProvider.of<ShopAppCubit>(context);
  ShopModelHome shopModelHome;
  ShopModelCategory shopModelCategory;
  ShopModelGetFav shopModelGetFav;
  changeCurrentIndex(int indexNew) {
    index = indexNew;
    emit(ChangeCurrentIndexState());
  }

  getHomeData() async {
    emit(HomePageLoadingsState());

    getHomeApi().then((value) {
      if (value.status) {
        shopModelHome = value;
        value.data.products.forEach((element) {
          changeFaviourte.addAll({element.id: element.inFavorites});
        });
        emit(HomePageSuccessState());
      } else {
        emit(HomePageErrorState());
      }
    }).catchError((error) {
      emit(HomePageErrorState(message: error.toString()));
    });
  }

  Future getCategoryData() async {
    emit(CategoryPageLoadingsState());
    getCategoryApi().then((value) {
      if (value.status) {
        shopModelCategory = value;
        print(value.data);
        emit(CategoryPageSuccessState());
      } else {
        emit(CategoryPageErrorState());
      }
    }).catchError((error) {
      print('/*/*/**errrrroe/**/');
      emit(CategoryPageErrorState(message: error.toString()));
    });
  }

  ConnectivityResult result = ConnectivityResult.none;
  Future<ConnectivityResult> initConnectivity() async {
    final Connectivity _connectivity = Connectivity();

    // Platform messages may fail, so we use a try/catch PlatformException.
    emit(InternetConnectLoading());
    try {
      result = await _connectivity.checkConnectivity();
      emit(InternetConnectSuccess());
    } on PlatformException catch (e) {
      print(e.toString());
      emit(InternetConnectError('Platform Error'));
    }
    _connectivity.onConnectivityChanged.listen((conResult) {
      result = conResult;
      if (conResult == ConnectivityResult.wifi ||
          conResult == ConnectivityResult.mobile) {
        emit(InternetConnectSuccess());
      } else {
        emit(InternetConnectError('No Internet Connection'));
      }
    });
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    return result;
  }

  changeFav(int productId) async {
    changeFaviourte[productId] = !changeFaviourte[productId];
    emit(ChangeFavState());
    postChangeFav(productId).then((value) async {
      if (value.status) {
        await getFaviourte();
        emit(ChangeFavDataState(value));
      } else {
        changeFaviourte[productId] = !changeFaviourte[productId];
        emit(ChangeFavErrorState());
      }
    }).catchError((error) {
      emit(ChangeFavErrorState());
    });
  }

  getFaviourte() async {
    emit(GetFavLoading());
    getFav().then((value) {
      print(' value $value');
      if (value.status) {
        shopModelGetFav = value;
        emit(GetFavSuccess());
      } else {
        print('erreo');
        emit(GetFavError());
      }
    }).catchError((error) {
      print('erreo $error');
      emit(GetFavError());
    });
  }

  ShopModelGetProfile shopProfile;

  getProfileData() async {
    emit(GetProfileLoading());
    getProfile().then((value) {
      if (value.status) {
        shopProfile = value;
        emit(GetProfileSuccess());
      } else {
        print('erreo profile');
        emit(GetProfileError());
      }
    }).catchError((error) {
      print('erreo $error');
      emit(GetFavError());
    });
  }

  logout(context) {
    SharePref.removeKey('isLogin').then((value) {
      shopProfile = null;
      shopModelCategory = null;
      shopModelGetFav = null;
      shopModelHome = null;

      if (value) pushNavAndReplace(context, ShopLoginScreen());
    });
  }

  ShopModelUpdateProfile shopModelUpdateProfile;
  updateProfile(
      {@required String name, @required String phone, @required String email}) {
    emit(UpdateProfileLoading());
    updateProfileApi({'phone': phone, 'name': name, 'email': email})
        .then((value) {
      if (value.status) {
        shopModelUpdateProfile = value;
        emit(UpdateProfileSuccess());
      } else {
        emit(UpdateProfileError());
      }
    }).catchError((error) => emit(UpdateProfileError()));
  }
}
