import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/features/app_auth/data/data_source/auth_data_source.dart';
import 'package:read_right/features/app_auth/data/repo_imple/auth_repo_imple.dart';
import 'package:read_right/features/app_auth/domain/auth_repo.dart';
import 'package:read_right/features/app_auth/presentation/manager/log_in_cubit/log_in_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/pre_setting_cubit/pre_setting_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:read_right/features/home/data/data_source/assemblu_ai_helper.dart';
import 'package:read_right/features/home/data/data_source/local_data_source.dart';
import 'package:read_right/core/networking/remote_data_source/remote_data_source.dart';
import 'package:read_right/features/home/data/repo_imple/repo_imple.dart';
import 'package:read_right/features/home/domain/repo/home_repo.dart';
import 'package:read_right/features/home/presentation/manager/check_record_cubit/check_record_cubit.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:read_right/features/home/presentation/manager/save_words_cubit/save_words_cubit.dart';
import 'package:read_right/features/library/presentation/manager/get_save_books/get_saved_books_cubit.dart';
import 'package:read_right/features/profile/data/repo_imple/profile_repo_imple.dart';
import 'package:read_right/features/profile/domain/repo/profile_repo.dart';
import 'package:read_right/features/search/presentation/manager/search_cubit/search_cubit.dart';

var getIt = GetIt.instance;

Future<void> setupDependencyInjection() async {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Dio dio = await DioFactory.getDio();

  getIt.registerLazySingleton<AuthDataSource>(() => AuthDataSource(
        firebaseAuth: firebaseAuth,
      ));

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImple(
        authDataSource: getIt<AuthDataSource>(),
        remoteDataSource: getIt<RemoteDataSource>(),
      ));

  getIt.registerFactory<SignUpCubit>(
    () => SignUpCubit(
      authRepo: getIt<AuthRepo>(),
    ),
  );

  getIt.registerFactory<PreSettingCubit>(
    () => PreSettingCubit(
      authRepo: getIt<AuthRepo>(),
      auth: firebaseAuth,
    ),
  );

  getIt.registerFactory<LogInCubit>(
    () => LogInCubit(
      authRepo: getIt<AuthRepo>(),
    ),
  );

  // Home
  getIt.registerLazySingleton<HomeLocalDataSource>(() => HomeLocalDataSource());
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSource());
  getIt.registerLazySingleton<AssemblyAiHelper>(() => AssemblyAiHelper());
  getIt.registerLazySingleton<HomeRepo>(
    () => HomeRepoImple(
      localDataSource: getIt<HomeLocalDataSource>(),
      remoteDataSource: getIt<RemoteDataSource>(),
      assemblyAiHelper: getIt<AssemblyAiHelper>(),
      authDataSource: getIt<AuthDataSource>(),
    ),
  );

  getIt.registerFactory<GetHomeDataCubit>(
    () => GetHomeDataCubit(
      homeRepo: getIt<HomeRepo>(),
    ),
  );

  getIt.registerFactory<SaveWordsCubit>(
    () => SaveWordsCubit(
      homeRepo: getIt<HomeRepo>(),
    ),
  );

  //search
  getIt.registerFactory<SearchCubit>(
      () => SearchCubit(homeRepo: getIt<HomeRepo>()));

  getIt.registerFactory<CheckRecordCubit>(
      () => CheckRecordCubit(homeRepo: getIt<HomeRepo>()));

  //profile

  getIt.registerLazySingleton<ProfileRepo>(
    () => ProfileRepoImple(
      authDataSource: getIt<AuthDataSource>(),
    ),
  );

  getIt.registerFactory<ProfileCubit>(
    () => ProfileCubit(
      repo: getIt<ProfileRepo>(),
    ),
  );

  getIt.registerFactory<GetSavedBooksCubit>(
      () => GetSavedBooksCubit(repo: getIt<HomeRepo>()));
}
