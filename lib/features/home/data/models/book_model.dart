import 'package:read_right/features/home/domain/entities/book_entity.dart';

class BookModel {
  final int id;
  final String title;
  final String image;
  final List<String> genre;
  final String description;
  final String content;
  final String? url;

  BookModel({
    required this.id,
    required this.title,
    required this.image,
    required this.genre,
    required this.description,
    required this.content,
    this.url,
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
    };
  }
}

// class LanguageContent {
//   final String title;
//   final String author;
//   final String genre;
//   final String description;
//   final String content;
//
//   LanguageContent({
//     required this.title,
//     required this.author,
//     required this.genre,
//     required this.description,
//     required this.content,
//   });
//
//   factory LanguageContent.fromBookModel(BookModel model) {
//     return LanguageContent(
//       title: model.title,
//       author: '', // Author is no longer in the new JSON structure
//       genre: model.genre.join(', '),
//       description: model.description,
//       content: model.content,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'author': author,
//       'genre': genre,
//       'description': description,
//       'content': content,
//     };
//   }
// }

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
    );
  }
}