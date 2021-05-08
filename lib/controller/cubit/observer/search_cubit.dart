import 'package:bloc/bloc.dart';
import 'package:flutter_advance_abd/controller/cubit/observer/search_states.dart';
import 'package:flutter_advance_abd/model/search_model.dart';
import 'package:flutter_advance_abd/services/http.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit(SearchStates initialState) : super(initialState);
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
  ShopModelSearchProduct searchResult;

  search(String txt) {
    emit(LoadingStateSearch());
    searchApi(txt).then((value) {
      if (value.status) {
        searchResult = value;
        emit(SuccessStateSearch());
      } else {
        emit(ErrorStateSearch());
      }
    }).catchError((error) {
      print('errssssssor $error');
      emit(ErrorStateSearch());
    });
  }
}
