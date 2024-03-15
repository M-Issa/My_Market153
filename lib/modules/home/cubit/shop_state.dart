
import '../../../models/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}
class ShopChangeNaveBarState extends ShopStates{}


class ShopCubitIconSettingVisibility extends ShopStates{}
class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}

class ShopSuccessChangeFavoritesDataState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopSuccessChangeFavoritesDataState(this.model);
}
class ShopErrorChangeFavoritesDataState extends ShopStates{}


class ShopChangeState extends ShopStates{}


//get favorites
class ShopLoadingFavoritesDataState extends ShopStates{}
class ShopSuccessFavoritesDataState extends ShopStates{}
class ShopErrorFavoritesDataState extends ShopStates{}

//get userData
class ShopLoadingGetUserDataState extends ShopStates{}
class ShopSuccessGetUserDataState extends ShopStates
{
}
class ShopErrorGetUserDataState extends ShopStates{
  final String error;
  ShopErrorGetUserDataState(this.error);
}


///updat profile
class ShopLoadingUpdateProfileDataState extends ShopStates{}
class ShopSuccessUpdateProfileDataState extends ShopStates{}
class ShopErrorUpdateProfileDataState extends ShopStates{
  String error;
  ShopErrorUpdateProfileDataState(this.error);
}