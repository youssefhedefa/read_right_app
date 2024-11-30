
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/features/app_auth/domain/auth_repo.dart';
import 'package:read_right/features/app_auth/presentation/manager/log_in_cubit/log_in_states.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit({required this.authRepo}) : super(LogInInitialState());

  final AuthRepo authRepo;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  logIn({required String email, required String password}) async {
    emit(LogInLoadingState());
    final res = await authRepo.logIn(email: email, password: password);
    res.fold(
      (error) => emit(LogInErrorState(message: error.error.message ?? 'An error occurred')),
      (r) => emit(LogInSuccessState()),
    );
  }
}
