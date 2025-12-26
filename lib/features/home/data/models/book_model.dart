import 'package:read_right/features/home/data/models/question_model.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';

class BookModel {
  final int id;
  final String title;
  final String image;
  final List<String> genre;
  final String description;
  final String content;
  final String? url;
  final List<QuestionModel> questions;

  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.genre,
    required this.description,
    required this.content,
    this.url,
    this.questions = const [],
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      genre: json['genre'] != null
          ? List<String>.from(json['genre'])
          : [],
      description: json['description'] ?? '',
      content: json['content'] ?? '',
      url: json['url'],
      questions: json['questions'] != null
          ? List<QuestionModel>.from(
              json['questions'].map((q) => QuestionModel.fromJson(q)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'genre': genre,
      'description': description,
      'content': content,
      if (url != null) 'url': url,
      'questions': questions
          .map((q) => {
                'question': q.question,
                'choices': q.options,
                'answer': q.answer,
                if (q.image != null) 'image': q.image,
              })
          .toList(),
    };
  }
}

abstract class BookEntityMapper{
  static BooksEntity toEntity(BookModel model){
    return BooksEntity(
      id: model.id,
      image: model.image,
      title: model.title,
      description: model.description,
      genre: model.genre.join(', '),
      content: model.content,
      url: model.url ?? '',
      questions: model.questions,
    );
  }
}