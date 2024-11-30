import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/ui/widgets/horizontal_list_book_item.dart';

class HorizontalBookList extends StatelessWidget {
  const HorizontalBookList({super.key, required this.books});

  final List<BooksEntity> books;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 16);
        },
        itemBuilder: (context, index) {
          return HorizontalListBookItem(
            onTap: () {
              Navigator.pushNamed(context, AppRoutingConstances.bookDetails, arguments: books[index]);
            },
            bookId: books[index].id,
            height: 280.h,
            title: books[index].local.title,
            authorName: books[index].local.author,
            imageUrl: books[index].image,
          );
        },
      ),
    );
  }
}
