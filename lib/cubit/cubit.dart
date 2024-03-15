
import 'package:bloc/bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/cubit/states.dart';





class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }



}
