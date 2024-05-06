import 'package:flutter/widgets.dart';

abstract class IndicatorShape {
  const IndicatorShape._();

  factory IndicatorShape.circle({double size = 5.0}) => CircleShape(size);

  factory IndicatorShape.roundRectangleShape({
    Size size = const Size(5, 5),
    Size cornerSize = const Size.square(3),
  }) =>
      RoundRectangleShape(
        cornerSize: cornerSize,
        size: size,
      );

  factory IndicatorShape.oval({Size size = const Size(12, 8)}) =>
      OvalShape(size: size);
  static const defaultCircle = CircleShape(8);

  static const defaultRoundRectangle = RoundRectangleShape();

  static const defaultOval = OvalShape();

  double get height;

  double get width;
}

class CircleShape extends IndicatorShape {
  const CircleShape(this.size) : super._();
  final double size;

  @override
  double get height => size;

  @override
  double get width => size;
}

class RoundRectangleShape extends IndicatorShape {
  const RoundRectangleShape({
    this.size = const Size(12, 12),
    this.cornerSize = const Size.square(3),
  }) : super._();
  final Size size;
  final Size cornerSize;

  @override
  double get height => size.height;

  @override
  double get width => size.width;
}

class OvalShape extends IndicatorShape {
  const OvalShape({
    this.size = const Size(12, 4),
  }) : super._();
  final Size size;
  @override
  double get height => size.height;

  @override
  double get width => size.width;
}
