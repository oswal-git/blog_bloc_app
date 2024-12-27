import 'package:blog_bloc_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    //
    appBarTheme: AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
      foregroundColor: AppPallete.whiteColor,
      elevation: 0.0,
      centerTitle: true,
    ),
    //
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppPallete.whiteColor, fontSize: 32.0, fontWeight: FontWeight.bold), // headline1
      displayMedium: TextStyle(color: AppPallete.whiteColor, fontSize: 28.0, fontWeight: FontWeight.bold), // headline2
      displaySmall: TextStyle(color: AppPallete.whiteColor, fontSize: 24.0, fontWeight: FontWeight.bold), // headline3
      headlineLarge: TextStyle(color: AppPallete.whiteColor, fontSize: 20.0, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppPallete.whiteColor, fontSize: 18.0, fontWeight: FontWeight.bold), // headline4
      headlineSmall: TextStyle(color: AppPallete.whiteColor, fontSize: 14.0, fontWeight: FontWeight.bold), // headline5
      titleLarge: TextStyle(color: AppPallete.whiteColor, fontSize: 20.0, fontWeight: FontWeight.normal), // headline6
      titleMedium: TextStyle(color: AppPallete.whiteColor, fontSize: 18.0, fontWeight: FontWeight.normal), // subtitle1
      titleSmall: TextStyle(color: AppPallete.whiteColor, fontSize: 16.0, fontWeight: FontWeight.normal), // subtitle2
      bodyLarge: TextStyle(color: AppPallete.whiteColor, fontSize: 18.0, fontWeight: FontWeight.normal), // bodyText1
      bodyMedium: TextStyle(color: AppPallete.whiteColor, fontSize: 16.0, fontWeight: FontWeight.normal), // bodyText2
    ),
    //
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    //
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
    //
  );

  // end class
}
