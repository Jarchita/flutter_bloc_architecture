import 'package:flutter/material.dart';
import '../exports/resources.dart';

/// Purpose : place style specific constants over here
abstract class AppStyles {
  ///text styles
  static const appBarTitleTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 22,
    fontWeight: AppFonts.bold,
  );

  static const titleTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 22,
    fontWeight: AppFonts.bold,
  );

  static const commonHeaderTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 18,
    fontWeight: AppFonts.bold,
  );

  static const commonPrimaryTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 14,
    fontWeight: AppFonts.semiBold,
  );
  static const commonSecondaryTextStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 14,
    fontWeight: AppFonts.semiBold,
    fontFamily: AppFonts.fontName,
  );

  static const commonPrimaryLargeTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: AppFonts.semiBold,
  );
  static const commonSecondaryLargeTextStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 16,
    fontWeight: AppFonts.semiBold,
  );
  static const commonSecondarySmallTextStyle = TextStyle(
    color: AppColors.secondary,
    fontSize: 12,
    fontWeight: AppFonts.regular,
  );

  static const commonLabelsTextStyle = TextStyle(
    color: AppColors.btnLabel,
    fontSize: 14,
    fontWeight: AppFonts.semiBold,
  );
  static const commonLabelLightTextStyle = TextStyle(
    color: AppColors.disabled,
    fontSize: 14,
    fontWeight: AppFonts.semiBold,
  );

  static const commonLabelsUnderlineTextStyle = TextStyle(
    color: AppColors.txtPrimary,
    fontSize: 14,
    decoration: TextDecoration.underline,
    fontWeight: AppFonts.semiBold,
  );

  static const snackBarTextStyle = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    fontWeight: AppFonts.regular,
  );

  ///decoration
  static const loginBgDecoration = BoxDecoration(
    image: DecorationImage(
      image: AssetImage(
        AppAssets.imgLightBg,
      ),
      fit: BoxFit.cover,
    ),
  );

  ///text field
  static const txtFieldLabelStyle =
      TextStyle(color: AppColors.primary, fontSize: 13);
  static const txtFieldLoginScreenLabelStyle =
      TextStyle(color: Colors.white, fontSize: 13);

  ///common container
  static const commonContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(commonCornerRadius),
        topRight: Radius.circular(commonCornerRadius)),
  );

  static const commonRectContainer = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
    boxShadow: [Shadows.cardShadow],
  );

  ///borders
  static const tableHeaderCellDecoration = BoxDecoration(
      border: Border(
        right: BorderSide(
          color: AppColors.bg,
        ),
      ),
      color: AppColors.primary);

  ///dropdown styles
  static const dropdownHeight = 40;
  static const dropdownPadding = EdgeInsets.symmetric(horizontal: 10);
  static const dropdownBtnText = TextStyle(
    color: Colors.black,
    fontSize: 13,
  );
  static const dropdownMenuItemText = TextStyle(
    color: Colors.black,
    fontSize: 12,
  );

  ///other
  static const commonPadding = EdgeInsets.all(20);
  static const primaryButtonHeight = 55.0;
  static const commonCornerRadius = 25.0;
  static const commonCardCornerRadius = 5.0;
  static const pageSideMargin = 25.0;
}

class Shadows {
  static const BoxShadow cardShadow = BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.11),
    // spreadRadius: 2,
    blurRadius: 26,
    offset: Offset(0, 5),
  );

  static const BoxShadow primaryShadow = BoxShadow(
    color: Color.fromARGB(131, 0, 0, 0),
    offset: Offset(0, 2),
    blurRadius: 5,
  );
  static const BoxShadow secondaryShadow = BoxShadow(
    offset: Offset(0, -6),
    blurRadius: 10,
  );
  static const BoxShadow blueShadow = BoxShadow(
    color: Color.fromARGB(100, 82, 152, 216),
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 4),
  );

  static const BoxShadow greyShadow = BoxShadow(
    color: Color.fromARGB(50, 0, 0, 0),
    spreadRadius: 1,
    blurRadius: 5,
    offset: Offset(0, 4),
  );
  static const BoxShadow boxShadow = BoxShadow(
    color: Color.fromARGB(60, 0, 0, 0),
    spreadRadius: 2,
    blurRadius: 6,
  );
}
