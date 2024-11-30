import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:read_right/core/components/widgets/custom_input_field.dart';
import 'package:read_right/core/components/widgets/custom_loading_widget.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:read_right/features/search/presentation/manager/search_cubit/search_state.dart';
import 'package:read_right/features/search/presentation/ui/widgets/vertical_search_list.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          CustomAppInputField(
            hintText: context.search,
            icon: FontAwesomeIcons.searchengin,
            isPassword: false,
            controller: context.read<SearchCubit>().searchController,
            onChanged: (value) {
              context.read<SearchCubit>().searchBooks(query: value, locale: context.locale);
            },
          ),
          const SizedBox(
            height: 18,
          ),
          BlocBuilder<SearchCubit,SearchState>(
            builder: (context,state) {
              if(state.state == SearchStateEnum.loading){
                return const CustomLoadingWidget();
            }
              if(state.state == SearchStateEnum.error){
                return Text(state.errorMessage ?? '');
              }
              if(state.state == SearchStateEnum.success){
                if(state.books == null || state.books!.isEmpty){
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(context.noBooksFound),
                          Image.asset(
                            AppImageHelper.litreCategory
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: VerticalSearchList(
                    books: state.books ?? [],
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
