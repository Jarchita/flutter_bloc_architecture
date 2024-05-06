part of 'profile_bloc.dart';

abstract class ProfileState extends BaseState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileSuccessState extends ProfileState {
  const ProfileSuccessState({
    this.data,
  });

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}
