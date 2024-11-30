import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/presentation/ui/widgets/new_books_part.dart';
import 'package:read_right/features/home/presentation/ui/widgets/recommendation_part.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(18),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Text(
                  context.recommendedForYou,
                  style: AppTextStyleHelper.font18SemiBoldBlack,
                ),
                const SizedBox(
                  height: 10,
                ),
                const RecommendationPart(),
              ],
            ),
          ),
        ),
        const NewBooksPart(),
      ],
    );
  }
}
