import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_states.dart';

// class GetHomeDataCubit extends Cubit<HomeDataState> {
//   final HomeRepo homeRepo;
//
//   GetHomeDataCubit({required this.homeRepo})
//       : super(HomeDataInitial(),);
//
//   getHomeData({required Locale locale}) async {
//     emit(HomeDataLoading(),);
//     final response = await homeRepo.getRecommendedBooks(locale: locale);
//     response.fold(
//       (error) => emit(
//         HomeDataFailure(
//           message: error.error.message ?? "Error in getting newest books",
//         ),
//       ),
//       (data) => emit(
//         HomeDataSuccess(
//           books: data,
//         ),
//       ),
//     );
//   }
// }


class GetHomeDataCubit extends Cubit<AppHomeDataState> {
  final HomeRepo homeRepo;

  GetHomeDataCubit({required this.homeRepo})
      : super(
          AppHomeDataState(
            recommendationState: RecommendationState.initial,
            newestState: NewestState.initial,
          ),
        );

  getRecommendationBooks({required Locale locale}) async {
    emit(
      state.copyWith(
        recommendationState: RecommendationState.loading,
      ),
    );
    final response = await homeRepo.getRecommendedBooks(locale: locale);
    response.fold(
      (error) => emit(
        state.copyWith(
          recommendationState: RecommendationState.failure,
          message: error.error.message ?? "Error in getting newest books",
        ),
      ),
      (data) => emit(
        state.copyWith(
          recommendationState: RecommendationState.success,
          books: data,
        ),
      ),
    );
  }

  getNewsBooks({required Locale locale}) async {
    emit(
      state.copyWith(
        newestState: NewestState.loading,
      ),
    );
    final response = await homeRepo.getNewestBooks(locale: locale);
    response.fold(
      (error) => emit(
        state.copyWith(
          newestState: NewestState.failure,
          message: error.error.message ?? "Error in getting newest books",
        ),
      ),
      (data) => emit(
        state.copyWith(
          newestState: NewestState.success,
          books: data,
        ),
      ),
    );
  }

}