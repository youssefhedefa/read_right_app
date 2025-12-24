import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/helpers/app_constances.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';
import 'package:read_right/features/home/domain/entities/book_entity.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_cubit.dart';
import 'package:read_right/features/home/presentation/manager/all_books_view_cubit/all_books_view_state.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_book_item.dart';

class VerticalListView extends StatelessWidget {
  const VerticalListView({super.key, required this.books});

  final List<BooksEntity> books;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksViewCubit,BooksViewState>(
      builder: (context,state) {
        return Column(
          children: [
            CategoriesHeadBar(
              currentView: state.viewState,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => VerticalListBookItem(
                  id: state.books[index].id,
                  title: state.books[index].local.title,
                  authorName: state.books[index].local.author,
                  image: state.books[index].image,
                  description: state.books[index].local.description,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutingConstances.bookDetails, arguments: state.books[index]);
                  },
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
                itemCount: state.books.length,
              ),
            ),
          ],
        );
      }
    );
  }
}

class CategoriesHeadBar extends StatelessWidget {
  const CategoriesHeadBar({super.key, required this.currentView});

  final BooksCategoriesStateEnum currentView;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: ListView.separated(
        padding: const EdgeInsets.all(18),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoryItem(
          isSelected: AppConstances.categories[index].viewState == currentView,
          title: context.locale.languageCode == 'en' ? AppConstances.categories[index].enName : AppConstances.categories[index].arName,
          onPressed: () {
            context.read<BooksViewCubit>().changeView(AppConstances.categories[index].viewState);
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: 16,
        ),
        itemCount: AppConstances.categories.length,
      ),
    );
  }
  checkCurrentView() {

  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.isSelected, required this.title, required this.onPressed});

  final bool isSelected;
  final String title;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppColorHelper.primary(
              isMale: context.read<ThemeCubit>().state.gender.isMale,
            ),
          ),
          color: isSelected ?AppColorHelper.primary(
            isMale: context.read<ThemeCubit>().state.gender.isMale,
          ) : Colors.transparent,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColorHelper.white: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
