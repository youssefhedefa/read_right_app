import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_view.dart';

class AllBooksView extends StatelessWidget {
  const AllBooksView({super.key, required this.books});

  final List<BooksEntity> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.allBooks,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.isMale,
        ),
      ),
      body: VerticalListView(
        books: books,
      ),
    );
  }
}
