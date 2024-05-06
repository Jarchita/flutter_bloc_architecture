import 'package:flutter/material.dart';
import 'container.dart';
import 'shape.dart';

class PageIndicator extends StatefulWidget {
  const PageIndicator({
    required this.length,
    required this.currentPage,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.initialPage = 0,
    this.indicatorSpace = 5.0,
    this.indicatorShape = IndicatorShape.defaultCircle,
    this.align = IndicatorAlign.bottom,
    this.reverse = false,
    Key? key,
  }) : super(key: key);
  final Color color;

  final Color selectedColor;

  final int length;

  final double indicatorSpace;

  final IndicatorShape indicatorShape;

  final IndicatorAlign align;

  final bool reverse;

  final double currentPage;
  final double initialPage;
  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter? indicatorPainter;

    final shape = widget.indicatorShape;

    final reverse = widget.reverse;

    final page = widget.currentPage;

    if (shape is OvalShape) {
      indicatorPainter = OvalPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
      );
    } else if (shape is RoundRectangleShape) {
      indicatorPainter = RRectPainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        size: shape.size,
        cornerSize: shape.cornerSize,
      );
    } else if (shape is CircleShape) {
      indicatorPainter = CirclePainter(
        color: widget.color,
        selectedColor: widget.selectedColor,
        count: widget.length,
        page: page,
        padding: widget.indicatorSpace,
        radius: shape.size / 2,
      );
    }

    return IgnorePointer(
      child: RotatedBox(
        quarterTurns: reverse ? 2 : 0,
        child: CustomPaint(
          size: Size.fromHeight(shape.height),
          painter: indicatorPainter,
          child: Container(
            height: shape.height,
          ),
        ),
      ),
    );
  }
}

class OvalPainter extends CustomPainter {
  OvalPainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.padding = 5.0,
    this.size,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;

    size ??= const Size(12, 12);
  }
  double page;
  int count;
  Color color;
  Color selectedColor;
  double padding;
  late Paint _circlePaint;
  late Paint _selectedPaint;
  Size? size;

  double get totalWidth => count * size!.width + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    final height = this.size!.height;
    final width = this.size!.width;
    final centerWidth = size.width / 2;
    final startX = centerWidth - totalWidth / 2;
    for (var i = 0; i < count; i++) {
      final x = startX + i * (width + padding);
      final rect = Rect.fromLTWH(x, 0, width, height);
      canvas.drawOval(rect, _circlePaint);
    }

    final selectedX = startX + page * (width + padding);
    final rect = Rect.fromLTWH(selectedX, 0, width, height);
    canvas.drawOval(rect, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class RRectPainter extends CustomPainter {
  RRectPainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.padding = 5.0,
    this.size,
    this.cornerSize,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;

    size ??= const Size(12, 12);
  }
  double page;
  int count;
  Color color;
  Color selectedColor;
  double padding;
  late Paint _circlePaint;
  late Paint _selectedPaint;
  Size? size;
  Size? cornerSize;

  double get totalWidth => count * size!.width + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    final height = this.size!.height;
    final width = this.size!.width;
    final centerWidth = size.width / 2;
    final startX = centerWidth - totalWidth / 2;
    for (var i = 0; i < count; i++) {
      final x = startX + i * (width + padding);
      final rect = Rect.fromLTWH(x, 0, width, height);
      final rrect = RRect.fromRectAndRadius(
        rect,
        Radius.elliptical(cornerSize!.width, cornerSize!.height),
      );
      canvas.drawRRect(rrect, _circlePaint);
    }

    final selectedX = startX + page * (width + padding);
    final rect = Rect.fromLTWH(selectedX, 0, width, height);
    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.elliptical(cornerSize!.width, cornerSize!.height),
    );
    canvas.drawRRect(rrect, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    this.page = 0.0,
    this.count = 0,
    this.color = Colors.white,
    this.selectedColor = Colors.grey,
    this.radius = 12.0,
    this.padding = 5.0,
  }) {
    _circlePaint = Paint();
    _circlePaint.color = color;

    _selectedPaint = Paint();
    _selectedPaint.color = selectedColor;
  }
  double page;
  int count;
  Color color;
  Color selectedColor;
  double radius;
  double padding;
  late Paint _circlePaint;
  late Paint _selectedPaint;
  double get totalWidth => count * radius * 2 + padding * (count - 1);

  @override
  void paint(Canvas canvas, Size size) {
    final centerWidth = size.width / 2;
    final startX = centerWidth - totalWidth / 2;
    for (var i = 0; i < count; i++) {
      final x = startX + i * (radius * 2 + padding) + radius;
      canvas.drawCircle(Offset(x, radius), radius, _circlePaint);
    }

    final selectedX = startX + page * (radius * 2 + padding) + radius;
    canvas.drawCircle(Offset(selectedX, radius), radius, _selectedPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
