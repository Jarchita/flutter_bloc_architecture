import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../blocs/login/login_bloc.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../router/app_router.dart';

/// Purpose : This is a splash widget. it will be launched first when app
/// get started.

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with UtilityMixin {
  static String tag = "SplashScreen";

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), _doRedirection);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // executes after build
      _checkActiveLocale();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: AppStyles.loginBgDecoration,

          // child: Image.asset(
          //   AppAssets.imgSplash,
          //   fit: BoxFit.cover,
          // ),
        ),
      );

  /// Purpose : This method is used to do redirection from splash screen.
  Future<void> _doRedirection() async {
    late String route;
    if (await BlocProvider.of<LoginBloc>(context).isLogged()) {
      route = RouteConstants.homeRoute;
    } else {
      route = RouteConstants.loginRoute;
    }
    clearStackAndAddNamedRoute(context, route);
    // clearStackAndAddNamedRoute(context, RouteConstants.homeRoute);
  }

  void _checkActiveLocale() {
    final activeLocale = Localizations.localeOf(context);
    Logger.d(tag, "Active Locale languageCode : ${activeLocale.languageCode}");
    Logger.d(tag, "Active Locale countryCode : ${activeLocale.countryCode}");
  }
}
