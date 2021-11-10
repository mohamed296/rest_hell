import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Color(0xffAEE1E1),
    secondary: Color(0xffFCD1D1),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Color(0xFF343F56), fontSize: 14.0),
    button: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      padding: const EdgeInsets.all(16.0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white.withOpacity(0.1),
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: const IconThemeData(color: Color(0xffAEE1E1)),
    centerTitle: true,
    elevation: 0,
    titleTextStyle: const TextStyle(
        color: Color(0xFF343F56), fontSize: 18.0, fontWeight: FontWeight.bold),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: Color(0xffAEE1E1),
    indicatorSize: TabBarIndicatorSize.tab,
    unselectedLabelColor: Colors.grey,
    indicator: BoxDecoration(),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0xffAEE1E1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    elevation: 4,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Color(0xffAEE1E1),
    enableFeedback: true,
    showUnselectedLabels: true,
    showSelectedLabels: true,
  ),
);
