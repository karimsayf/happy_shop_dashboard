import 'package:flutter/material.dart';

class CustomContainerFormField extends FormField<String> {
  const CustomContainerFormField({super.key,
    required String super.initialValue,
    required super.builder,
    required FormFieldValidator<String> super.validator,
  });
}
