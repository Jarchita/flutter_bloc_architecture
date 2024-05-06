import 'package:flutter/material.dart';
import '../../exports/app_localizations.dart';
import '../../exports/resources.dart';


/// Purpose : common header view for lists and sections
class CommonContentHeader extends StatelessWidget {
  const CommonContentHeader({
    required this.t,
    this.title,
    this.viewAll = false,
    this.onTapViewAll,
    Key? key,
  }) : super(key: key);

  final String? title;
  final bool viewAll;
  final VoidCallback? onTapViewAll;
  final AppLocalizations? t;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppStyles.pageSideMargin,
          vertical: AppStyles.pageSideMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title ?? "",
              style: AppStyles.commonHeaderTextStyle,
            ),
            if (viewAll)
              InkWell(
                onTap: onTapViewAll,
                child: Text(
                  t?.lblViewAll ?? "",
                  style: AppStyles.commonSecondaryTextStyle,
                ),
              )
          ],
        ),
      );
}
