import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType? type;
  final bool obscure;
  final Widget? icon;
  final String? Function(String?)? validator;

  final int minLines;
  final int maxLines;

  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  const AppInput({
    super.key,
    required this.label,
    required this.controller,
    this.type,
    this.obscure = false,
    this.icon,
    this.validator,
    this.minLines = 1,
    this.maxLines = 1,
    this.onChanged,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: obscure,
      validator: validator,

      onChanged: onChanged,
      inputFormatters: inputFormatters,

      minLines: minLines,
      maxLines: maxLines,

      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
      ),
    );
  }
}
