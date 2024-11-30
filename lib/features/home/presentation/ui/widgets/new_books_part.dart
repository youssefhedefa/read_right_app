import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_cubit.dart';
import 'package:read_right/features/home/presentation/manager/get_home_data_cubit/get_home_data_states.dart';
import 'package:read_right/features/home/presentation/ui/widgets/title_row.dart';
import 'package:read_right/features/home/presentation/ui/widgets/vertical_list_book_item.dart';

class NewBooksPart extends StatelessWidget {
  const NewBooksPart({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<GetHomeDataCubit, AppHomeDataState>(
        bloc: getIt<GetHomeDataCubit>()
          ..getNewsBooks(locale: context.locale),
        builder: (context, state) {
          if (state.newestState == NewestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.newestState == NewestState.success) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: TitleRow(
                    title: context.newBooks,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutingConstances.allBooks,arguments: state.books);
                    },
                  ),
                ),
                Column(
                  children: state.books
                      ?.take(5)
                      .map(
                        (book) => VerticalListBookItem(
                      id: book.id,
                      title: book.local.title,
                      authorName: book.local.author,
                      image: book.image,
                      description: book.local.description,
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutingConstances.bookDetails, arguments: book);
                      },
                    ),
                  )
                      .toList() ??
                      [],
                ),
              ],
            );
          } else if (state.newestState == NewestState.failure) {
            return Center(
              child: Text(
                state.message ?? "Error in getting newest books",
                style: AppTextStyleHelper.font18SemiBoldBlack,
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
