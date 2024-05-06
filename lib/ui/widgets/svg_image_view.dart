import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


/// Purpose : This is a common svg image view which will be used to show image
/// in svg format.
class SvgImageView extends StatelessWidget {
  const SvgImageView({
    required this.path,
    this.allowDrawingOurside = true,
    this.height = 50,
    this.color,
    Key? key,
  }) : super(key: key);

  final String path;
  final bool allowDrawingOurside;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(path,
      allowDrawingOutsideViewBox: allowDrawingOurside,
      height: height,
      color: color);
}
