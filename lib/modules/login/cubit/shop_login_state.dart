
import 'package:mansour7/models/shop_login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginIconVisibility extends ShopLoginStates{}




class ShopLoginLodingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel loginModel;
  ShopLoginSuccessState(this.loginModel);
}
class ShopLoginErrorState extends ShopLoginStates{
  // final String error;
  // ShopLoginErrorState(this.error);
}


