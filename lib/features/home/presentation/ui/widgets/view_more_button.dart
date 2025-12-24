import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: AppColorHelper.primary(
            isMale: context.read<ThemeCubit>().state.gender.isMale,
          ),
          width: 1.5,
        ),
      ),
      child: Text(
        context.viewAll,
        style: TextStyle(
          color: AppColorHelper.primary(
            isMale: context.read<ThemeCubit>().state.gender.isMale,
          ),
          fontSize: 16,
        ),
      ),
    );
  }
}
