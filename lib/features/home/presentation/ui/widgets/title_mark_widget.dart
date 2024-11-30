import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_state.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class CustomTitleAndMarkWidget extends StatefulWidget {
  const CustomTitleAndMarkWidget({super.key, required this.title, required this.bookId});

  final String title;
  final int bookId;

  @override
  _CustomTitleAndMarkWidgetState createState() => _CustomTitleAndMarkWidgetState();
}

class _CustomTitleAndMarkWidgetState extends State<CustomTitleAndMarkWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            widget.title,
            style: AppTextStyleHelper.font16MediumBlack,
          ),
        ),
        BlocBuilder<ProfileCubit, ProfileDataState>(
          builder: (context, state) {
            if (_isLoading) {
              return const CircularProgressIndicator();
            }
            if (state.bookList?.contains(widget.bookId) ?? false) {
              return IconButton(
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  await context.read<ProfileCubit>().deleteBookFromSaved(widget.bookId);
                  setState(() {
                    _isLoading = false;
                  });
                },
                icon: const Icon(
                  Icons.bookmark,
                ),
              );
            }
            return IconButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await context.read<ProfileCubit>().addBookToMyList(widget.bookId);
                setState(() {
                  _isLoading = false;
                });
              },
              icon: const Icon(
                Icons.bookmark_border,
              ),
            );
          },
        ),
      ],
    );
  }
}