import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/search/presentation/manager/search_cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final HomeRepo homeRepo;

  SearchCubit({required this.homeRepo})
      : super(SearchState(state: SearchStateEnum.initial));

  TextEditingController searchController = TextEditingController();

  void searchBooks({required String query, required Locale locale}) async {
    emit(
      state.copyWith(
        state: SearchStateEnum.loading,
      ),
    );
    if (query.isNotEmpty && query.length >= 2) {
      final result = await homeRepo.getNewestBooks(locale: locale);
      result.fold(
        (error) {
          emit(
            state.copyWith(
              state: SearchStateEnum.error,
              errorMessage: error.error.message,
            ),
          );
        },
        (books) {
          //filter books by query
          books = books
              .where((book) =>
                  book.local.title.toLowerCase().contains(query.toLowerCase()) || book.local.author.toLowerCase().contains(query.toLowerCase()) || book.local.genre.toLowerCase().contains(query.toLowerCase()) || book.local.description.toLowerCase().contains(query.toLowerCase()))
              .toList();
          emit(
            state.copyWith(
              state: SearchStateEnum.success,
              books: books,
            ),
          );
        },
      );
    } else {
      emit(
        state.copyWith(
          state: SearchStateEnum.error,
          errorMessage: '',
        ),
      );
    }
  }
}
