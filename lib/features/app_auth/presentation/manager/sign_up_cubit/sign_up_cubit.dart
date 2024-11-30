import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/app_auth/domain/auth_repo.dart';
import 'package:read_right/features/app_auth/presentation/manager/sign_up_cubit/sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;

  SignUpCubit({required this.authRepo}) : super(SignUpInitialState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  Future<void> signUp({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    emit(SignUpLoadingState());
    final res = await authRepo.signUp(email: email, password: password);
    res.fold(
      (error) {
        emit(SignUpErrorState(message: error.error.message ?? ''));
      },
      (success) {
        emit(SignUpSuccessState());
      },
    );
  }
}
