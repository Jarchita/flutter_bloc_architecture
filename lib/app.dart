import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/blocs/login/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_router.dart';
import 'blocs/localization/localization_bloc.dart';
import 'exports/app_localizations.dart';
import 'exports/themes.dart';
import 'services/service_locator.dart';
import 'ui/screens/splash/splash_screen.dart';

/// Purpose : This is a my app here, we have define material
/// app with theme and route.
/// added localization
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => locator<LocalizationBloc>(),
        ),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationBlocState>(
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: (state as LatestLocalizationState).currentLocale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            // 'en' is the language code. We could optionally provide a
            // a country code as the second param, e.g.
            // Locale('en', 'US'). If we do that, we may want to
            // provide an additional app_en_US.arb file for
            // region-specific translations.
            Locale('en', ''),
            // Locale('ar', ''), update the locale here
          ],
          theme: appTheme,
          onGenerateRoute: AppRouter().generateRoute,
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
