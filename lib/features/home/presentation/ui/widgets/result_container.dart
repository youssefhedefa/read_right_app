import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/features/home/presentation/manager/save_words_cubit/save_words_cubit.dart';
import 'package:read_right/features/home/presentation/manager/save_words_cubit/save_words_state.dart';

class ResultContainer extends StatefulWidget {
  const ResultContainer(
      {super.key, required this.originalWords, required this.comparisonWords});

  final String originalWords;
  final String comparisonWords;

  @override
  State<ResultContainer> createState() => _ResultContainerState();
}

class _ResultContainerState extends State<ResultContainer> {
  late Map<String, int> result;

  @override
  void initState() {
    result = checkWords(widget.originalWords, widget.comparisonWords);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColorHelper.contentBackground.withOpacity(0.4),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${context.originalWords}: ${widget.originalWords}'),
          Text('${context.comparisonWords}: ${widget.comparisonWords}'),
          const Divider(
            color: Colors.grey,
          ),
          Text(
            '${context.correctWords}: ${result['correctWords']}',
          ),
          Text(
            '${context.wrongWords}: ${result['wrongWords']}',
          ),
          const SizedBox(
            height: 10,
          ),
          BlocConsumer<SaveWordsCubit, SaveWordsState>(
            builder: (context, state) {
              if (state is SaveWordsLoading) {
                return CustomButton(
                  onPressed: () {},
                  label: context.save,
                  isLoading: true,
                );
              }
              return CustomButton(
                onPressed: () {
                  context.read<SaveWordsCubit>().saveWords(
                        correctWords: result['correctWords']!,
                        wrongWords: result['wrongWords']!,
                      );
                },
                label: context.save,
                isLoading: false,
              );
            },
            listener: (context, state) {
              if (state is SaveWordsSuccess) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.wordsSavedSuccessfully),
                  ),
                );
              } else if (state is SaveWordsFailure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Map<String, int> checkWords(String original, String comparison) {
    List<String> originalWords = original.split(' ');
    List<String> comparisonWords = comparison.split(' ');

    int correctWords = 0;
    int wrongWords = 0;

    for (int i = 0; i < originalWords.length; i++) {
      if (i < comparisonWords.length &&
          originalWords[i] == comparisonWords[i]) {
        correctWords++;
      } else {
        wrongWords++;
      }
    }


    // If comparison has more words than original
    if (comparisonWords.length > originalWords.length) {
      wrongWords += comparisonWords.length - originalWords.length;
    }

    return {
      'correctWords': correctWords,
      'wrongWords': wrongWords,
    };
  }
}
