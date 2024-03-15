
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/consts/constant.dart';
import 'package:mansour7/modules/Register/cubit/shop_Register_state.dart';
import '../../../consts/end_points.dart';
import '../../../models/shop_Login_model.dart';
import '../../../shared/network/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());
  ///ShopRegisterCubit(ShopRegisterStates x) : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  bool isPassword = true;
  IconData suffix=Icons.visibility_outlined;

  void changeIconVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterIconVisibility());
  }


  ///for Register data
  ShopLoginModel? registerModel;
  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(ShopRegisterLodingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
         'name':name,
        'email': email,
        'password': password,
         'phone' :phone,
      },
    ).then((value) {
      //print(value.data);
      if (value.data != null) {
        registerModel = ShopLoginModel.fromJson(value.data);
        pass=password;
        print (pass);
        // Use RegisterModel here
      } else {
        // Handle empty response or unexpected format
        emit(ShopRegisterErrorState());
      }
     //RegisterModel=ShopRegisterModel.fromJson(value.data);//this data don't mean same data in model
     // print(RegisterModel?.data?.name);
      //print(token);
      //token=(RegisterModel?.data?.token!=null?RegisterModel?.data?.token:null)!;
      emit(ShopRegisterSuccessState(registerModel!));
    });
        //.catchError((error) {
      //emit(ShopRegisterErrorState(error));
    //});
  }


}
