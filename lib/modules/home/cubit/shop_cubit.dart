import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/models/categories_model.dart';
import 'package:mansour7/models/change_favorites_model.dart';
import 'package:mansour7/models/favorites_model.dart';
import 'package:mansour7/models/home_model.dart';
import 'package:mansour7/models/shop_login_model.dart';
import 'package:mansour7/modules/home/cubit/shop_state.dart';
import 'package:mansour7/modules/products/products_screen.dart';
import 'package:mansour7/shared/network/dio_helper.dart';

import '../../../consts/constant.dart';
import '../../../consts/end_points.dart';
import '../../categories/categories_screen.dart';

import '../../favorites/favorates_screen.dart';
import '../../settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  int currentIndex = 0;

  void changeNavBarIndex(index) {
    currentIndex = index;
    emit(ShopChangeNaveBarState());
  }

  bool isPassword = true;
  IconData suffix=Icons.visibility_outlined;

  void changeIconVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopCubitIconSettingVisibility());
  }

  /// get product screen informations
  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    //هنا لم نرسل استعلام لاننا نريد جميع البيانات
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data?.products.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });
      print(favorites.toString());
      //print(homeModel?.data?.products[0].image);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      emit(ShopErrorHomeDataState());
      print(error.toString());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    //هنا لم نرسل استعلام لاننا نريد جميع البيانات
    DioHelper.getData(
      url: GET_CATEGORIES,
      // token:  token,//no matter if not sent
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      print(categoriesModel?.data?.data[1].name);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      emit(ShopErrorCategoriesDataState());
      print(error.toString());
    });
  }

// function for add and delete item to favorites by its id
  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    print(changeFavoritesModel?.status);
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productId,
        // the key comes from database (update favorite by id)
      },
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(changeFavoritesModel?.status);
      print(changeFavoritesModel?.status);
      print(changeFavoritesModel?.message);
      print(token);
      if (changeFavoritesModel?.status != null) {
        if (!changeFavoritesModel!.status!){
          favorites[productId] = !favorites[productId]!;
        }else
          {
            getFavorites();
          }

      }
      print(changeFavoritesModel?.status);
      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopErrorChangeFavoritesDataState());
    });
    // }
  }

  FavoritesModel? favoritesModel;
  void getFavorites() {
    emit(ShopLoadingFavoritesDataState());
    DioHelper.getData(
      url: FAVORITES,
       token:  token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
     printFullText(value.data.toString());
      emit(ShopSuccessFavoritesDataState());
    }).catchError((error) {
      emit(ShopErrorFavoritesDataState());
      print(error.toString());
    });
  }

  ShopLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUserDataState());
    DioHelper.getData(
      url: GET_PROFILE,
      token:  token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //printFullText(value.data.toString());
      print(userModel?.data?.phone);
      emit(ShopSuccessGetUserDataState());
    }).catchError((error) {
      emit(ShopErrorGetUserDataState(error));
      print(error.toString());
    });
  }


  void updateUserData({
    required String name,
    required String email,
    required String phone,
}) {
    emit(ShopLoadingUpdateProfileDataState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token:  token,
      data:{
        'name':name,
         'email':email,
        'phone':phone,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      //printFullText(value.data.toString());
      print(userModel?.data?.phone);
      emit(ShopSuccessUpdateProfileDataState());
    }).catchError((error) {
      emit(ShopErrorUpdateProfileDataState(error));
      print(error.toString());
    });
  }



}
