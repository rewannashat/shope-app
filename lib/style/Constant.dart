import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopp_app/layout/module/authorize/Login/Login/login-Screen.dart';

import '../shared/local/sharedPref.dart';
import '../widget-constant/constWidget.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.black,
          fontSize: 15.0,
        )),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      //Color(0xff558daa)
      elevation: 0,
     // backwardsCompatibility: false,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          color: Colors.black
        //  fontSize:  media.size.height * 0.03,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: insideLayout,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: insideLayout,
    )) ;
ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: HexColor('333739'),
    textTheme: TextTheme(
        bodyText1: TextStyle(
          color: Colors.white,
          fontSize: 15.0,
        )),
    appBarTheme: AppBarTheme(
      backgroundColor: HexColor('333739'),
      //Color(0xff558daa)
      elevation: 0,
    //  backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light),
      titleTextStyle: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
          color: Colors.white
        //  fontSize:  media.size.height * 0.03,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: insideLayout,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: insideLayout,
    )) ;

void printFullTextApi (String text) {
 final pattern = RegExp('.{1,800}');
 pattern.allMatches(text).forEach((element) => print(element.group(0)));
}
 // to logout
void removeAllLogout (BuildContext context) {
  SharedPrefrence.clearData(
      key: 'token' ,
  )!.then((value) {
     if (value) {
       NavAndRemove(
         ctx: context,
         screen: LoginScreen(),
       );
     }
  } );
}

 var token  ;

Color basicColor = Color(0xff189AB4) ;
Color insideLayout = Color(0xff2385dc);