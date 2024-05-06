import 'package:equatable/equatable.dart';

import '../../exports/constants.dart';
import '../../exports/models.dart';
import '../../exports/utilities.dart';
import '../../services/service_locator.dart';
import '../base/base_bloc.dart';
import '../login/login_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends BaseBloc {
  SignUpBloc() : super(InitialState()) {
    _onEvent();
  }

  /// Purpose : on event handler
  void _onEvent() {

    on<SignUpUser>((event, emit) async {
      emit(const LoadingState());
      //signup then login in background
      await locator<LoginBloc>().saveLoginInfo(event.email);
      emit(const LoadingState(isLoading: false));
      emit(SuccessState(data: event.email));
      return;
    });
  }

  static String tag = "SignUpBloc";
}
