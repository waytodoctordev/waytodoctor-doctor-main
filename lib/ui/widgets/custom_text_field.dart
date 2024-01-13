import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:way_to_doctor_doctor/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Widget? suffixIcon;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final double? horizontalPadding;
  final double? minSuffixWidth;
  final double? maxSuffixWidth;
  final bool? filled;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  const CustomTextField({
    Key? key,
    this.hintText,
    this.label,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.textDirection,
    this.keyboardType,
    this.readOnly = false,
    this.maxLines = 1,
    this.onTap,
    this.suffixIcon,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.labelStyle,
    this.hintStyle,
    this.prefixIcon,
    this.textAlign,
    this.horizontalPadding,
    this.minLines,
    this.inputFormatters,
    this.minSuffixWidth = 70,
    this.maxSuffixWidth = 70,
    this.filled,
    this.fillColor,
    this.onChanged,
    this.autoFocus = false,
    this.textInputAction,
  }) : super(key: key);

  static const _border = 26.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      autovalidateMode: autoValidateMode,
      onTap: onTap,
      textInputAction: textInputAction,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      minLines: minLines,
      readOnly: readOnly,
      style: const TextStyle(fontSize: 16, color: MyColors.blue14B),
      keyboardType: keyboardType,
      textDirection: textDirection,
      obscureText: obscureText,
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      autofocus: autoFocus,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        label: label == null ? null : Text(label!),
        hintText: hintText,
        hintStyle: TextStyle(fontSize: 14, color: MyColors.blue14B.withOpacity(0.8)),
        labelStyle: const TextStyle(color: MyColors.blue14B),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0, vertical: 20),
        suffixIconConstraints: BoxConstraints(
          maxHeight: 50,
          minWidth: minSuffixWidth == null ? 70 : minSuffixWidth!,
          maxWidth: maxSuffixWidth == null ? 70 : maxSuffixWidth!,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 50,
          minWidth: 70,
          maxWidth: 70,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: MyColors.white, width: 0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: MyColors.white, width: 0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: MyColors.white, width: 0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Color(0xFFE70044)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: const BorderSide(color: Color(0xFFE70044)),
        ),
        errorStyle: const TextStyle(fontSize: 12, color: MyColors.red),
      ),
    );
  }
}
