import 'package:flutter/material.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_book_item.dart';

class VerticalSearchList extends StatelessWidget {
  const VerticalSearchList({super.key, required this.books});

  final List<BooksEntity> books;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) => VerticalListBookItem(
          id: books[index].id,
          title: books[index].local.title,
          authorName: books[index].local.author,
          image: books[index].image,
          description: books[index].local.description,
          onTap: () {
            Navigator.pushNamed(context, AppRoutingConstances.bookDetails, arguments: books[index]);
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 16,
        ),
        itemCount: books.length,
      ),
    );
  }
}
