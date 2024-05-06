part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends BaseState {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}
