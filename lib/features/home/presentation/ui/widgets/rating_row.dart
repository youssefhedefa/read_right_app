import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class CustomRatingRow extends StatelessWidget {
  const CustomRatingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        Text(
          '(4.5)',
          style: AppTextStyleHelper.font16MediumBlack,
        ),
      ],
    );
  }
}
