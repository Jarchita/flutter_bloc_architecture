import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';

Widget header() => Container(
    color: AppColors.primary,
    alignment: Alignment.topCenter,
    child: const Padding(
      padding: EdgeInsets.fromLTRB(65, 80, 65, 51),
      child: Icon(Icons.details),
    ));
