import '../../exports/constants.dart';
import '../../exports/utilities.dart';
import '../base/base_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends BaseBloc {
  HomeBloc() : super(HomeInitial()) {
    _onEvent();
  }
  static String tag = "HomeBloc";

  void _onEvent() {
  }
}
