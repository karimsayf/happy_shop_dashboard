import 'package:flutter/material.dart';

import '../utilities/colors.dart';

Future<void> showCustomDialog(
    BuildContext context, {
      Widget? title,
      Widget? button,
      Widget? content,
      EdgeInsetsGeometry? contentPadding
    }) async {
  await showDialog(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: AppColors.c555,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),
            borderSide: const BorderSide(color: AppColors.c555)),
        contentPadding: contentPadding,
        title: title,
        content: content,
        actions: button != null
            ? [
          button,
        ]
            : null,
      );
    },
  );
}