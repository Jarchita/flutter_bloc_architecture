library home_screen;


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../exports/app_localizations.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../base/base_screen.dart';
import '../home_base/bottom_navigation.dart';


/// Purpose : Home tab screen
class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {required this.appBar, required this.navigateToTab, Key? key})
      : super(key: key);

  final PreferredSizeWidget appBar;
  final Function(BottomTabItem) navigateToTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with UtilityMixin {
  late AppLocalizations? t;
  late HomeBloc _bloc;

  final RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    t = AppLocalizations.of(context);
    return BaseScreen<HomeBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) => BlocListener<HomeBloc, BaseState>(
        listener: (context, state) {
          if (state is ConnectionFailedState) {
            showSnackBar(context, t?.errConnectionFailed ?? "");
          }
          if (state is FailedState) {
            showSnackBar(context, state.msg ?? t?.errSomethingWentWrong ?? "");
          }

          _refreshController.refreshCompleted();
        },
        child: Scaffold(
          backgroundColor: AppColors.bg,
          appBar: widget.appBar,
          // drawer: const SideMenu(),
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppStyles.commonCornerRadius),
                topRight: Radius.circular(AppStyles.commonCornerRadius)),
            child: Container(
              decoration: AppStyles.commonContainer,
              height: double.infinity,
              width: double.infinity,
              // padding: EdgeInsets.only(bottom: 55),
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: () {
                  //call refresh API
                },
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}