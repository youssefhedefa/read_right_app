import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_states.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:read_right/features/home/presentation/ui/home_view.dart';
import 'package:read_right/features/library/presentation/manager/get_save_books/get_saved_books_cubit.dart';
import 'package:read_right/features/library/presentation/ui/library_view.dart';
import 'package:read_right/features/profile/presentation/ui/profile_view.dart';
import 'package:read_right/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:read_right/features/search/presentation/ui/search_view.dart';

class AppManagerCubit extends Cubit<AppManagerState> {
  AppManagerCubit() : super(AppManagerBottomNavBarIndexState(viewIndex: 0));

  List<Widget> views = [
    BlocProvider(
      create: (context) => getIt<GetHomeDataCubit>()..getRecommendationBooks(locale: context.locale),
        child: const HomeView(),
    ),
    BlocProvider(
      create: (context) => getIt<SearchCubit>(),
        child: const SearchView(),
    ),
    BlocProvider(
      create: (context) => getIt<GetSavedBooksCubit>(),
        child: const LibraryView(),
    ),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>()..getProfileData(),
        child: const ProfileView(),
    ),
  ];

  void changeBottomNavBarIndex(int index) {
    emit(AppManagerBottomNavBarIndexState(viewIndex: index));
  }
}
