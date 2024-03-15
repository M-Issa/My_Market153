import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/search_model.dart';
import 'package:mansour7/modules/search/cubit/search_states.dart';

import '../../../consts/constant.dart';
import '../../../consts/end_points.dart';
import '../../../shared/network/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=>BlocProvider.of(context);

  SearchModel? model;
  void shopSearch(String text) {
    emit(SearchLodingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
        // the key comes from database (update favorite by id)
      },
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      print(token);
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }

}

