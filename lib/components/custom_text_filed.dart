import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utilities/colors.dart';
import '../utilities/constants.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Function()? onTap;
  final Function()? onSaved;
  final String? Function(String?)? generalTextFieldValidator;
  final TextDirection? textDirection;
  final int? maxLength;
  final Color? borderColor;
  final Function(String)? onChanged;
  final Color? hintTextColor;
  final Color? labelTextColor;
  final int? minLines;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? prefixIcon;
  final Color? fillColor;
  final TextDirection? hintTextDirection;
  final Color? focusBorderColor;
  final FocusNode? focusNode;
  final double? height;
  final TextAlign? textAlign;
  final Color? textColor;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.inputFormatters,
    this.generalTextFieldValidator,
    this.onSaved,
    this.textDirection,
    this.maxLength,
    this.borderColor,
    this.onChanged,
    this.hintTextColor = AppColors.c016,
    this.minLines,
    this.maxLines,
    this.contentPadding,
    this.prefixIcon,
    this.fillColor,
    this.hintTextDirection,
    this.focusBorderColor,
    this.focusNode, this.height, this.textAlign, this.textColor, this.labelText, this.labelTextColor, this.onFieldSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      textDirection: widget.textDirection,
      validator: widget.generalTextFieldValidator,
      readOnly: widget.readOnly!,
      inputFormatters: widget.inputFormatters,
      cursorHeight: 20,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      textAlign: widget.textAlign ?? TextAlign.start,
      style: TextStyle(
        color: widget.textColor ?? AppColors.c016,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        fontFamily: stcFontStr
      ),
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
          fillColor: widget.fillColor ?? AppColors.c555,
          filled: true,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
          prefixIcon: widget.prefixIcon,
          hintTextDirection: widget.hintTextDirection,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.hintTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: stcFontStr
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
              color: widget.labelTextColor,
              fontSize: 18,
              fontWeight: FontWeight.w400,
              fontFamily: stcFontStr
          ),
          suffixIcon: widget.suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: widget.borderColor ?? AppColors.c565, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide:
                BorderSide(color: widget.borderColor ?? AppColors.c565, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
                color: widget.focusBorderColor ?? AppColors.c565, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.c4221),
          ),
          errorMaxLines: 1,
          errorStyle: const TextStyle(
              color: AppColors.c4221,
              fontSize: 16,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w400),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.c4221),
          )),
      cursorColor: AppColors.c016,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText!,
      controller: widget.controller,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
    );
  }
}
