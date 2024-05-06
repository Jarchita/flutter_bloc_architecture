import 'dart:io';

import 'package:flutter/material.dart';

import '../../exports/resources.dart';
import '../../resources/app_styles.dart';


/// Purpose : common button used throughout the application
Widget appCommonButton({
  required String btnTxt,
  required VoidCallback? onPressed,
  bool isButtonEnabled = true,
  bool isNegative = false,
  Color? color,
  double? height,
  double? minWidth,
  double? fontSize,
  FontWeight? fontWeight,
}) =>
    MaterialButton(
        height: height ?? AppStyles.primaryButtonHeight,
        minWidth: minWidth,
        disabledElevation: 0,
        shape: RoundedRectangleBorder(
          side: isNegative
              ? const BorderSide(color: AppColors.border)
              : BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        elevation: 0,
        splashColor: Platform.isIOS ? Colors.transparent : Colors.white10,
        highlightColor: Colors.transparent,
        color: isNegative ? const Color(0xffF5F5F5) : AppColors.accentGreen,
        disabledColor: AppColors.disabled,
        disabledTextColor: AppColors.white,
        onPressed: isButtonEnabled ? onPressed : null,
        child: Text(
          btnTxt,
          style: TextStyle(
            color: isNegative ? AppColors.secondary : Colors.white,
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.bold,
          ),
        ));


/// Purpose : rounded button used throughout the application
Widget appCommonRoundedButton({
  required String btnTxt,
  required VoidCallback onPressed,
  bool isButtonEnabled = true,
}) =>
    MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        height: 38,
        // disabledElevation: 0,
        elevation: 2,
        splashColor: Platform.isIOS ? Colors.transparent : Colors.white10,
        //highlightColor: Colors.transparent,
        color: isButtonEnabled ? AppColors.primary : AppColors.disabled,
        onPressed: isButtonEnabled ? onPressed : null,
        disabledColor: AppColors.disabled,
        child: Text(
          btnTxt,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: AppFonts.regular,
          ),
        ));


/// Purpose : This is used to provide normal button.
Widget appNormalButton(
        {required Function onPress,
        required String buttonTitle,
        required bool isEnabled,
        Color? backgroundColor,
        TextStyle? textStyle,
        Color? textColor,
        double? height}) =>
    ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ButtonStyle(
        minimumSize:
            MaterialStateProperty.all(Size(double.infinity, height ?? 45)),
        textStyle: MaterialStateProperty.all(textStyle ?? TextStyle()),
        backgroundColor: isEnabled
            ? MaterialStateProperty.all(backgroundColor ?? AppColors.hint)
            : MaterialStateProperty.all(AppColors.hint),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(color: textColor ?? AppColors.white),
      ),
    );



/// Purpose : This is a app border button which will be used to show border
/// button.
Widget appBorderButton(
        {required Function onPress,
        required String buttonTitle,
        required bool isEnabled,
        double? borderRadius,
        double? borderWidth,
        TextStyle? textStyle,
        Color? borderColor,
        Color? textColor,
        double? height}) =>
    ElevatedButton(
      onPressed: () {
        onPress();
      },
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size(double.infinity, 45)),
        textStyle: MaterialStateProperty.all(textStyle ?? TextStyle()),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 3)),
            side: BorderSide(
                color:
                    isEnabled ? borderColor ?? AppColors.black : AppColors.hint,
                width: borderWidth ?? 1))),
        backgroundColor: MaterialStateProperty.all(AppColors.transparent),
        elevation: MaterialStateProperty.all(0),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
      ),
      child: Text(
        buttonTitle,
        style: TextStyle(color: textColor ?? AppColors.black),
      ),
    );

