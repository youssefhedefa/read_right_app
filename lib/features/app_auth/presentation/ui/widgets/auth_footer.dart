import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter(
      {super.key,
      required this.clickable,
      required this.notClickable,
      required this.onPressed});

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
            style:
                AppTextStyleHelper.font16MediumPrimary(context, isStart: true)
                    .copyWith(
              decoration: TextDecoration.underline,
              decorationColor: AppColorHelper.primary(
                isMale: context.read<ThemeCubit>().state.gender.isMale,
                isStart: true,
              ),
            ),
            // under line the clickable text
          ),
        ),
      ],
    );
  }
}
