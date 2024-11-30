import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';


class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key, required this.clickable, required this.notClickable, required this.onPressed});

  final String clickable;
  final String notClickable;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          notClickable,
          style: AppTextStyleHelper.font16MediumBlack,
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            clickable,
            style: AppTextStyleHelper.font16MediumPrimary.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColorHelper.primary,
            ),
            // under line the clickable text
          ),
        ),
      ],
    );
  }
}
