import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../exports/app_localizations.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../home_base/bottom_navigation.dart';


/// Purpose : settings screen -> opens from side menu
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with UtilityMixin {
  static String tag = "SettingsScreen";
  late AppLocalizations? t;
  bool _isNotificationEnabled = true;
  late SharedPreferences _prefs;

  @override
  void initState() {
    _checkNotificationSettings();
    super.initState();
  }

  Future<void> _checkNotificationSettings() async {
    _prefs = await SharedPreferences.getInstance();
    final isEnabled = _prefs.getBool(PrefKeys.isNotificationEnabled);
    if (isEnabled != null) {
      setState(() {
        _isNotificationEnabled = isEnabled;
      });
    }
    Logger.d(tag, "isNotificationEnabled : $_isNotificationEnabled");
  }

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CommonCardContainer(
        titleText: t?.lblSettings,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              _buildListItem(t?.lblNotifications,
                  onTap: () {}, control: _notificationControl()),
              _buildListItem(t?.lblLanguage,
                  onTap: _onTapLanguage, control: _languageControl()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String? title,
          {required VoidCallback onTap, Widget? control}) =>
      InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      title ?? "",
                      style: AppStyles.commonPrimaryLargeTextStyle,
                    ),
                  ),
                  control ?? _iconNext(),
                ],
              ),
              const Divider(
                color: AppColors.border,
              )
            ],
          ),
        ),
      );

  Widget _iconNext() => const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 17,
        color: AppColors.secondary,
      );

  Widget _languageControl() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              t?.lblEnglish ?? "",
              style: AppStyles.commonSecondaryLargeTextStyle,
            ),
          ),
          _iconNext(),
        ],
      );

  Widget _notificationControl() => Switch(
        activeColor: AppColors.accentGreen,
        inactiveThumbColor: AppColors.disabled,
        inactiveTrackColor: AppColors.disabled.withAlpha(80),
        onChanged: _onTapNotifications,
        value: _isNotificationEnabled,
      );

  Future<void> _onTapNotifications(bool value) async {
    setState(() {
      _isNotificationEnabled = value;
    });
    Logger.d(tag, "isNotificationEnabled : $_isNotificationEnabled");
    await _prefs.setBool(
        PrefKeys.isNotificationEnabled, _isNotificationEnabled);
  }

  void _onTapLanguage() {}

}
