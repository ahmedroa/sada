// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:sada/core/theme/colors.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final BorderRadius? borderRadius;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final String? initialValue;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? backgroundColor;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final int? maxLength;
  final Function(String)? onChanged;
  final void Function()? onTap;
  final String? helperText;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? counter;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? readOnly;
  final FocusNode? focusNode;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final String? title;

  const AppTextFormField({
    super.key,
    this.keyboardType,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.enabled,
    this.controller,
    required this.validator,
    this.fillColor,
    this.maxLength,
    this.onChanged,
    this.helperText,
    this.prefixText,
    this.borderRadius,
    this.prefixIcon,
    this.inputFormatters,
    this.onTap,
    this.counter,
    this.maxLines,
    this.textAlign,
    this.readOnly,
    this.focusNode,
    this.initialValue,
    this.textInputAction,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      enabled: enabled,
      focusNode: focusNode,
      textInputAction: textInputAction ?? TextInputAction.next,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: keyboardType,
      controller: controller,
      style:
          inputTextStyle ??
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: ColorsManager.gray,
          ),
      onChanged: onChanged,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      obscureText: isObscureText ?? false,
      validator: validator,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        helperText: helperText,
        suffixText: prefixText,
        counter: counter,
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        focusedBorder:
            focusedBorder ??
            UnderlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.kPrimaryColor,
                width: 2,
              ),
              borderRadius:
                  borderRadius ??
                  BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
            ),
        enabledBorder:
            enabledBorder ??
            UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.kPrimaryColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
        errorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),

        hintText: hintText,
        helperStyle: const TextStyle(color: Color(0xffA2A2A2)),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? ColorsManager.textFormField,
        filled: true,
      ),
    );
  }
}
