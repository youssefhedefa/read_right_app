import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_state.dart';
import 'package:read_right/features/profile/domain/repo/profile_repo.dart';

class ProfileCubit extends Cubit<ProfileDataState> {

  final ProfileRepo repo;

  ProfileCubit({
    required this.repo,
}) : super(
    const ProfileDataState(
      status: ProfileDataStatus.initial,
      saveBookStatus: SaveBookStatus.initial,
      profileData: null,
      error: null,
    ),
  );

  Future<void> getProfileData() async {
    emit(
      state.copyWith(
        status: ProfileDataStatus.loading,
      ),
    );

    final result = await repo.getProfileData();
    result.fold(
      (error) {
        emit(
          state.copyWith(
            status: ProfileDataStatus.error,
            error: error.error.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            status: ProfileDataStatus.success,
            profileData: data,
          ),
        );
      },
    );
  }

  fetchUserSavedBooks() async {
    emit(
      state.copyWith(
        saveBookStatus: SaveBookStatus.loading,
      ),
    );
    final result = await repo.fetchSavedBooks();
    result.fold(
      (error) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.error,
            error: error.error.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.success,
            bookList: data,
          ),
        );
      },
    );
  }

  addBookToMyList(int bookId) async {
    emit(
      state.copyWith(
        saveBookStatus: SaveBookStatus.loading,
      ),
    );
    final result = await repo.saveBook(bookId: bookId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.error,
            error: error.error.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.success,
            bookList: data,
          ),
        );
      },
    );
  }

  deleteBookFromSaved(int bookId) async {
    emit(
      state.copyWith(
        saveBookStatus: SaveBookStatus.loading,
      ),
    );
    final result = await repo.removeBook(bookId: bookId);
    result.fold(
      (error) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.error,
            error: error.error.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            saveBookStatus: SaveBookStatus.success,
            bookList: data,
          ),
        );
      },
    );
  }

  logOut() async {
    emit(
      state.copyWith(
        status: ProfileDataStatus.loading,
      ),
    );
    await repo.logOut();
    emit(
      state.copyWith(
        status: ProfileDataStatus.logOut,
      ),
    );
  }

}