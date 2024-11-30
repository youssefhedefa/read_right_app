import 'package:flutter/material.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/presentation/ui/widgets/title_mark_widget.dart';

class VerticalListBookItem extends StatelessWidget {
  const VerticalListBookItem({
    super.key,
    required this.image,
    required this.title,
    required this.authorName,
    required this.id,
    required this.description,
    required this.onTap,
  });

  final int id;
  final String image;
  final String title;
  final String authorName;
  final String description;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 18),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColorHelper.grey,
            width: 1,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 35,
              child: Container(
                padding: const EdgeInsets.all(6),
                color: AppColorHelper.black,
                child: Image.network(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTitleAndMarkWidget(
                    title: title,
                    bookId: id,
                  ),
                  Text(
                    authorName,
                    style: AppTextStyleHelper.font16MediumBlack.copyWith(
                      color: AppColorHelper.grey,
                    ),
                  ),
                  Text(
                    description,
                    maxLines: 4,
                    style: AppTextStyleHelper.font14RegularGrey,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
