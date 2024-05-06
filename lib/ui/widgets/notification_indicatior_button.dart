import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../exports/resources.dart';


/// Purpose : custom notification icon button with bubble
class NotificationIndicatorButton extends StatelessWidget {
  const NotificationIndicatorButton({
    required this.onTap,
    required this.dotVisible,
    this.icon,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final bool dotVisible;
  final String? icon;

  @override
  Widget build(BuildContext context) => InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          height: 35,
          width: 35,
          child: Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              SvgPicture.asset(
                icon ?? AppAssets.icNotifications,
                color: AppColors.secondary,
                height: 20,
                width: 20,
              ),
              Visibility(
                visible: dotVisible,
                child: const Positioned(
                  top: -1,
                  right: -2,
                  child: CircleAvatar(
                    backgroundColor: Color(0xFFFF002B),
                    radius: 4,
                  ),
                ),
              )
            ],
          ),
        ),
      );
}
