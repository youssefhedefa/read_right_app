import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class CustomAppInputField extends StatefulWidget {
  const CustomAppInputField({super.key, required this.hintText, required this.icon, required this.isPassword, this.validationMessage, required this.controller, this.onChanged});

  final String hintText;
  final String? validationMessage;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  State<CustomAppInputField> createState() => _CustomAppInputFieldState();
}

class _CustomAppInputFieldState extends State<CustomAppInputField> {

  late bool isPasswordVisible;

  @override
  void initState() {
    isPasswordVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPasswordVisible,
      controller: widget.controller,
      onChanged: widget.onChanged,

      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.validationMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyleHelper.font16RegularGrey,
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        prefixIcon: Icon(widget.icon),
        suffixIcon: widget.isPassword
            ? IconButton(
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          icon: Icon(
            isPasswordVisible
                ? FontAwesomeIcons.eyeSlash
                :
            FontAwesomeIcons.eye,
            color: Colors.grey,
          ),
        )
            : null,
      ),
    );
  }

  OutlineInputBorder get border => OutlineInputBorder(
    borderRadius: BorderRadius.circular(32),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1,
    ),
  );
}
