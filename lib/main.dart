import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mansour7/modules/home/shop_layout_screen.dart';
import 'package:mansour7/modules/login/shop_login_screen.dart';
import 'package:mansour7/shared/bloc_observer.dart';
import 'package:mansour7/shared/local/cash_helper.dart';
import 'package:mansour7/shared/network/dio_helper.dart';
import 'consts/constant.dart';
import 'consts/styles/themes.dart';
import 'cubit/cubit.dart';
import 'cubit/theme_cubit.dart';
import 'cubit/theme_states.dart';
import 'modules/home/cubit/shop_cubit.dart';
import 'modules/onBoarding/on_boarding.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const SimpleBlocObserver();
  DioHelper.init();
  await CashHelper.init();
  Widget widget;
  bool? onBoarding=CashHelper.getData(key:'onBoarding',)??null;
  token=CashHelper.getData(key:'token',)!=null?CashHelper.getData(key:'token',):'';
  print('token11');
  print(token);
 if(onBoarding != null){
   if(token !=''){
     widget=ShopLayoutScreen();
   }else{
     widget=ShopLoginScreen();
   }
 }else{
   widget=OnBoardingScreen();
 }

  bool isDark=false;
  bool? isDark0 = CashHelper.getBoolean(key: 'isDark');
  if (isDark0 != null){
    isDark=isDark0;
  }else
    {
      isDark=true;
    }
  runApp(MyApp(isDark:isDark,startWidget:widget));
  // print('onBoarding is  $onBoarding');
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp({required this.isDark,required this.startWidget});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          ThemeCubit()..changeThemeMode(fromShared: isDark),
        ),
        BlocProvider(
          create: (context) => NewsCubit(),
        ),
        BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavorites()..getUserData(),
        ),
      ],
      child: BlocConsumer<ThemeCubit, ThemeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.light,
            home:startWidget,
          );
        },
      ),
    );
  }
}


