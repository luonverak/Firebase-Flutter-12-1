import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  InputField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText});
  var controller = TextEditingController();
  var hintText;
  IconData? prefixIcon;
  IconButton? suffixIcon;
  bool? obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      obscureText: obscureText!,
    );
  }
}
