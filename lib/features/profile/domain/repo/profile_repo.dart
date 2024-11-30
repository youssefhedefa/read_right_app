import 'package:dartz/dartz.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepo {
  Future<Either<Failure, ProfileEntity>> getProfileData();
  Future<Either<Failure, List<dynamic>>> fetchSavedBooks();
  Future<Either<Failure, List<dynamic>>> saveBook({required int bookId});
  Future<Either<Failure, List<dynamic>>> removeBook({required int bookId});
  Future<void> logOut();
}