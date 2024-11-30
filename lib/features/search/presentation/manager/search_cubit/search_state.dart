import 'package:read_right/features/home/domain/entities/book_entity.dart';

enum SearchStateEnum {
  initial,
  loading,
  success,
  error,
}

class SearchState{
  final SearchStateEnum state;
  final List<BooksEntity>? books;
  final String? errorMessage;

  SearchState({
    required this.state,
     this.books,
     this.errorMessage,
  });


  SearchState copyWith({
    SearchStateEnum? state,
    List<BooksEntity>? books,
    String? errorMessage,
  }) {
    return SearchState(
      state: state ?? this.state,
      books: books ?? this.books,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

}