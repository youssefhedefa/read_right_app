import 'dart:async';
import 'dart:developer';
import 'dart:ui';
import 'package:dartz/dartz.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/features/app_auth/data/data_source/auth_data_source.dart';
import 'package:read_right/features/home/data/data_source/assemblu_ai_helper.dart';
import 'package:read_right/features/home/data/data_source/speech_to_text_helper.dart';
import 'package:read_right/features/home/data/data_source/local_data_source.dart';
import 'package:read_right/core/networking/remote_data_source/remote_data_source.dart';
import 'package:read_right/features/home/data/models/book_model.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';

class HomeRepoImple extends HomeRepo {
  final HomeLocalDataSource localDataSource;
  final RemoteDataSource remoteDataSource;
  final AuthDataSource authDataSource;
  final AssemblyAiHelper assemblyAiHelper;

  HomeRepoImple({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.assemblyAiHelper,
    required this.authDataSource,
  });

  @override
  Future<Either<Failure, List<BooksEntity>>> getRecommendedBooks(
      {required Locale locale}) async {
    try {
      final booksJson = await localDataSource.loadJsonFile(locale: locale);
      final books = booksJson.map((e) => BookModel.fromJson(e)).toList();
      return Right(getBookBasedOnLocal(
          local: locale.languageCode, books: books, hasLimit: true));
    } catch (e) {
      log('Error in getRecommendedBooks: $e');
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in getting newest books",
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BooksEntity>>> getNewestBooks(
      {required Locale locale}) async {
    try {
      final booksJson = await localDataSource.loadJsonFile(locale: locale);
      log("booksJson: $booksJson");
      final books = booksJson.map((e) => BookModel.fromJson(e)).toList();
      return Right(getBookBasedOnLocal(
          local: locale.languageCode, books: books, hasLimit: false));
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in getting newest books",
          ),
        ),
      );
    }
  }

  getBookBasedOnLocal(
      {required String local,
      required List<BookModel> books,
      required bool hasLimit}) {
    List<BooksEntity> booksEntity = books.map((book) {
      return BookEntityMapper.toEntity(book);
    }).toList();

    return hasLimit ? booksEntity.sublist(4, 7) : booksEntity;
  }

  @override
  Future<Either<Failure, String>> checkRecord(
      {required String path, required Locale locale}) async {
    try {
      String audioUrl = await remoteDataSource.storeAudioToAudioBucket(path);
      audioUrl = audioUrl.replaceFirst('test_audio/', '');
      String transactionId = await assemblyAiHelper.makeRequest(
        audioUrl: audioUrl,
        locale: locale,
      );
      print(transactionId);
      final res = await checkTransactionState(transactionId);
      return Right(res);
    } catch (e) {
      print(e.toString());
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in getting transcription: ${e.toString()}",
          ),
        ),
      );
    }
  }

  Future checkTransactionState(String transactionId) async {
    final transcription =
        await assemblyAiHelper.checkTranscription(transactionId);
    if (transcription == null) {
      return "Error in getting transcription";
    } else {
      return transcription;
    }
  }

  @override
  Future<Either<Failure, String>> saveWords(
      {required int correctWords, required int wrongWords}) async {
    try {
      await authDataSource.updateUserWords(
        correctWords: correctWords,
        wrongWords: wrongWords,
      );
      return Right("Words saved successfully");
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in saving words",
          ),
        ),
      );
    }
  }
}
