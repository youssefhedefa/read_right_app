import 'package:read_right/features/home/domain/entities/book_entity.dart';

enum BooksCategoriesStateEnum {
  allBooks,
  childrenLitre,
  fable,
  folk,
  adven,
  sports,
  science,
}

class BooksViewState{
  final BooksCategoriesStateEnum viewState;
  final List<BooksEntity> books;

  BooksViewState({required this.viewState, required this.books});

  BooksViewState copyWith({
    BooksCategoriesStateEnum? viewState,
    List<BooksEntity>? books,
  }) {
    return BooksViewState(
      viewState: viewState ?? this.viewState,
      books: books ?? this.books,
    );
  }

}