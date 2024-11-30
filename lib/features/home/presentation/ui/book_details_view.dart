import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key, required this.book});

  final BooksEntity book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.local.title,
          style: AppTextStyleHelper.font16MediumWhite,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColorHelper.primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.network(
                  book.image,
                  fit: BoxFit.cover,
                  height: 300.h,
                  width: 200.w,
                ),
              ),
              addDivider(),
              Text(
                "${context.title}: ${book.local.title}",
                style: AppTextStyleHelper.font16MediumBlack,
              ),
              Text(
                "${context.author}: ${book.local.author}",
                style: AppTextStyleHelper.font14RegularBlack,
              ),
              addDivider(),
              Text(
                "${context.category}: ${book.local.genre}",
                style: AppTextStyleHelper.font14RegularBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${context.description}: ${book.local.description}",
                style: AppTextStyleHelper.font14RegularBlack,
              ),
              addDivider(),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutingConstances.bookContent,
                      arguments: book.local.content);
                },
                label: context.readNow,
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  addDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 14.0),
      child: Divider(
        color: AppColorHelper.grey,
      ),
    );
  }
}
