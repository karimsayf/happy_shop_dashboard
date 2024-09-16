import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;

  const CustomRadioButton(
      {super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Radio(
        value: true,
        groupValue: value,
        onChanged: onChanged,
        fillColor: MaterialStateProperty.all(
            value ? AppColors.mainColor : AppColors.c804));
  }
}
