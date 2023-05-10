import 'package:flutter/material.dart';

class AppColors {
  //One instance, needs factory
  static AppColors? _instance;
  factory AppColors() => _instance ??= AppColors._();

  AppColors._();

  static const selectedColor = Color(0xff1F1D1A);
  static const unSelectedColor = Color(0xffDAC5A7);
  static const primary = Color.fromARGB(255, 196, 120, 13);
// static const appbarColor = Color()
  static const secondary = Color(0xffFFFFFF);
  static const titleMedium = Color(0xff828282);
}
