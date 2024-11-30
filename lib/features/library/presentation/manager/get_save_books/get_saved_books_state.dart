import 'package:read_right/features/home/data/models/book_model.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';

abstract class GetSavedBooksState {}

class GetSavedBooksInitial extends GetSavedBooksState {}

class GetSavedBooksLoading extends GetSavedBooksState {}

class GetSavedBooksSuccess extends GetSavedBooksState {
  final List<BooksEntity> books;

  GetSavedBooksSuccess(this.books);
}

class GetSavedBooksError extends GetSavedBooksState {
  final String message;

  GetSavedBooksError(this.message);
}