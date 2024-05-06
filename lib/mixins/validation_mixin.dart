import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../exports/app_localizations.dart';


/// Purpose : mixin contains validation methods

mixin ValidationMixin {
  static const String _emailPattern =
      "[a-zA-Z0-9\\+\\._%\\-\\+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";

  static const String _passPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,15}$';

  // ^((?=.*\d)|(?=.*?[!@#\$&*~]))(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$

  /// email field validation
  String emailValidator(BuildContext context, String value) {
    final regExp = RegExp(_emailPattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyEmail ?? "";
    } else if (value.length > NumericConstants.emailLength) {
      return AppLocalizations.of(context)?.msgInValidEmail ?? "";
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)?.msgInValidEmail ?? "";
    } else {
      return "";
    }
  }

  ///common validation for required field
  String emptyPasswordValidator(BuildContext context, String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyPassword ?? "";
    }
    return "";
  }

  ///password Field pattern Validation
  String passwordValidator(BuildContext context, String value) {
    final regExp = RegExp(_passPattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyPassword ?? "";
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)?.msgInValidPassword ?? "";
    }
    return "";
  }

  ///confirm password Field Validation
  String confirmPasswordValidator(
      BuildContext context, String value, String password) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyConfirmPassword ?? "";
    } else if (value != password) {
      return AppLocalizations.of(context)?.msgInvalidConfirmPassword ?? "";
    }
    return "";
  }

  ///common validation for required field
  String emptyOldPasswordValidator(BuildContext context, String value) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyOldPassword ?? "";
    }
    return "";
  }

  String newPasswordValidator(BuildContext context, String value) {
    final regExp = RegExp(_passPattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyNewPassword ?? "";
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)?.msgInValidPassword ?? "";
    }
    return "";
  }

  ///confirm password Field Validation
  String confirmNewPasswordValidator(
      BuildContext context, String value, String password) {
    if (value.isEmpty) {
      return AppLocalizations.of(context)?.msgEmptyConfirmNewPassword ?? "";
    } else if (value != password) {
      return AppLocalizations.of(context)?.msgInvalidConfirmPassword ?? "";
    }
    return "";
  }


}
