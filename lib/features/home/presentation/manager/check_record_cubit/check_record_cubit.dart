import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/home/presentation/manager/check_record_cubit/check_record_state.dart';

class CheckRecordCubit extends Cubit<CheckRecordState> {
  final HomeRepo homeRepo;

  CheckRecordCubit({required this.homeRepo})
      : super(
          CheckRecordState(
            state: CheckRecordEnum.initial,
          ),
        );

  checkRecord({required String path, required Locale locale}) async {
    emit(
      state.copyWith(
        state: CheckRecordEnum.loading,
      ),
    );
    final result = await homeRepo.checkRecord(
      path: path,
      locale: locale,
    );
    result.fold(
      (error) {
        emit(
          state.copyWith(
            state: CheckRecordEnum.error,
            error: error.error.message,
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
            state: CheckRecordEnum.success,
            success: success,
          ),
        );
      },
    );
  }
}
