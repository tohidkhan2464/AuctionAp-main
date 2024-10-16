import 'package:flutter/material.dart';
import 'package:project/theme/theme_helper.dart';
import 'package:project/utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.height, // Added height parameter
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.autofocus = true,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final double? height; // Added height field

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;
  final bool? enabled;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        height: height,
        child: TextFormField(
          controller: controller,
          enabled: enabled,
          focusNode: focusNode ?? FocusNode(),
          autofocus: autofocus!,
          style: textStyle ?? theme.textTheme.bodyLarge,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
          textCapitalization: TextCapitalization.words,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? TextStyle(fontSize: 16),
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(
              left: 10,
              top: 10.v,
              right: 10.h,
              bottom: 10.v,
            ),
        fillColor: fillColor,
        filled: filled,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color:
                Color(0xffd9d9d9), // Change this to your desired border color
            width: 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color:
                Color(0xffd9d9d9), // Change this to your desired border color
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color:
                Color(0xffd9d9d9), // Change this to your desired border color
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color:
                Color(0xffd9d9d9), // Change this to your desired border color
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color: Color(
                0xffd9d9d9), // Change this to your desired error border color
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.h),
          borderSide: BorderSide(
            color: Colors
                .red, // Change this to your desired focused error border color
            width: 1,
          ),
        ),
        errorStyle: TextStyle(
          color: appTheme.grey800.withOpacity(0.5),
          fontSize: 14.fSize,
        ),
      );
}

/// Extension on [CustomTextFormField] to facilita

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineAmberTL12 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.h),
        borderSide: BorderSide(
          color: appTheme.grey800.withOpacity(0.2),
          width: 1,
        ),
      );
}
