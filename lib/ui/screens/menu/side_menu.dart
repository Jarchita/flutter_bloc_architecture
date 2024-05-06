import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../blocs/login/login_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../router/app_router.dart';
import '../about/about_us_screen.dart';
import '../home_base/bottom_navigation.dart';


/// Purpose : Side navigation menu of the app
class SideMenu extends StatelessWidget with UtilityMixin {
  const SideMenu({required this.navigateToTab, Key? key}) : super(key: key);
  final Function(BottomTabItem) navigateToTab;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Drawer(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AppAssets.imgLightBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 40, 30, 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///cancel icon
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: AppColors.disabled,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  ///menu
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 25),
                            child: Align(
                              alignment: Alignment.centerLeft,
                               child: SizedBox(
                                  // height: 30,
                                  child: Text("My App",style: TextStyle(fontSize:25,color: AppColors.accentGreen),),
                                )
                            ),
                          ),
                          // _getDivider(),
                          _createDrawerItem(
                              assetPath: AppAssets.icAbout,
                              text: AppLocalizations.of(context)?.lblAboutUs ??
                                  "",
                              onTap: () {
                                _navigate(context, const AboutUsScreen());
                              }),
                          _getDivider(),
                          _createDrawerItem(
                              assetPath: AppAssets.icContact,
                              text:
                                  AppLocalizations.of(context)?.lblContactUs ??
                                      "",
                              onTap: () {
                                // _navigate(context, const ContactUsScreen());
                              }),

                          _getDivider(),
                        ],
                      ),
                    ),
                  ),

                  ///logout
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      children: [
                        _getDivider(),
                        const SizedBox(
                          height: 15,
                        ),
                        _createDrawerItem(
                            assetPath: AppAssets.icLogout,
                            text: AppLocalizations.of(context)?.lblLogout ?? "",
                            onTap: () async {
                              await BlocProvider.of<LoginBloc>(context)
                                  .logout();
                              clearStackAndAddNamedRoute(
                                  context, RouteConstants.loginRoute);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _getDivider() => const Divider(
        color: Color(0xff1E1D2E),
      );

  Widget _createDrawerItem(
          {required String assetPath,
          required String text,
          required VoidCallback onTap}) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: SizedBox(
          height: 50,
          child: Row(
            children: <Widget>[
              SvgPicture.asset(
                assetPath,
                height: 20,
                width: 20,
                color: AppColors.accentGreen,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: AppFonts.semiBold,
                      color: AppColors.accentGreen),
                ),
              )
            ],
          ),
        ),
      );

  void _navigate(BuildContext context, Widget screen) {
    Navigator.of(context, rootNavigator: true).pop();
    navigationPush(context, screen);
  }
}
