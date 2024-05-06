import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

class DropDownItem {
  DropDownItem(this.id, this.value);

  final int id;
  final String value;
}


/// Purpose : custom dropdown widget
class CustomDropDownInput extends StatelessWidget {
  const CustomDropDownInput(
      {required this.items,
      this.initialValue,
      this.labelText,
      this.hintText,
      this.bgColor,
      this.onChanged,
      this.enabled = true,
      this.boxBorderWhenDisabled = false,
      Key? key})
      : super(key: key);
  final String? labelText;
  final String? hintText;
  final int? initialValue;
  final List<DropDownItem> items;
  final Color? bgColor;
  final ValueChanged<int?>? onChanged;
  final bool enabled;
  final bool boxBorderWhenDisabled;

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: bgColor ?? Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: DropdownButtonFormField<int>(
          items: items
              .map((value) => DropdownMenuItem<int>(
                    value: value.id,
                    child: Text(value.value),
                  ))
              .toList(),
          onChanged: onChanged,
          value: initialValue,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            enabled: enabled,
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            focusedBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            errorBorder: _inputBorder(color: AppColors.accentRed),
            focusedErrorBorder: _inputBorder(color: AppColors.accentRed),
            disabledBorder: boxBorderWhenDisabled
                ? _inputBorder()
                : const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.border,
                    ),
                  ),
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(
                fontFamily: AppFonts.fontName,
                fontSize: 14,
                fontWeight: AppFonts.semiBold,
                color: AppColors.secondary),
            labelStyle: const TextStyle(
                fontFamily: AppFonts.fontName,
                fontSize: 14,
                fontWeight: AppFonts.semiBold,
                color: AppColors.secondary),
          ),
          style: const TextStyle(
              fontFamily: AppFonts.fontName,
              fontSize: 14,
              fontWeight: AppFonts.semiBold,
              color: AppColors.txtPrimary),
        ),
      );

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: color ?? AppColors.border,
        ),
      );
}
