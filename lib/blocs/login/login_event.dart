part of 'login_bloc.dart';

abstract class LoginEvent extends BaseEvent {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed { email: $email, password: $password }';
}



class Logout extends LoginEvent {
  const Logout();
  @override
  List<Object> get props => [];
}
