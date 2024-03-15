
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/consts/constant.dart';
import 'package:mansour7/modules/login/cubit/shop_login_state.dart';
import '../../../consts/end_points.dart';
import '../../../models/shop_login_model.dart';
import '../../../shared/network/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  ///ShopLoginCubit(ShopLoginStates x) : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix=Icons.visibility_outlined;

  void changeIconVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopLoginIconVisibility());
  }


  ///for login data
  ShopLoginModel? loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLodingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      //print(value.data);
      if (value.data != null) {
        loginModel = ShopLoginModel.fromJson(value.data);
        pass=password;
        print (pass);
        // Use loginModel here
      } else {
        // Handle empty response or unexpected format
        emit(ShopLoginErrorState());
      }
     //loginModel=ShopLoginModel.fromJson(value.data);//this data don't mean same data in model
     // print(loginModel?.data?.name);
      //print(token);
      //token=(loginModel?.data?.token!=null?loginModel?.data?.token:null)!;
      emit(ShopLoginSuccessState(loginModel!));
    });
        //.catchError((error) {
      //emit(ShopLoginErrorState(error));
    //});
  }


}
