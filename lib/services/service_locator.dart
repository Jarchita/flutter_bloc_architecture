import 'package:get_it/get_it.dart';

import '../blocs/base/base_bloc.dart';
import '../blocs/forgot_password/forgot_password_bloc.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/localization/localization_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/notification/notification_bloc.dart';
import '../blocs/profile/profile_bloc.dart';
import '../blocs/signup/sign_up_bloc.dart';
import '../ui/router/app_router.dart';
import 'api/api_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerSingleton(() => AppRouter())

    // Services
    ..registerLazySingleton(() => ApiService())

    // Repos
    ..registerLazySingleton(() => BaseBloc(InitialState()))
    ..registerLazySingleton(() => LocalizationBloc())
    ..registerLazySingleton(() => LoginBloc())
    ..registerFactory(() => SignUpBloc())


    ..registerFactory(() => HomeBloc())
    ..registerFactory(() => ProfileBloc())
    ..registerFactory(() => ForgotPasswordBloc())
    ..registerFactory(() => NotificationBloc());
}
