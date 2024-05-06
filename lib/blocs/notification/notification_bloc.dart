import '../../exports/constants.dart';
import '../base/base_bloc.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends BaseBloc {
  NotificationBloc() : super(NotificationInitial()) {
    _onEvent();

  }

  static String tag = "NotificationBloc";

  void _onEvent() {

     }
}
