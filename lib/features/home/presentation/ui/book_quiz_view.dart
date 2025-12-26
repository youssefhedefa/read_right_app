import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';
import 'package:read_right/features/home/data/models/question_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';

class BookQuizView extends StatefulWidget {
  const BookQuizView({
    super.key,
    required this.questions,
    required this.bookTitle,
  });

  final List<QuestionModel> questions;
  final String bookTitle;

  @override
  State<BookQuizView> createState() => _BookQuizViewState();
}

class _BookQuizViewState extends State<BookQuizView> {
  int currentQuestionIndex = 0;
  String? selectedAnswer;
  bool showResult = false;
  bool isCorrect = false;
  int correctAnswersCount = 0;
  bool quizCompleted = false;

  void checkAnswer() {
    final currentQuestion = widget.questions[currentQuestionIndex];
    setState(() {
      isCorrect = selectedAnswer == currentQuestion.answer;
      showResult = true;
      if (isCorrect) {
        correctAnswersCount++;
      }
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
        showResult = false;
        isCorrect = false;
      });
    } else {
      setState(() {
        quizCompleted = true;
      });
    }
  }

  void restartQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      selectedAnswer = null;
      showResult = false;
      isCorrect = false;
      correctAnswersCount = 0;
      quizCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMale = context.watch<ThemeCubit>().state.isMale;

    if (widget.questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            context.quiz,
            style: AppTextStyleHelper.font16MediumWhite,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: AppColorHelper.primary(isMale: isMale),
        ),
        body: Center(
          child: Text(
            context.noQuestionsAvailable,
            style: AppTextStyleHelper.font16MediumBlack,
          ),
        ),
      );
    }

    if (quizCompleted) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            context.quizCompleted,
            style: AppTextStyleHelper.font16MediumWhite,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: AppColorHelper.primary(isMale: isMale),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.emoji_events,
                  size: 100.sp,
                  color: AppColorHelper.primary(isMale: isMale),
                ),
                SizedBox(height: 24.h),
                Text(
                  context.quizCompleted,
                  style: AppTextStyleHelper.font24BoldBlack,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  '${context.yourScore}: $correctAnswersCount / ${widget.questions.length}',
                  style: AppTextStyleHelper.font18SemiBoldBlack,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                CustomButton(
                  onPressed: restartQuiz,
                  label: context.retryQuiz,
                  isLoading: false,
                ),
                SizedBox(height: 12.h),
                CustomButton(
                  onPressed: () => Navigator.pop(context),
                  label: context.backToBook,
                  isLoading: false,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentQuestion = widget.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.bookTitle,
          style: AppTextStyleHelper.font16MediumWhite,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColorHelper.primary(isMale: isMale),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${context.question} ${currentQuestionIndex + 1}/${widget.questions.length}',
                    style: AppTextStyleHelper.font16MediumBlack,
                  ),
                  Text(
                    '${context.score}: $correctAnswersCount',
                    style: AppTextStyleHelper.font16MediumBlack,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              LinearProgressIndicator(
                value: (currentQuestionIndex + 1) / widget.questions.length,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColorHelper.primary(isMale: isMale),
                ),
                minHeight: 8.h,
              ),
              SizedBox(height: 32.h),

              // Question text
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColorHelper.primary(isMale: isMale).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColorHelper.primary(isMale: isMale),
                    width: 2,
                  ),
                ),
                child: Text(
                  currentQuestion.question,
                  style: AppTextStyleHelper.font18SemiBoldBlack,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 32.h),

              // Show image if answer is correct and image exists
              if (showResult && isCorrect && currentQuestion.image != null)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        currentQuestion.image!,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(Icons.image_not_supported, size: 50),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),

              // Options
              ...currentQuestion.options.map((option) {
                final isSelected = selectedAnswer == option;
                final isAnswerShown = showResult;
                final isCorrectOption = option == currentQuestion.answer;

                Color getBackgroundColor() {
                  if (!isAnswerShown) {
                    return isSelected
                        ? AppColorHelper.primary(isMale: isMale).withValues(alpha: 0.2)
                        : Colors.white;
                  }
                  if (isCorrectOption) {
                    return Colors.green.withValues(alpha: 0.2);
                  }
                  if (isSelected && !isCorrectOption) {
                    return Colors.red.withValues(alpha: 0.2);
                  }
                  return Colors.white;
                }

                Color getBorderColor() {
                  if (!isAnswerShown) {
                    return isSelected
                        ? AppColorHelper.primary(isMale: isMale)
                        : Colors.grey[300]!;
                  }
                  if (isCorrectOption) {
                    return Colors.green;
                  }
                  if (isSelected && !isCorrectOption) {
                    return Colors.red;
                  }
                  return Colors.grey[300]!;
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: InkWell(
                    onTap: showResult
                        ? null
                        : () {
                            setState(() {
                              selectedAnswer = option;
                            });
                          },
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: getBackgroundColor(),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: getBorderColor(),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (isAnswerShown && isCorrectOption)
                            Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                          if (isAnswerShown && isSelected && !isCorrectOption)
                            Icon(Icons.cancel, color: Colors.red, size: 24.sp),
                          if (!isAnswerShown)
                            Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                              color: isSelected ? AppColorHelper.primary(isMale: isMale) : Colors.grey,
                              size: 24.sp,
                            ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              option,
                              style: AppTextStyleHelper.font16MediumBlack,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),

              SizedBox(height: 24.h),

              // Result message
              if (showResult)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isCorrect ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCorrect ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                        size: 32.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          isCorrect ? context.correctAnswer : context.wrongAnswer,
                          style: AppTextStyleHelper.font16MediumBlack.copyWith(
                            color: isCorrect ? Colors.green : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 24.h),

              // Action button
              if (!showResult)
                CustomButton(
                  onPressed: selectedAnswer == null ? () {} : checkAnswer,
                  label: context.submitAnswer,
                  isLoading: false,
                )
              else
                CustomButton(
                  onPressed: nextQuestion,
                  label: currentQuestionIndex < widget.questions.length - 1
                      ? context.nextQuestion
                      : context.finishQuiz,
                  isLoading: false,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

