import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../exports/app_localizations.dart';

import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';

/// Purpose : navigation tab item enum
enum BottomTabItem { home, profile }

/// Purpose : hash map for tab name
Map<BottomTabItem, String> tabName(BuildContext context) => {
      BottomTabItem.home:
          AppLocalizations.of(context)?.tabLblHome ?? AppStrings.tabLblHome,
      BottomTabItem.profile: AppLocalizations.of(context)?.tabLblProfile ??
          AppStrings.tabLblProfile,
    };


/// Purpose : Bottom navigation widget
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({required this.screens, Key? key}) : super(key: key);

  final List<Widget> screens;

  @override
  State<BottomNavigation> createState() => BottomNavigationState();
}

class BottomNavigationState extends State<BottomNavigation> {
  BottomTabItem currentTab = BottomTabItem.home;

  PersistentTabController? controller = PersistentTabController();

  void selectTab(BottomTabItem tabItem) {
    setState(() {
      if (currentTab != tabItem) {
        currentTab = tabItem;
        controller?.jumpToTab(tabItem.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) => PersistentTabView(
        context,
        controller: controller,
        onWillPop: (context) async {
          if (currentTab != BottomTabItem.home) {
            selectTab(BottomTabItem.home);
            return false;
          } else {
            return true;
          }
        },
        backgroundColor: AppColors.secondary,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
          ),
        ),
        navBarStyle: NavBarStyle.style9,
        items: [
          _buildItem(tabItem: BottomTabItem.home, icon: AppAssets.icHome),
          _buildItem(tabItem: BottomTabItem.profile, icon: AppAssets.icProfile),
        ],
        onItemSelected: (index) => selectTab(
          BottomTabItem.values[index],
        ),
        screens: widget.screens,
      );

  PersistentBottomNavBarItem _buildItem(
      {required BottomTabItem tabItem, required String icon}) {
    final text = tabName(context)[tabItem]!;
    return PersistentBottomNavBarItem(
      activeColorPrimary: const Color.fromARGB(30, 167, 169, 172),
      activeColorSecondary: AppColors.accentGreen,
      title: text,
      textStyle: TextStyle(
          color: _colorTabMatching(item: tabItem),
          fontSize: 13,
          fontWeight: AppFonts.semiBold),
      icon: SvgPicture.asset(
        icon,
        height: 15,
        color: _colorTabMatching(item: tabItem),
      ),
      // label: text,
    );
  }

  /// Purpose : get selected tab icon color
  Color _colorTabMatching({required BottomTabItem item}) =>
      currentTab == item ? AppColors.accentGreen : AppColors.white;
}
