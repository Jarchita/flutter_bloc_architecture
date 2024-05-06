import 'package:flutter/material.dart';

import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/service_locator.dart';
import '../../widgets/notification_indicatior_button.dart';
import '../home/home_screen.dart';
import '../menu/side_menu.dart';
import '../notifications/notifications_screen.dart';
import '../profile/profile_screen.dart';
import 'bottom_navigation.dart';


/// Purpose :Base navigation container for the app home module
class HomeBaseScreen extends StatefulWidget {
  const HomeBaseScreen({this.showVerificationAlert = false, Key? key})
      : super(key: key);
  final bool showVerificationAlert;
  @override
  _HomeBaseScreenState createState() => _HomeBaseScreenState();
}

class _HomeBaseScreenState extends State<HomeBaseScreen> with UtilityMixin {
  late AppLocalizations? t;
  final GlobalKey<BottomNavigationState> navigationKey =
      GlobalKey<BottomNavigationState>();

  @override
  void initState() {
    locator<ApiService>().getHeadersAndAddLogInterceptor();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.showVerificationAlert) {
        _displayAlert();
      }
    });
    super.initState();
  }

  void _displayAlert() {
    CustomAlert().showInformativeDialog(
      context,
      title: t?.lblEmailSent ?? "",
      content: t?.magEmailSent ?? "",
      btnOkText: t?.lblOkay ?? "",
      // onWillPop: () async => true,
      icon: AppAssets.icFailure,
      onOkTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldKey,
        backgroundColor: AppColors.bg,
        drawer: SideMenu(navigateToTab: navigateToTab),
        body: BottomNavigation(
          key: navigationKey,
          screens: [
            HomeScreen(appBar: appBar(), navigateToTab: navigateToTab),
            ProfileScreen(
              appBar: appBar(),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget  appBar() => AppBar(
        title: const SizedBox(
height: 30,
child: Text("My App",style: TextStyle(color: AppColors.accentGreen),),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          NotificationIndicatorButton(
            onTap: () async {
              await navigationPush(context, const NotificationsScreen());
            },
            dotVisible: false,
          )
        ],
      );

  void navigateToTab(BottomTabItem tabItem) {
    navigationKey.currentState?.selectTab(tabItem);
  }
}
