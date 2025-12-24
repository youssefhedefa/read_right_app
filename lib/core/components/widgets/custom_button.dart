import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.isLoading,
      this.isStart = false,
      });

  final void Function() onPressed;
  final String label;
  final bool isLoading;
  final bool isStart;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColorHelper.primary(
        isMale: context.watch<ThemeCubit>().state.gender.isMale,
        isStart: isStart,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      minWidth: double.infinity,
      clipBehavior: Clip.antiAlias,
      child: isLoading
          ? CircularProgressIndicator(
              color: AppColorHelper.white,
              backgroundColor: AppColorHelper.primary(
                isMale: context.watch<ThemeCubit>().state.gender.isMale,
                isStart: isStart,
              ),
            )
          : Text(
              label,
              style: AppTextStyleHelper.font18SemiBoldWhite,
            ),
    );
  }
}
