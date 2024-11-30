import 'package:read_right/features/app_auth/data/model/user_model.dart';
import 'package:read_right/features/profile/domain/entities/profile_entity.dart';

abstract class UserModelToProfileEntity {


  static ProfileEntity apply(UserModel user){
    return ProfileEntity(
      email: user.email,
      name: user.name,
      photo: user.image,
      wrongWords: user.wrongWords,
      correctWords: user.correctWords,
      totalWords: user.totalWords,
      savedBooks: user.myBooks,
    );
  }

}