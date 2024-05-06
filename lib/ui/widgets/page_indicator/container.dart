import 'package:flutter/material.dart';
import 'indicator.dart';
import 'shape.dart';

enum IndicatorAlign {
  top,
  center,
  bottom,
}

class PageIndicatorContainer extends StatefulWidget {

  const PageIndicatorContainer({

    required this.child,
    required this.length,
    this.padding = const EdgeInsets.only(bottom: 10, top: 10),
    this.align = IndicatorAlign.bottom,
    this.indicatorColor = Colors.white,
    this.indicatorSelectorColor = Colors.grey,
    this.indicatorSpace = 8.0,
    this.shape = IndicatorShape.defaultCircle, Key? key,
  }) : super(key: key);
  final Widget child;

  final int length;

  final EdgeInsets padding;

  final IndicatorAlign align;

  final IndicatorShape shape;

  final Color indicatorColor;

  final Color indicatorSelectorColor;

  final double indicatorSpace;

  @override
  PageContainerState createState() => PageContainerState();
}

class PageContainerState extends State<PageIndicatorContainer> {
  double? currentPage;

  @override
  Widget build(BuildContext context) {
    if (widget.child is! PageView) {
      return widget.child;
    }

    final height = widget.shape.height;

    final initPage = pageView.controller.initialPage;

    final currentPage = this.currentPage ?? initPage.toDouble();

    Widget indicator = PageIndicator(
      length: widget.length,
      color: widget.indicatorColor,
      selectedColor: widget.indicatorSelectorColor,
      indicatorSpace: widget.indicatorSpace,
      indicatorShape: widget.shape,
      align: widget.align,
      reverse: pageView.reverse,
      currentPage: currentPage,
      initialPage: initPage.toDouble(),
    );

    final align = widget.align;

    if (align == IndicatorAlign.bottom) {
      indicator = Positioned(
        left: 0,
        right: 0,
        bottom: widget.padding.bottom,
        height: height,
        child: indicator,
      );
    } else if (align == IndicatorAlign.top) {
      indicator = Positioned(
        left: 0,
        right: 0,
        top: widget.padding.top,
        height: height,
        child: indicator,
      );
    } else if (align == IndicatorAlign.center) {
      indicator = Center(
        child: Container(
          height: height,
          child: indicator,
        ),
      );
    }

    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(
              0, 0, 0, (widget.length > 1) ? 30 : 0),
          child: NotificationListener<ScrollNotification>(
            onNotification: _onScroll,
            child: pageView,
          ),
        ),
        if (widget.length > 1) indicator else Container(),
      ],
    );
  }

  PageView get pageView => widget.child as PageView;

  bool _onScroll(ScrollNotification notification) {
    if (notification.metrics is PageMetrics) {
      final metrics = notification.metrics as PageMetrics;
      currentPage = metrics.page;
      setState(() {});
    }
    return false;
  }

  void forceRefreshState() {
    setState(() {});
  }
}
