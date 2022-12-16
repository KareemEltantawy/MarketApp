import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/shared/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,  //false alashan aref aAdel fe el status bar
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white, // the same color as backgroundColor of the appbar
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  primarySwatch: defaultColor,  //haylwn el CircularProgressIndicator and floatingActionButton and the border of textformfield and TextButton and OutlinedButton(mesh haylwn el IconButton)
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      height: 1.2,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: Colors.white,
  ),
  fontFamily: 'Jannah', //the same neme of family we put in pubspec.yaml
);


ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor('333739'),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    titleSpacing: 20.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  primarySwatch: defaultColor,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      height: 1.2,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('333739'),
  ),
  fontFamily: 'Jannah',
);
