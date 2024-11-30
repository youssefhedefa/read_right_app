import 'package:read_right/features/home/domain/entities/book_entity.dart';

class BookModel {
  final int id;
  final int year;
  final String image;
  final LanguageContent en;
  final LanguageContent ar;

  BookModel({
    required this.id,
    required this.year,
    required this.en,
    required this.ar,
    required this.image,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      year: json['year'],
      image: json['image'],
      en: LanguageContent.fromJson(json['en']),
      ar: LanguageContent.fromJson(json['ar']),
    );
  }

}

class LanguageContent {
  final String title;
  final String author;
  final String genre;
  final String description;
  final String content;

  LanguageContent({
    required this.title,
    required this.author,
    required this.genre,
    required this.description,
    required this.content,
  });

  factory LanguageContent.fromJson(Map<String, dynamic> json) {
    return LanguageContent(
      title: json['title'],
      author: json['author'],
      genre: json['genre'],
      description: json['description'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'description': description,
      'content': content,
    };
  }
}

abstract class BookEntityMapper{
  static BooksEntity toEnglishEntity(BookModel model){
    return BooksEntity(
      id: model.id,
      year: model.year,
      image: model.image,
      local: model.en
    );
  }
  static BooksEntity toArabicEntity(BookModel model){
    return BooksEntity(
      id: model.id,
      year: model.year,
      image: model.image,
      local: model.ar
    );
  }
}