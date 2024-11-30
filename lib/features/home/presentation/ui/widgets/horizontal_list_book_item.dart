import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/presentation/ui/widgets/title_mark_widget.dart';

class HorizontalListBookItem extends StatelessWidget {
  const HorizontalListBookItem({super.key, required this.height, required this.title, required this.authorName, required this.imageUrl, required this.onTap, required this.bookId});

  final double height;
  final String title;
  final String authorName;
  final String imageUrl;
  final int bookId;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: 200.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColorHelper.grey,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const Divider(
              color: AppColorHelper.grey,
            ),
            Expanded(
              flex: 35,
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTitleAndMarkWidget(
                      title: title,
                      bookId: bookId,
                    ),
                    Text(
                      authorName,
                      style: AppTextStyleHelper.font16MediumBlack.copyWith(
                        color: AppColorHelper.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


