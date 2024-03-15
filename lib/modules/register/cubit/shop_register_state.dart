
import 'package:mansour7/models/shop_Login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterIconVisibility extends ShopRegisterStates{}




class ShopRegisterLodingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates
{
  final ShopLoginModel registerModel;
  ShopRegisterSuccessState(this.registerModel);
}
class ShopRegisterErrorState extends ShopRegisterStates{
  // final String error;
  // ShopRegisterErrorState(this.error);
}


