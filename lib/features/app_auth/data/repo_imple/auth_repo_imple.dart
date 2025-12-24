import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/core/networking/remote_data_source/remote_data_source.dart';
import 'package:read_right/features/app_auth/data/data_source/auth_data_source.dart';
import 'package:read_right/features/app_auth/data/model/user_model.dart';
import 'package:read_right/features/app_auth/domain/auth_repo.dart';

class AuthRepoImple implements AuthRepo {
  final AuthDataSource authDataSource;
  final RemoteDataSource remoteDataSource;

  AuthRepoImple({required this.authDataSource, required this.remoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> logIn(
      {required String email, required String password}) async {
    try {
      final res = await authDataSource.login(email: email, password: password);
      return Right(res);
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
  Future<Either<Failure, UserCredential?>> signUp(
      {required String email, required String password}) async {
    try {
      final isEmailRegistered =
          await authDataSource.checkIfEmailExists(email: email);
      if (isEmailRegistered) {
        return Left(
          Failure(
            error: ErrorModel(
              status: '400',
              message:
                  'Email already registered. Please use a different email.',
            ),
          ),
        );
      } else {
        return const Right(null);
      }
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
  Future<Either<Failure, dynamic>> preSetting(
      {required UserModel user, required String password}) async {
    try {
      final res =
          await authDataSource.register(email: user.email, password: password);
      await authDataSource.createNewUser(
          user: user.copyWith(
        id: res.user!.uid,
      ));
      return const Right('Success');
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
  Future<Either<Failure, String>> uploadAudio({required String path}) async {
    try {
      String audioUrl = await remoteDataSource.storeAudioToAudioBucket(path);
      audioUrl = audioUrl.replaceFirst('test_audio/', '');
      return Right(audioUrl);
    } catch (e) {
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in uploading audio",
          ),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadImage({required String path}) async {
    try {
      String imageUrl = await remoteDataSource.storeImageToBucket(path);
      imageUrl = imageUrl.replaceFirst('test_audio/', '');
      return Right(imageUrl);
    } catch (e) {
      log('Error in uploading image: $e');
      return Left(
        Failure(
          error: ErrorModel(
            status: "400",
            message: "Error in uploading audio",
          ),
        ),
      );
    }
  }
}
