part of 'notification_bloc.dart';

abstract class NotificationState extends BaseState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  @override
  List<Object> get props => [];
}
