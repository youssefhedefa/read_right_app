import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<BooksEntity>>> getRecommendedBooks({required Locale locale});
  Future<Either<Failure, List<BooksEntity>>> getNewestBooks({required Locale locale});
  Future<Either<Failure, String>> checkRecord({required String path, required Locale locale});
  Future<Either<Failure, String>> saveWords({required int correctWords, required int wrongWords});
}