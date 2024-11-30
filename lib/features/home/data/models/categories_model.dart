import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_state.dart';

class CategoriesModel{
  final BooksCategoriesStateEnum viewState;
  final String arName;
  final String enName;
  final String image;
  final List<int> numberOfBooks;

  CategoriesModel({
    required this.viewState,
    required this.arName,
    required this.enName,
    required this.image,
    required this.numberOfBooks,
  });
}