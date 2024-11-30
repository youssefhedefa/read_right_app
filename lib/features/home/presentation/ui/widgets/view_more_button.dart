import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';

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
        side: const BorderSide(
          color: AppColorHelper.primary,
          width: 1.5,
        ),
      ),
      child: Text(
        context.viewAll,
        style: const TextStyle(
          color: AppColorHelper.primary,
          fontSize: 16,
        ),
      ),
    );
  }
}
