part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends BaseEvent {
  const ForgotPasswordEvent();
}

class PasswordResetEvent extends ForgotPasswordEvent {
  const PasswordResetEvent({
    required this.email,
  });

  final String? email;

  @override
  List<Object?> get props => [email];
}
