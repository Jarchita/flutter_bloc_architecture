import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/resources.dart';
import '../../exports/widgets.dart';


/// Purpose : this class contains the function for showing alert widgets
class CustomAlert {
  void showConfirmationAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String btnOkText,
    required VoidCallback onOkTap,
    String? btnCancelText,
    VoidCallback? onCancelTap,
    WillPopCallback? onWillPop,
    bool isConfirmation = true,
    TextAlign? textAlign,
  }) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) =>
            WillPopScope(
              onWillPop: onWillPop,
              child: Dialog(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 13),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 18, 0, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      title,
                                      style: const TextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25, right: 25, top: 10, bottom: 20),
                                  child: Text(
                                    content,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(),
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                    border: Border(top: BorderSide())),
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: <Widget>[
                                    if (isConfirmation)
                                      Expanded(
                                        child: MaterialButton(
                                          splashColor: Platform.isIOS
                                              ? Colors.transparent
                                              : Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: onCancelTap ??
                                              () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                          child: Text(
                                            btnCancelText ?? AppStrings.cancel,
                                            style: const TextStyle(),
                                          ),
                                        ),
                                      ),
                                    if (isConfirmation)
                                      Container(
                                        width: 1,
                                        color: AppColors.black,
                                      ),
                                    Expanded(
                                      child: MaterialButton(
                                        splashColor: Platform.isIOS
                                            ? Colors.transparent
                                            : Colors.white10,
                                        highlightColor: Colors.transparent,
                                        height: 40,
                                        onPressed: onOkTap,
                                        child: Text(
                                          btnOkText,
                                          style: const TextStyle(),
                                        ),
                                        //color: AppColors.secondary_color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  ///this dialog is displayed on resent link success
  void showInformativeDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String btnOkText,
    required VoidCallback onOkTap,
    Widget? child,
    bool displayClose = false,
    String? btnCancelText,
    String? icon,
    VoidCallback? onCancelTap,
    WillPopCallback? onWillPop,
  }) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) =>
            WillPopScope(
              onWillPop: onWillPop,
              child: Dialog(
                backgroundColor: AppColors.white,
                child: Wrap(
                  children: <Widget>[
                    if (displayClose)
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 15),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: onCancelTap,
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.disabled,
                              )),
                        ),
                      )
                    else
                      Container(
                        height: 40,
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            icon ?? AppAssets.icSuccess,
                            height: 52,
                            width: 52,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            child: ListTile(
                              title: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: AppColors.primary,
                                        fontWeight: AppFonts.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Text(
                                  content,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.secondary,
                                      fontWeight: AppFonts.semiBold),
                                ),
                              ),
                            ),
                          ),
                          child ?? Container(),
                          const SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  appCommonButton(
                                    btnTxt: btnOkText,
                                    height: 40,
                                    minWidth: 130,
                                    onPressed: onOkTap,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  ///device delete confirmation dialogue
  void showConfirmationDialog(
    BuildContext context, {
    required String title,
    required Widget content,
    required String btnOkText,
    required VoidCallback onOkTap,
    String? btnCancelText,
    bool displayIcon = true,
    bool displayClose = true,
    VoidCallback? onCancelTap,
    WillPopCallback? onWillPop,
  }) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) =>
            WillPopScope(
              onWillPop: onWillPop,
              child: Dialog(
                backgroundColor: AppColors.white,
                child: Wrap(
                  children: <Widget>[
                    if (displayClose)
                      Padding(
                        padding: const EdgeInsets.only(top: 15, right: 15),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: onCancelTap,
                              icon: const Icon(
                                Icons.clear,
                                color: AppColors.disabled,
                              )),
                        ),
                      )
                    else
                      Container(
                        height: 40,
                      ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (displayIcon)
                            SvgPicture.asset(
                              AppAssets.icWarning,
                              height: 52,
                              width: 52,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            child: ListTile(
                              title: Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    title,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        color: AppColors.primary,
                                        fontWeight: AppFonts.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: content,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: appCommonButton(
                                    btnTxt: btnCancelText ?? "Cancel",
                                    height: 45,
                                    // minWidth: 130,
                                    isNegative: true,
                                    onPressed: onCancelTap,
                                  ),
                                ),
                                Container(
                                  width: 10,
                                ),
                                Expanded(
                                  child: appCommonButton(
                                    btnTxt: btnOkText,
                                    height: 45,
                                    // minWidth: 135,
                                    onPressed: onOkTap,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
