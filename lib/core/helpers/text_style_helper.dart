import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

abstract class AppTextStyleHelper {
  static TextStyle font22BoldPrimary(BuildContext context,{bool isStart = false}) => TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
          isStart: isStart,
        ),
      );

  static const TextStyle font24BoldBlack = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColorHelper.black,
  );

  static TextStyle font20MediumPrimary(BuildContext context) => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
        ),
      );

  static const TextStyle font20SemiBoldBlack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColorHelper.black,
  );

  static const TextStyle font20MediumBlack = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColorHelper.black,
  );

  static const TextStyle font18RegularGrey = TextStyle(
    fontSize: 18,
    color: AppColorHelper.grey,
  );

  static TextStyle font16BoldPrimary(BuildContext context) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
        ),
      );

  static TextStyle font18MediumPrimary(BuildContext context) => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
        ),
      );

  static const TextStyle font16MediumBlack = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorHelper.black,
  );

  static TextStyle font16MediumPrimary(BuildContext context,{bool isStart = false}) => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
          isStart: isStart
        ),
      );

  static const TextStyle font16MediumWhite = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorHelper.white,
  );

  static const TextStyle font16MediumGrey = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColorHelper.grey,
  );

  static const TextStyle font16RegularGrey = TextStyle(
    fontSize: 16,
    color: AppColorHelper.grey,
  );

  static const TextStyle font20RegularBlack = TextStyle(
    fontSize: 20,
    color: AppColorHelper.black,
  );

  static const TextStyle font18SemiBoldWhite = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColorHelper.white,
  );

  static const TextStyle font32BlackBold = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColorHelper.black,
  );

  static const TextStyle font22BlackMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColorHelper.black,
  );

  static const TextStyle font22BoldGrey = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: AppColorHelper.grey,
  );

  static const TextStyle font18SemiBoldBlack = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColorHelper.black,
  );

  static const TextStyle font14RegularGrey = TextStyle(
    fontSize: 14,
    color: AppColorHelper.grey,
  );

  static const TextStyle font14RegularBlack = TextStyle(
    fontSize: 14,
    color: AppColorHelper.black,
  );
}
