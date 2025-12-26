import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/library/presentation/manager/get_save_books/get_saved_books_state.dart';

class GetSavedBooksCubit extends Cubit<GetSavedBooksState> {
  // final GetSavedBooks getSavedBooks;
  final HomeRepo repo;
  GetSavedBooksCubit({required this.repo}) : super(GetSavedBooksInitial());

  Future<void> getSavedBooksList(
      {required List<dynamic> savedBooksId, required Locale locale}) async {
    emit(GetSavedBooksLoading());
    final response = await repo.getNewestBooks(locale: locale, loadAll: true);
    response.fold(
      (error) => emit(GetSavedBooksError(
        error.error.message ?? "Error in getting newest books",
      )),
      (data) {
        List<BooksEntity> savedBooks = [];
        data.forEach((element) {
          if (savedBooksId.contains(element.id)) {
            savedBooks.add(element);
          }
        });
        emit(
          GetSavedBooksSuccess(savedBooks),
        );
      },
    );
  }
}
