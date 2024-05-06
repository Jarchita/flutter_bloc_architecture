import 'package:shared_preferences/shared_preferences.dart';


import '../../exports/constants.dart';
import '../base/base_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends BaseBloc {
  ProfileBloc() : super(ProfileInitial()) {
    _onEvent();
    add(const GetProfileEvent());
  }

  static String tag = "ProfileBloc";

  void _onEvent() {
    on<GetProfileEvent>((event, emit) async {

      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString(PrefKeys.userEmail);
      emit(ProfileSuccessState(
        data: email,
      ));
    });
  }
}
