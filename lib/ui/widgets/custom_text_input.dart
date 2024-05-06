import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../exports/resources.dart';


/// Purpose : custom text input field
class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    this.isPassWord = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText,
    this.initialValue,
    this.onSave,
    this.enabled = true,
    this.boxBorderWhenDisabled = true,
    this.enablePasswordVisibility = true,
    this.horizontalPaddingApplied = true,
    this.maxLines = 1,
    this.maxLength,
    this.fieldKey,
    this.inputFormatters,
    Key? key,
  }) : super(key: key);

  final bool isPassWord;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final void Function(String?)? onSave;
  final String? labelText;
  final String? initialValue;
  final bool enabled;
  final bool enablePasswordVisibility;
  final bool boxBorderWhenDisabled;
  final bool horizontalPaddingApplied;
  final int maxLines;
  final int? maxLength;
  final GlobalKey<FormFieldState>? fieldKey;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  bool _hidePassword = true;

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        key: widget.fieldKey,
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: widget.initialValue,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassWord && _hidePassword,
        textInputAction: widget.inputAction,
        cursorColor: AppColors.txtPrimary,
        keyboardType: widget.inputType,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        inputFormatters: widget.inputFormatters,
        decoration: InputDecoration(
          isDense: true, counterText: "",
          errorMaxLines: 5,
          // this will remove the default content padding
          // now you can customize it here or add padding widget
          contentPadding: EdgeInsets.symmetric(
              horizontal: widget.horizontalPaddingApplied ? 12 : 0,
              vertical: 12),
          focusedBorder: _inputBorder(),
          enabledBorder: _inputBorder(),
          disabledBorder: widget.boxBorderWhenDisabled
              ? _inputBorder()
              : const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.border,
                  ),
                ),
          errorBorder: _inputBorder(/*color: AppColors.accentRed*/),
          errorStyle: const TextStyle(
              fontFamily: AppFonts.fontName,
              fontSize: 11,
              fontWeight: AppFonts.regular,
              color: AppColors.colorError),
          focusedErrorBorder: _inputBorder(color: AppColors.accentRed),
          hintText: widget.hintText,
          suffixIcon: widget.isPassWord && widget.enablePasswordVisibility
              ? GestureDetector(
                  onTap: _toggleVisibility,
                  child: Icon(
                    _hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.secondary,
                  ),
                )
              : null,
          hintStyle: const TextStyle(
              fontFamily: AppFonts.fontName,
              fontSize: 14,
              fontWeight: AppFonts.semiBold,
              color: AppColors.secondary),
          labelText: widget.labelText,
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
        onChanged: widget.onChanged,
        onSaved: widget.onSave,
      );

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: color ?? AppColors.border,
        ),
      );
}
