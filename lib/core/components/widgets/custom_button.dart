import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.label, required this.isLoading});

  final void Function() onPressed;
  final String label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: AppColorHelper.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      minWidth: double.infinity,
      clipBehavior: Clip.antiAlias,
      child:isLoading ? const CircularProgressIndicator(
        color: AppColorHelper.white,
        backgroundColor: AppColorHelper.primary,
      ) : Text(
        label,
        style: AppTextStyleHelper.font18SemiBoldWhite,
      ),
    );
  }
}