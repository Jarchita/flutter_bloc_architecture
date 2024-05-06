import 'package:flutter/material.dart';

import '../../exports/resources.dart';

/// @Name: TabItem
/// @Created By: Jarchita Bhesaniya
///  enum for each tab item
enum TabItems {
  timeSheet,
  missedPunch,
  leave,
}

/// @Name: tabName
/// @Created By: Jarchita Bhesaniya
/// hash map for tab name
Map<TabItems, String> attendanceTabs = {
  TabItems.timeSheet: "T",
  TabItems.missedPunch: "M",
  TabItems.leave: "L",
};

/// @Name: CustomTabBar
/// @Created By: Jarchita Bhesaniya
/// @Purpose: custom tab bar widget
class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    required this.currentTab,
    required this.onSelectTab,
    required this.controller,
    Key? key,
  }) : super(key: key);

  final TabItems currentTab;
  final ValueChanged<TabItems> onSelectTab;
  final TabController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppStyles.commonCornerRadius),
            topRight: Radius.circular(AppStyles.commonCornerRadius)),
      ),
      child: TabBar(
        controller: controller,
        tabs: TabItems.values.map(_tab).toList(),
        onTap: (index) => onSelectTab(
          TabItems.values[index],
        ),
        indicatorColor: Colors.transparent,
      ),
    );
    return BottomNavigationBar(
      selectedFontSize: 11,
      unselectedFontSize: 11,
      type: BottomNavigationBarType.fixed,
      items: [
        // _buildItem(tabItem: TabItems.newsFeed, icon: CustomAppIcons.newsfeed),
        // _buildItem(tabItem: TabItems.campaign, icon: CustomAppIcons.campaign),
        // _buildItem(tabItem: TabItems.messages, icon: CustomAppIcons.chat_1),
        // _buildItem(tabItem: TabItems.notification, icon: CustomAppIcons.bell),
        // _buildItem(tabItem: TabItems.more, icon: Icons.more_horiz),
      ],
      iconSize: 20.0,
      onTap: (index) => onSelectTab(
        TabItems.values[index],
      ),
    );
  }

  Widget _tab(TabItems tabItem) {
    final title = attendanceTabs[tabItem]!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          AppStrings.signDot,
          style: TextStyle(
              fontSize: 30,
              height: 0.1,
              fontWeight: FontWeight.bold,
              color:
                  tabItem == currentTab ? AppColors.white : Colors.transparent),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 11, color: AppColors.white),
        ),
      ],
    );
  }

//   BottomNavigationBarItem _buildItem({TabItem tabItem, IconData icon}) {
//     String text = attendanceTabs[tabItem];
// //    IconData icon = Icons.layers;
//     return BottomNavigationBarItem(
//       icon: Icon(
//         icon,
//         color: _colorTabMatching(item: tabItem),
//       ),
//       title: Text(
//         text,
//         style: TextStyle(
//           color: _colorTabMatching(item: tabItem),
//         ),
//       ),
//     );
//   }

}
