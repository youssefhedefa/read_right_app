import 'package:dartz/dartz.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/features/app_auth/data/data_source/auth_data_source.dart';
import 'package:read_right/features/profile/data/mapper/user_model_to_profile_entity.dart';
import 'package:read_right/features/profile/domain/entities/profile_entity.dart';
import 'package:read_right/features/profile/domain/repo/profile_repo.dart';

class ProfileRepoImple extends ProfileRepo {
  final AuthDataSource authDataSource;

  ProfileRepoImple({required this.authDataSource});

  @override
  Future<Either<Failure, ProfileEntity>> getProfileData() async {
    try {
      final user = await authDataSource
          .getUser(authDataSource.firebaseAuth.currentUser!.uid);
      ProfileEntity userData = UserModelToProfileEntity.apply(user!);
      return Right(userData);
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: '400',
            message: e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Future<void> logOut() {
    return authDataSource.logout();
  }

  @override
  Future<Either<Failure, List<dynamic>>> saveBook({required int bookId}) async {
    try {
      List savedBooks =
          await authDataSource.updateUserSavedBooks(bookId: bookId);
      return Right(savedBooks);
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in saving book",
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List>> fetchSavedBooks() async {
    try {
      List savedBooks = await authDataSource.getUserSavedBooks();
      return Right(savedBooks);
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in fetching saved books",
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List>> removeBook({required int bookId}) async {
    try {
      List savedBooks =
          await authDataSource.deleteBookFromSavedBooks(bookId: bookId);
      return Right(savedBooks);
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in removing book",
          ),
        ),
      );
    }
  }
}
