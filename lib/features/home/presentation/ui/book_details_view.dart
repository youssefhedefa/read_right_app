import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/ui/youtube_player_view.dart';

class BookDetailsView extends StatelessWidget {
  const BookDetailsView({super.key, required this.book});

  final BooksEntity book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
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
        backgroundColor: AppColorHelper.primary(
          isMale: context.read<ThemeCubit>().state.gender.isMale,
        ),
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
                "${context.title}: ${book.title}",
                style: AppTextStyleHelper.font16MediumBlack,
              ),
              // Text(
              //   "${context.author}: ${book.author}",
              //   style: AppTextStyleHelper.font14RegularBlack,
              // ),
              addDivider(),
              Text(
                "${context.category}: ${book.genre}",
                style: AppTextStyleHelper.font14RegularBlack,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${context.description}: ${book.description}",
                style: AppTextStyleHelper.font14RegularBlack,
              ),
              addDivider(),
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutingConstances.bookContent,
                    arguments: book.content,
                  );
                },
                label: context.readNow,
                isLoading: false,
              ),
              const SizedBox(height: 12),
              if (book.url.isNotEmpty)
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => YouTubePlayerView(
                          videoUrl: book.url,
                          title: book.title,
                          description: book.description,
                        ),
                      ),
                    );
                  },
                  label: context.watchVideo,
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
