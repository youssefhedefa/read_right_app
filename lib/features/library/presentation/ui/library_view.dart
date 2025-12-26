import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_book_item.dart';
import 'package:read_right/features/library/presentation/manager/get_save_books/get_saved_books_cubit.dart';
import 'package:read_right/features/library/presentation/manager/get_save_books/get_saved_books_state.dart';

class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetSavedBooksCubit, GetSavedBooksState>(
        bloc: context.read<GetSavedBooksCubit>()
          ..getSavedBooksList(
              savedBooksId: context.read<ProfileCubit>().state.bookList ?? [],
              locale: context.locale),
        builder: (context, state) {
          if (state is GetSavedBooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetSavedBooksError) {
            return Center(
              child: Text(
                state.message,
              ),
            );
          }
          if (state is GetSavedBooksSuccess) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (context, index) => VerticalListBookItem(
                image: state.books[index].image,
                title: state.books[index].title,
                authorName: state.books[index].genre,
                id: state.books[index].id,
                description: state.books[index].description,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutingConstances.bookDetails, arguments: state.books[index]);
                },
              ),
              itemCount:
                  context.read<ProfileCubit>().state.bookList?.length ?? 0,
            );
          }
          return const SizedBox();
        });
  }
}
