import 'dart:ui';

import 'package:flutter/material.dart';

import '../../exports/resources.dart';
import '../../exports/widgets.dart';


/// Purpose : common card view container with button

class CommonCardContainer extends StatelessWidget {
  const CommonCardContainer({
    required this.child,
    required this.titleText,
    this.btnText,
    this.onPressed,
    this.isButtonEnabled = true,
    this.hasContainer = true,
    Key? key,
  }) : super(key: key);

  final Widget child;

  ///app bar title text
  final String? titleText;

  final String? btnText;
  final VoidCallback? onPressed;
  final bool isButtonEnabled;
  final bool hasContainer;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(titleText ?? ""),
            ),
            SliverList(
                delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(AppStyles.pageSideMargin),
                child: hasContainer ? _container(context) : child,
              ),
            ])),
          ],
        ),
      );

  Widget _container(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: AppStyles.commonRectContainer,
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    (btnText != null ? 210 : 135) -
                    (MediaQuery.of(context).padding.bottom)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              child: child,
            ),
          ),
          if (btnText != null)
            Padding(
              padding: const EdgeInsets.only(top: AppStyles.pageSideMargin),
              child: appCommonButton(
                  btnTxt: btnText!,
                  onPressed: onPressed,
                  isButtonEnabled: isButtonEnabled),
            )
        ],
      );
}
