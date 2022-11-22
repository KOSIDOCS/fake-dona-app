import 'package:fake_dona_app/core/custom_colors.dart';
import 'package:fake_dona_app/core/typography_theme.dart';
import 'package:fake_dona_app/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getThemeData({required ThemeTab selectedTab}) {
  switch (selectedTab) {
    case ThemeTab.light:
      return themeLight;
    case ThemeTab.dark:
      return themeDark;
    case ThemeTab.black:
      return themeBlack;    
    default:
      return themeLight;
  }
}

final ThemeData themeLight = buildLightTheme();

ThemeData buildLightTheme() {
  TextStyle _builtTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  UnderlineInputBorder _buildBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: _buildBorder(const Color(0xFF9d7fff)),
      errorBorder: _buildBorder(Colors.red),
      focusedBorder: _buildBorder(const Color(0xFF9d7fff)),
      disabledBorder: _buildBorder(const Color(0xFF9d7fff)),
      errorStyle: _builtTextStyle(Colors.red),
      labelStyle: _builtTextStyle(const Color(0xFF9d7fff)),
      helperStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      hintStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      prefixStyle: _builtTextStyle(BrandColors.kBrandSecondary),
    ),
    backgroundColor: const Color(0xFFeeeff1),
    scaffoldBackgroundColor: BrandColors.kBrandPureWhite,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: BrandColors.kBrandPureWhite,
      selectedItemColor: BrandColors.kBrandPureWhite,
      unselectedItemColor: BrandColors.kBrandSecondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: BrandColors.kBrandPureWhite,
      iconTheme: IconThemeData(
        color: BrandColors.kBrandSecondary,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: BrandColors.kBrandPureWhite,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    iconTheme: const IconThemeData(
      color: BrandColors.kBrandSecondary,
    ),
    cardColor: Colors.grey[100],
    canvasColor: BrandColors.kBrandPureWhite,
    brightness: Brightness.light,
    primaryColor: BrandColors.kBrandPureWhite,
    buttonTheme: const ButtonThemeData(
      buttonColor: BrandColors.kBrandSecondary,
      disabledColor: BrandColors.kBrandPureWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: BrandColors.kBrandPureWhite,
      ),
    ),
    dialogBackgroundColor: BrandColors.kBrandPureWhite,
    textTheme: textThemeLight(base.textTheme),
    primaryTextTheme: Typography().black,
    colorScheme: const ColorScheme.light(
      primary: BrandColors.kBrandSecondary,
      surface: BrandColors.kBrandPureWhite,
      background: BrandColors.kBrandPureWhite,
      brightness: Brightness.light,
    ),
  );
}

final ThemeData themeDark = buildDarkTheme();

ThemeData buildDarkTheme() {
  TextStyle _builtTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  UnderlineInputBorder _buildBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: _buildBorder(BrandColors.kBrandPureWhite),
      errorBorder: _buildBorder(Colors.red),
      focusedBorder: _buildBorder(BrandColors.kBrandSecondary),
      disabledBorder: _buildBorder(BrandColors.kBrandPureWhite),
      errorStyle: _builtTextStyle(Colors.red),
      labelStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      helperStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      hintStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      prefixStyle: _builtTextStyle(BrandColors.kBrandSecondary),
    ),
    backgroundColor: BrandColors.kBrandSecondary,
    scaffoldBackgroundColor: const Color(0xFF292c38),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: BrandColors.kBrandPureWhite,
      selectedItemColor: BrandColors.kBrandPureWhite,
      unselectedItemColor: BrandColors.kBrandSecondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: BrandColors.kBrandPureWhite,
      iconTheme: IconThemeData(
        color: BrandColors.kBrandSecondary,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: BrandColors.kBrandPureWhite,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    iconTheme: const IconThemeData(
      //color: BrandColors.kBrandTextDark,
      color: Color(0xFFd8d8d8),
    ),
    cardColor: const Color(0xFF0b2742),
    canvasColor: BrandColors.kBrandPureWhite,
    brightness: Brightness.light,
    primaryColor: BrandColors.kBrandPureWhite,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF97959B),
      disabledColor: BrandColors.kBrandPureWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: BrandColors.kBrandPureWhite,
      ),
    ),
    dialogBackgroundColor: BrandColors.kBrandPureWhite,
    textTheme: textThemeDark(base.textTheme),
    primaryTextTheme: Typography().black,
    colorScheme: const ColorScheme.dark(
      primary: BrandColors.kBrandSecondary,
      surface: BrandColors.kBrandPureWhite,
      background: BrandColors.kBrandPureWhite,
      brightness: Brightness.light,
    ),
  );
}

final ThemeData themeBlack = buildBlackTheme();

ThemeData buildBlackTheme() {
  TextStyle _builtTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  UnderlineInputBorder _buildBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.circular(8.0),
    );
  }

  final ThemeData base = ThemeData.dark();
  return base.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      enabledBorder: _buildBorder(BrandColors.kBrandPureWhite),
      errorBorder: _buildBorder(Colors.red),
      focusedBorder: _buildBorder(BrandColors.kBrandSecondary),
      disabledBorder: _buildBorder(BrandColors.kBrandPureWhite),
      errorStyle: _builtTextStyle(Colors.red),
      labelStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      helperStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      hintStyle: _builtTextStyle(BrandColors.kBrandSecondary),
      prefixStyle: _builtTextStyle(BrandColors.kBrandSecondary),
    ),
    backgroundColor: BrandColors.kBrandSecondary,
    scaffoldBackgroundColor: BrandColors.kBrandSecondary,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: BrandColors.kBrandPureWhite,
      selectedItemColor: BrandColors.kBrandPureWhite,
      unselectedItemColor: BrandColors.kBrandSecondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: BrandColors.kBrandPureWhite,
      iconTheme: IconThemeData(
        color: BrandColors.kBrandSecondary,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: BrandColors.kBrandPureWhite,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    iconTheme: const IconThemeData(
      //color: BrandColors.kBrandTextDark,
      color: Color(0xFFd8d8d8),
    ),
    cardColor: const Color(0xFF0b2742),
    canvasColor: BrandColors.kBrandPureWhite,
    brightness: Brightness.light,
    primaryColor: BrandColors.kBrandPureWhite,
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFF97959B),
      disabledColor: BrandColors.kBrandPureWhite,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: BrandColors.kBrandPureWhite,
      ),
    ),
    dialogBackgroundColor: BrandColors.kBrandPureWhite,
    textTheme: textThemeDark(base.textTheme),
    primaryTextTheme: Typography().black,
    colorScheme: const ColorScheme.dark(
      primary: BrandColors.kBrandSecondary,
      surface: BrandColors.kBrandPureWhite,
      background: BrandColors.kBrandPureWhite,
      brightness: Brightness.light,
    ),
  );
}