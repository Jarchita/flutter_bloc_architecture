import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../exports/resources.dart';

import '../resources/app_colors.dart';
import '../resources/app_fonts.dart';

/// Purpose : This is a style helper file, it is used to,
/// - Used to store the various style settings
/// - appTheme is the main theme for the whole application
///   Note: do not change the theme for the main app

final ThemeData appTheme = ThemeData(
  fontFamily: AppFonts.fontName,
  primaryColor: AppColors.primary,
  hintColor: AppColors.hint,
  appBarTheme: const AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: AppFonts.fontName,
      color: AppColors.primary,
      fontSize: 22,
      fontWeight: AppFonts.bold,
    ),
    iconTheme: IconThemeData(color: AppColors.secondary),
    systemOverlayStyle: SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: Colors.transparent, // For both Android + iOS
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  ),
  /* inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(fontSize: 16, color: AppColors.hint),
    labelStyle: TextStyle(fontSize: 18, color: AppColors.primary),
    errorStyle: TextStyle(fontSize: 10, color: AppColors.accentRed),
  ),
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 28, color: AppColors.primary, fontWeight: FontWeight.w400),
  ),*/
  dividerColor: Colors.grey,
);
