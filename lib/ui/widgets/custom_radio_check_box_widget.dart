import 'package:flutter/material.dart';

import '../../exports/resources.dart';


/// Purpose : custom radio /check box button widget

class CustomRadioCheckBoxWidget extends StatelessWidget {
  const CustomRadioCheckBoxWidget({
    required this.value,
    required this.onChanged,
    this.radioSelection = false,
    this.labelText,
    this.fontSize,
    this.fontWeight,
    Key? key,
  }) : super(key: key);
  final bool value;
  final String? labelText;
  final ValueChanged<bool> onChanged;
  final bool? radioSelection;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    const colorChecked = AppColors.accentGreen;
    final colorUnChecked = Colors.transparent;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          switch (value) {
            case false:
              onChanged(true);
              break;
            case true:
              onChanged(false);
              break;
            default: // case null:
              onChanged(false);
              break;
          }
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
                borderRadius:
                    BorderRadius.circular(radioSelection == true ? 10 : 5),
                child: Container(
                  decoration: BoxDecoration(
                    color: value ? colorChecked : colorUnChecked,
                    border: Border.all(
                        color: value ? colorChecked : AppColors.border),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  height: 25,
                  width: 25,
                  child: Visibility(
                    visible: value,
                    child: const Icon(
                      Icons.done,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                )),
            if (labelText != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    labelText ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                        fontSize: fontSize ?? 14,
                        color: AppColors.btnLabel,
                        fontWeight: fontWeight ?? AppFonts.semiBold),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
