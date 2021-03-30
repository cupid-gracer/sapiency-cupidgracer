import 'package:flutter/material.dart';

class SapiencyTheme {

  static Color get backgroundColor => const Color.fromRGBO(250, 251, 251, 1);
  static Color get borderColor => const Color.fromRGBO(223, 224, 223, 0.5);
  static Color get errorColor => Colors.redAccent;
  static Color get hintColor => const Color.fromRGBO(151, 167, 172, 1);
  static Color get fontColor => const Color.fromRGBO(92, 118, 125, 1);
  static String get fontFamily => "Axiforma";
  static Color get primaryColor => const Color.fromRGBO(255, 114, 97, 1);
  static Color get secondaryColor => const Color.fromRGBO(255, 148, 100, 1);

  static ThemeData getTheme(BuildContext context) => ThemeData(
      accentColor: SapiencyTheme.secondaryColor,
      backgroundColor: SapiencyTheme.backgroundColor,
      brightness: Brightness.light,
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          colorScheme: Theme.of(context).colorScheme.copyWith(secondary: SapiencyTheme.primaryColor),
          height: 50,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
          ),
          textTheme: ButtonTextTheme.accent,
      ),
      focusColor: SapiencyTheme.primaryColor,
      fontFamily: SapiencyTheme.fontFamily,
      hintColor: SapiencyTheme.hintColor,
      primaryColor: SapiencyTheme.primaryColor,
      primarySwatch: Colors.deepOrange,
      textTheme: TextTheme(
        bodyText2: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: SapiencyTheme.fontColor),
        caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: SapiencyTheme.fontColor),
        headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: const Color.fromRGBO(22, 58, 69, 1)),
        headline4: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: SapiencyTheme.primaryColor),
        subtitle1: TextStyle(fontSize: 15, fontWeight: FontWeight.w400, color: SapiencyTheme.fontColor),
        subtitle2: TextStyle(fontSize: 12, fontWeight: FontWeight.w200, color: SapiencyTheme.fontColor),
      )
  );

}
