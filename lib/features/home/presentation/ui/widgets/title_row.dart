import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/presentation/ui/widgets/view_more_button.dart';


class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.title, required this.onPressed});

  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppTextStyleHelper.font18SemiBoldBlack,
        ),
        const Spacer(),
        ViewMoreButton(
          onPressed: onPressed,
        ),
      ],
    );
  }
}
