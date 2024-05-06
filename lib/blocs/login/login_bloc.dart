
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/app_constants.dart';
import '../../exports/utilities.dart';
import '../base/base_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

/// Purpose : business logic component for login screen
class LoginBloc extends BaseBloc {
  LoginBloc() : super(InitialState()) {
    _onEvent();
  }

  static String tag = "LoginBloc";

  Future<void> _doLogin(
    Emitter<BaseState> emit, {
    required String email,
    required String password,

  }) async {
    await saveLoginInfo(email);
    emit(const LoadingState(isLoading: false));
    emit(SuccessState(data: email));
  }

  /// Purpose : on event handler
  void _onEvent() {
    ///on LoginButtonPressed event
    on<LoginButtonPressed>((event, emit) async {
      emit(const LoadingState());
      await _doLogin(emit,
          email: event.email,
          password: event.password);
      return;
    });

  }

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(PrefKeys.userEmail);
    if (email != null) {
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final provider = prefs.getString(PrefKeys.authProvider);
    Logger.d(tag, "$provider : Logged out successfully");
    await prefs.clear();
  }

  Future<void> saveLoginInfo(String email) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(PrefKeys.userEmail, email);
    } catch (e) {
      Logger.e(tag, e);
      rethrow;
    }
  }


}
