import 'package:read_right/features/home/data/models/book_model.dart';

class BooksEntity{
  final int id;
  final int year;
  final String image;
  final LanguageContent local;

  BooksEntity({required this.id, required this.year, required this.image, required this.local});
}