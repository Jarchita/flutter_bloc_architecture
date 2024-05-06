part of 'profile_bloc.dart';

abstract class ProfileEvent extends BaseEvent {
  const ProfileEvent();
}

class GetProfileEvent extends ProfileEvent {
  const GetProfileEvent();

  @override
  List<Object?> get props => [];
}

class ChangePasswordEvent extends ProfileEvent {
  const ChangePasswordEvent({
    required this.current,
    required this.newPass,
  });

  final String? current;
  final String? newPass;

  @override
  List<Object?> get props => [current, newPass];
}
