import 'package:flutter/material.dart';

class CustomTextFormField2 extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool obscureText;
  final String hintText;
  final TextStyle hintStyle;
  final BoxConstraints? prefixConstraints;

  const CustomTextFormField2({
    super.key,
    this.controller,
    this.textInputType,
    this.obscureText = false,
    required this.hintText,
    required this.hintStyle,
    this.prefixConstraints,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFormField2State createState() => _CustomTextFormField2State();
}

class _CustomTextFormField2State extends State<CustomTextFormField2> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        prefixIconConstraints: widget.prefixConstraints,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
