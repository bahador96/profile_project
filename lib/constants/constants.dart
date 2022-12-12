import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAppThemeConfig {
  static const String faPrimaryFontFamily = 'S';
  final Color primaryColor = Colors.pink.shade400;
  final Color primaryTextColor;
  final Color seconderyTextColor;
  final Color surfaceColor;
  final Color backgroundColor;
  final Color appBarColor;
  final Brightness brightness;

  MyAppThemeConfig.dark()
      : primaryTextColor = Colors.white,
        seconderyTextColor = Colors.white70,
        surfaceColor = const Color(0x0dffffff),
        backgroundColor = const Color.fromARGB(255, 30, 30, 30),
        appBarColor = Colors.black,
        brightness = Brightness.dark;

  MyAppThemeConfig.light()
      : primaryTextColor = Colors.grey.shade900,
        seconderyTextColor = Colors.grey.shade900.withOpacity(0.8),
        surfaceColor = const Color(0x0d000000),
        backgroundColor = Colors.white,
        appBarColor = const Color.fromARGB(255, 235, 235, 235),
        brightness = Brightness.light;

  ThemeData getTheme(String languageCode) {
    return ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: primaryColor,
        brightness: brightness,
        dividerColor: surfaceColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
        ),
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: appBarColor,
          foregroundColor: primaryTextColor,
        ),
        scaffoldBackgroundColor: backgroundColor,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: surfaceColor,
        ),
        textTheme: (languageCode == 'en')
            ? enPrimaryTextTextTheme
            : faPrimaryTextTheme);
  }

  TextTheme get enPrimaryTextTextTheme => GoogleFonts.latoTextTheme(TextTheme(
        bodyText2: TextStyle(
          color: primaryTextColor,
          fontSize: 15,
        ),
        bodyText1: TextStyle(
          fontSize: 15,
          color: seconderyTextColor,
        ),
        headline6:
            TextStyle(fontWeight: FontWeight.bold, color: primaryTextColor),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryTextColor,
        ),
      ));

  TextTheme get faPrimaryTextTheme => TextTheme(
      bodyText2: TextStyle(
        color: primaryTextColor,
        fontFamily: faPrimaryFontFamily,
        fontSize: 15,
        height: 1.5,
      ),
      bodyText1: TextStyle(
        fontSize: 15,
        height: 1.5,
        fontFamily: faPrimaryFontFamily,
        color: seconderyTextColor,
      ),
      caption: const TextStyle(fontFamily: faPrimaryFontFamily),
      headline6: TextStyle(
          fontWeight: FontWeight.bold, color: primaryTextColor, fontSize: 18),
      subtitle1: TextStyle(
        fontSize: 16,
        fontFamily: faPrimaryFontFamily,
        fontWeight: FontWeight.bold,
        color: primaryTextColor,
      ),
      button: const TextStyle(fontFamily: faPrimaryFontFamily));
}
