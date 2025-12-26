import 'package:read_right/features/home/data/models/question_model.dart';

class BooksEntity {
  final int id;
  final String image;
  final String title;
  final String description;
  final String genre;
  final String content;
  final String url;
  final List<QuestionModel> questions;

  BooksEntity({
    required this.id,
    required this.image,
    required this.title,
    required this.description,
    required this.genre,
    required this.content,
    required this.url,
    required this.questions,
  });
}
