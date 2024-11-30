import 'package:bloc/bloc.dart';
import 'package:read_right/core/helpers/app_constances.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_state.dart';

class BooksViewCubit extends Cubit<BooksViewState> {
  BooksViewCubit({required List<BooksEntity> books})
      : super(
          BooksViewState(
            viewState: BooksCategoriesStateEnum.allBooks,
            books: books,
          ),
        );

  late List<BooksEntity> baseBooks;

  void changeView(BooksCategoriesStateEnum viewState) {
    List<int> booksIds = AppConstances.categories
        .firstWhere((category) => category.viewState == viewState)
        .numberOfBooks;
    switch (viewState) {
      case BooksCategoriesStateEnum.allBooks:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.allBooks,
            books: baseBooks,
          ),
        );
      case BooksCategoriesStateEnum.childrenLitre:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.childrenLitre,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      case BooksCategoriesStateEnum.fable:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.fable,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      case BooksCategoriesStateEnum.folk:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.folk,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      case BooksCategoriesStateEnum.adven:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.adven,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      case BooksCategoriesStateEnum.sports:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.sports,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      case BooksCategoriesStateEnum.science:
        emit(
          state.copyWith(
            viewState: BooksCategoriesStateEnum.science,
            books: baseBooks
                .where((element) => booksIds.contains(element.id))
                .toList(),
          ),
        );
        break;
      default:
        emit(
          state.copyWith(
            viewState: viewState,
            books: baseBooks,
          ),
        );
    }
  }

  void setBooks(List<BooksEntity> books) {
    baseBooks = books;
    emit(state.copyWith(books: books));
  }
}
