import 'package:flutter/material.dart';

import '../../exports/resources.dart';
import '../../exports/utilities.dart';
import 'custom_radio_check_box_widget.dart';



class RadioSelectionView extends StatefulWidget {
  const RadioSelectionView(
      {required this.list,
      this.hasDecoration = true,
      this.hasSpaceBetween = true,
      this.fontSize,
      this.fontWeight,
      Key? key})
      : super(key: key);
  final List<RadioSelectionItemModel> list;
  final bool hasDecoration;
  final bool hasSpaceBetween;
  final double? fontSize;
  final FontWeight? fontWeight;
  @override
  _RadioSelectionViewState createState() => _RadioSelectionViewState();
}

class _RadioSelectionViewState extends State<RadioSelectionView> {
  @override
  Widget build(BuildContext context) => widget.hasDecoration
      ? Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [Shadows.boxShadow],
            borderRadius:
                BorderRadius.circular(AppStyles.commonCardCornerRadius),
          ),
          margin: const EdgeInsets.symmetric(
              vertical: 15, horizontal: AppStyles.pageSideMargin),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _radioSelectionView(),
        )
      : _radioSelectionView();

  ///selection view
  Widget _radioSelectionView() => Row(
        children: widget.list
            .map(
              (e) => Flexible(
                child: _radioItem(e),
              ),
            )
            .toList(),
      );

  Widget _radioItem(RadioSelectionItemModel item) => CustomRadioCheckBoxWidget(
        labelText: item.title,
        value: item.isSelected,
        onChanged: (value) {
          _onChanged(item);
        },
        radioSelection: true,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      );

  void _onChanged(RadioSelectionItemModel e) {
    setState(() {
      for (final item in widget.list) {
        if (e.title == item.title) {
          item.isSelected = true;
        } else {
          item.isSelected = false;
        }
      }
    });
  }
}

class RadioSelectionItemModel {
  RadioSelectionItemModel(this.title, {this.isSelected = false});
  String title;
  bool isSelected;
}
