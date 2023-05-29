import 'package:flutter/material.dart';
import 'package:book_app/theme/color.dart';

// String gilroyFontFamily = "Gilroy";

ThemeData themeData = ThemeData(
  // fontFamily: gilroyFontFamily,

  visualDensity: VisualDensity.adaptivePlatformDensity,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.selectedColor,
    secondary: AppColors.secondary,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: AppColors.selectedColor,
      foregroundColor: AppColors.filledColor,
    ),
  ),
  appBarTheme: const AppBarTheme(
    titleTextStyle: TextStyle(
      color: AppColors.selectedColor,
      fontSize: 23,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
  ),
  iconTheme: const IconThemeData(
    color: AppColors.selectedColor,
    size: 28,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.selectedColor,
    textTheme: ButtonTextTheme.normal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: AppColors.selectedColor,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.titleMedium,
    ),
    titleSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelLarge: TextStyle(
      color: AppColors.selectedColor,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: TextStyle(
      color: AppColors.selectedColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: AppColors.selectedColor),
    labelStyle: const TextStyle(color: AppColors.selectedColor),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.selectedColor),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.selectedColor),
        borderRadius: BorderRadius.circular(10)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.selectedColor),
        borderRadius: BorderRadius.circular(10)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.selectedColor),
        borderRadius: BorderRadius.circular(10)),
  ),
  dropdownMenuTheme: DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
    ),
  ),
);
