import 'package:dartz/dartz.dart';
import 'package:read_right/core/networking/models/error_model.dart';
import 'package:read_right/features/app_auth/data/model/user_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, dynamic>> signUp(
      {required String email,required String password});
  Future<Either<Failure, dynamic>> logIn(
      {required String email,required String password});

  Future<Either<Failure, dynamic>> preSetting({required UserModel user,required String password});

  Future<Either<Failure, dynamic>> uploadImage({required String path});

  Future<Either<Failure, dynamic>> uploadAudio({required String path});
}