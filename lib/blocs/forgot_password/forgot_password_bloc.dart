import '../base/base_bloc.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends BaseBloc {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    _onEvent();
  }

  static String tag = "ForgotPasswordBloc";

  void _onEvent() {
    on<PasswordResetEvent>((event, emit) async {

    });
  }
}
