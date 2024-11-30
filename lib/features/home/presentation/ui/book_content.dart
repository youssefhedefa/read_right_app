import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/features/home/presentation/manager/check_record_cubit/check_record_cubit.dart';
import 'package:read_right/features/home/presentation/ui/widgets/custom_record_bottom_sheet.dart';

class BookContentScreen extends StatelessWidget {
  const BookContentScreen({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorHelper.contentBackground,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImageHelper.readingBackground),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  content,
                  scrollPhysics: const BouncingScrollPhysics(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
              left: 20,
              right: 20,
            ),
            child: CustomButton(
              onPressed: () {
                showCustomRecordBottomSheet(context: context);
              },
              label: context.record,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }

  showCustomRecordBottomSheet({required BuildContext context}) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<CheckRecordCubit>(),
          child: const RecordBottomSheet(),
        );
      },
    );
  }
}


