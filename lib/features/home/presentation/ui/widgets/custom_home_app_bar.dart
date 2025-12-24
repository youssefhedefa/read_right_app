import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: AppColorHelper.primary(
        isMale: context.read<ThemeCubit>().state.gender.isMale,
      ),
      padding: REdgeInsets.all(18),
      child: Align(
        alignment: AlignmentDirectional.bottomStart,
        child: Text(
          '${context.hi}, Yusuf',
          style: AppTextStyleHelper.font18SemiBoldWhite,
        ),
      ),
    );
  }
}
