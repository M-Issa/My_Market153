import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import 'colors.dart';

///// dark theme
ThemeData darkTheme = ThemeData(
  primarySwatch: shopPrimaryColor,
  appBarTheme: AppBarTheme(
    backgroundColor: HexColor('333739'),
    foregroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    elevation: 40,
    selectedItemColor: shopPrimaryColor,
    unselectedItemColor: Colors.blueGrey,
    type: BottomNavigationBarType.fixed,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Janna'
);

/////////// light theme
ThemeData lightTheme=ThemeData(
  primarySwatch:Colors.blue,
  iconTheme: IconThemeData(color: Colors.lightGreen,),
  progressIndicatorTheme: ProgressIndicatorThemeData(refreshBackgroundColor: Colors.blue),
  appBarTheme: const AppBarTheme(
    scrolledUnderElevation: 0,
   // backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    color:Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 20,
    selectedItemColor: shopPrimaryColor,
    type: BottomNavigationBarType.fixed,
    selectedIconTheme: IconThemeData(
      fill: .50,
    ),
  ),
  textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w200,
        color: Colors.black,
      )),
  fontFamily: 'Janna',
);