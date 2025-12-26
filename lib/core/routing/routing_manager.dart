import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/app_manager.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/routing/custom_page_route.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/app_auth/presentation/manager/log_in_cubit/log_in_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/pre_setting_cubit/pre_setting_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/sign_up_cubit/sign_up_cubit.dart';
import 'package:read_right/features/app_auth/presentation/ui/forms/log_in_form.dart';
import 'package:read_right/features/app_auth/presentation/ui/forms/sign_up_form.dart';
import 'package:read_right/features/app_auth/presentation/ui/pre_setting_view.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_cubit.dart';
import 'package:read_right/features/home/presentation/ui/all_books_view.dart';
import 'package:read_right/features/home/presentation/ui/book_content.dart';
import 'package:read_right/features/home/presentation/ui/book_details_view.dart';
import 'package:read_right/features/home/presentation/ui/book_quiz_view.dart';

class AppRoutingManager {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutingConstances.logIn:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => getIt<LogInCubit>(),
            child: const LogInForm(),
          ),
        );
      case AppRoutingConstances.signUp:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpForm(),
          ),
        );
      case AppRoutingConstances.preSetting:
        final params = settings.arguments as Map<String, dynamic>;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => getIt<PreSettingCubit>(),
            child: Scaffold(
              body: PreSettingView(
                password: params['password'] as String,
                email: params['email'] as String,
              ),
            ),
          ),
        );
      case AppRoutingConstances.appManager:
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BlocProvider(
            create: (context) => getIt<ProfileCubit>()
              ..getProfileData()
              ..fetchUserSavedBooks(),
            child: const AppManagerView(),
          ),
        );
      case AppRoutingConstances.allBooks:
        final books = settings.arguments as List<BooksEntity>;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => getIt<ProfileCubit>()
                  ..getProfileData()
                  ..fetchUserSavedBooks(),
              ),
              BlocProvider(
                create: (context) =>
                    BooksViewCubit(books: books)..setBooks(books),
              ),
            ],
            child: AllBooksView(
              books: books,
            ),
          ),
        );
      case AppRoutingConstances.bookDetails:
        final book = settings.arguments as BooksEntity;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BookDetailsView(
            book: book,
          ),
        );
      case AppRoutingConstances.bookContent:
        final content = settings.arguments as String;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: Scaffold(
            body: BookContentScreen(
              content: content,
            ),
          ),
        );
      case AppRoutingConstances.bookQuiz:
        final args = settings.arguments as Map<String, dynamic>;
        return CustomPageRoute(
          axisDirection: AxisDirection.left,
          child: BookQuizView(
            questions: args['questions'],
            bookTitle: args['bookTitle'],
          ),
        );
      default:
        return null;
    }
  }
}
