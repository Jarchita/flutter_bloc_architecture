part of 'notification_bloc.dart';

abstract class NotificationEvent extends BaseEvent {
  const NotificationEvent();
}

class ClearNotificationEvent extends NotificationEvent {
  const ClearNotificationEvent();

  @override
  List<Object?> get props => [];
}
