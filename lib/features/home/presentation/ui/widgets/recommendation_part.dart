import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_states.dart';
import 'package:read_right/features/home/presentation/ui/widgets/horizontal_book_list.dart';


class RecommendationPart extends StatelessWidget {
  const RecommendationPart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetHomeDataCubit, AppHomeDataState>(
      bloc: getIt<GetHomeDataCubit>()
        ..getRecommendationBooks(locale: context.locale),
      builder: (context, state) {
        if (state.recommendationState ==
            RecommendationState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.recommendationState ==
            RecommendationState.success) {
          return HorizontalBookList(
            books: state.books ?? [],
          );
        } else if (state.recommendationState ==
            RecommendationState.failure) {
          return Center(
            child: Text(
              state.message ?? "Error in getting newest books",
              style: AppTextStyleHelper.font18SemiBoldBlack,
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
