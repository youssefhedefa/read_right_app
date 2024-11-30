import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_right/features/app_auth/data/model/user_model.dart';
import 'package:read_right/features/app_auth/domain/auth_repo.dart';
import 'package:read_right/features/app_auth/presentation/manager/pre_setting_cubit/pre_setting_state.dart';

class PreSettingCubit extends Cubit<PreSettingState> {
  PreSettingCubit({required this.auth, required this.authRepo})
      : super(
          PreSettingState(
            preSettingEnum: PreSettingEnum.initial,
            audioPreSettingEnum: AudioPreSettingEnum.initial,
            imagePreSettingEnum: ImagePreSettingEnum.initial,
          ),
        );

  final FirebaseAuth auth;
  final AuthRepo authRepo;
  final TextEditingController nameController = TextEditingController();

  createUser({
    required String name,
    required String imageUrl,
    required String audioUrl,
  }) async {
    emit(state.copyWith(preSettingEnum: PreSettingEnum.loading));
    final res = await authRepo.preSetting(
      user: UserModel(
        id: auth.currentUser!.uid,
        email: auth.currentUser!.email!,
        name: name,
        image: imageUrl,
        audio: audioUrl,
        totalWords: 0,
        wrongWords: 0,
        correctWords: 0,
        myBooks: [],
      ),
    );
    res.fold(
      (error) {
        emit(state.copyWith(
          preSettingEnum: PreSettingEnum.error,
          message: error.error.message ?? '',
        ));
      },
      (success) {
        emit(state.copyWith(preSettingEnum: PreSettingEnum.success));
      },
    );
  }

  uploadImage({required File imageFile}) async {
    emit(state.copyWith(imagePreSettingEnum: ImagePreSettingEnum.loading));
    final res = await authRepo.uploadImage(path: imageFile.path);
    res.fold(
      (error) {
        emit(
          state.copyWith(
            imagePreSettingEnum: ImagePreSettingEnum.error,
            message: error.error.message ?? '',
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
              imagePreSettingEnum: ImagePreSettingEnum.success,
              imageUrl: success as String,
          ),
        );
      },
    );
  }

  pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: source).then(
      (value) {
        if (value != null) {
          uploadImage(imageFile: File(value.path));
        }
      },
    );
  }

  uploadAudio({required String path}) async {
    emit(state.copyWith(audioPreSettingEnum: AudioPreSettingEnum.loading));
    final res = await authRepo.uploadAudio(path: path);
    res.fold(
      (error) {
        emit(
          state.copyWith(
            audioPreSettingEnum: AudioPreSettingEnum.error,
            message: error.error.message ?? '',
          ),
        );
      },
      (success) {
        emit(
          state.copyWith(
              audioPreSettingEnum: AudioPreSettingEnum.success,
              audioUrl: success as String),
        );
      },
    );
  }
}
