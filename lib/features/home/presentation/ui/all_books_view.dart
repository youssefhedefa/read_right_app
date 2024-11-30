import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_view.dart';

class AllBooksView extends StatelessWidget {
  const AllBooksView({super.key, required this.books});

  final List<BooksEntity> books;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.allBooks),
        backgroundColor: AppColorHelper.lightPrimary,
      ),
      body: VerticalListView(
        books: books,
      ),
    );
  }
}
