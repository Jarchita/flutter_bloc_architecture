import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../../exports/utilities.dart';

part 'localization_event.dart';
part 'localization_state.dart';

/// Purpose : business logic component for localization
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationBlocState> {
  LocalizationBloc()
      : super(const LatestLocalizationState(
            currentLocale: Locale(DataConstants.defaultLocaleLanguageCode,
                DataConstants.defaultLocaleLanguageCode))) {
    _onEvent();
  }

  static String tag = "LocalizationBloc";


  /// Purpose :  on event handler
  void _onEvent() {
    ///fetch locale event handler
    on<FetchLocaleEvent>((event, emit) async {
      final locale = await _fetchLocale();
      emit(LatestLocalizationState(currentLocale: locale));
    });

    ///update locale event handler
    on<UpdateLocaleEvent>((event, emit) async {
      final result = await _updateLocale(
          languageCode: event.languageCode, countryCode: event.countryCode);
      if (result) {
        add(FetchLocaleEvent());
      }
    });
  }

  ///method to fetch locale from local storage
  Future<Locale> _fetchLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return Locale(
        prefs.getString(PrefKeys.localeLanguageCode) ??
            DataConstants.defaultLocaleLanguageCode,
        prefs.getString(PrefKeys.localeCountryCode) ??
            DataConstants.defaultLocaleCountryCode);
  }

  ///method to update locale to local storage
  Future<bool> _updateLocale(
      {required String languageCode, String? countryCode}) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await prefs.setString(
        PrefKeys.localeLanguageCode,
        languageCode,
      );
      await prefs.setString(
        PrefKeys.localeCountryCode,
        countryCode ?? "",
      );
      return true;
    } catch (e) {
      Logger.e(tag, e);
      return false;
    }
  }
}
