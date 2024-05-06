part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends BaseEvent {
  const SignUpEvent();
}

class SignUpUser extends SignUpEvent {
  const SignUpUser({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'SignUpUser { email: $email, password: $password }';
}
