library notification_screen;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/notification/notification_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/constants.dart';
import '../../../exports/entities.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';

part 'notification_list.widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with UtilityMixin {
  late AppLocalizations? t;
  late NotificationBloc _bloc;

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    return BaseScreen<NotificationBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) =>
          BlocListener<NotificationBloc, BaseState>(
        listener: (context, state) {
          if (state is ConnectionFailedState) {
            showSnackBar(context, t?.errConnectionFailed ?? "");
          }
          if (state is FailedState) {
            showSnackBar(context, state.msg ?? t?.errSomethingWentWrong ?? "");
          }
        },
        child: Scaffold(
            backgroundColor: AppColors.bg,
            appBar: AppBar(
              title: Text(t?.lblNotifications ?? ""),
              leading: Container(
                margin: const EdgeInsets.all(11),
                alignment: Alignment.center,
                height: 35,
                width: 35,
                child: SvgPicture.asset(
                  AppAssets.icNotifications,
                  color: AppColors.accentGreen,
                  height: 20,
                  width: 20,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close)),
                )
              ],
            ),
            body: const Stack(
              children: [
              ],
            )),
      ),
    );
  }
}
