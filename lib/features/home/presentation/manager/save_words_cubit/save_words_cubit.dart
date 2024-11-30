import 'package:bloc/bloc.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/home/presentation/manager/save_words_cubit/save_words_state.dart';

class SaveWordsCubit extends Cubit<SaveWordsState> {
  SaveWordsCubit({required this.homeRepo}) : super(SaveWordsInitial());
  final HomeRepo homeRepo;

  void saveWords({required int correctWords, required int wrongWords}) async {
    emit(SaveWordsLoading());
    final res = await homeRepo.saveWords(
        correctWords: correctWords, wrongWords: wrongWords);
    res.fold(
      (l) => emit(
        SaveWordsFailure(message: l.error.message ?? ''),
      ),
      (r) => emit(
        SaveWordsSuccess(),
      ),
    );
  }
}
