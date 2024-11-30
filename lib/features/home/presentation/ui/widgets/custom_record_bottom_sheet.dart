import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/components/widgets/custom_input_field.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/features/home/presentation/manager/check_record_cubit/check_record_cubit.dart';
import 'package:read_right/features/home/presentation/manager/check_record_cubit/check_record_state.dart';
import 'package:read_right/features/home/presentation/manager/save_words_cubit/save_words_cubit.dart';
import 'package:read_right/features/home/presentation/ui/widgets/result_container.dart';

class RecordBottomSheet extends StatefulWidget {
  const RecordBottomSheet({super.key});

  @override
  State<RecordBottomSheet> createState() => _RecordBottomSheetState();
}

class _RecordBottomSheetState extends State<RecordBottomSheet> {
  late RecorderController recordController;
  late AudioPlayer player;
  late TextEditingController textController;

  bool isRecording = false;
  bool isPlaying = false;
  String path = '';

  startRecording() {
    recordController.reset();
    recordController.checkPermission().then(
          (value) {
        recordController.record();
        isRecording = true;
        setState(() {});
      },
    );
  }

  stopRecord() {
    isRecording = false;
    recordController.stop().then((val) async {
      path = val!;
    });
    setState(() {});
  }

  playTheRecord() async {
    await player.play(
      DeviceFileSource(path),
    );
    isPlaying = true;
    setState(() {});
  }

  @override
  void initState() {
    recordController = RecorderController();
    player = AudioPlayer();
    textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    recordController.dispose();
    player.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColorHelper.contentBackground.withOpacity(0.4),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppInputField(
            hintText: '',
            icon: Icons.record_voice_over,
            isPassword: false,
            controller: textController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isRecording
                  ? AudioWaveforms(
                size: Size(MediaQuery.of(context).size.width - 140, 60),
                recorderController: recordController,
                enableGesture: true,
                waveStyle: const WaveStyle(
                  backgroundColor: AppColorHelper.red,
                  spacing: 8.0,
                  showBottom: false,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              )
                  : const Divider(
                color: Colors.grey,
                thickness: 0.5,
                height: 60,
              ),
              isRecording
                  ? const SizedBox()
                  : IconButton(
                onPressed: () {
                  playTheRecord();
                },
                icon: const Icon(
                  Icons.play_arrow_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              if (!isRecording) {
                startRecording();
              } else {
                stopRecord();
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImageHelper.recordButton,
                ),
                Text(
                  !isRecording ? context.record : context.stop,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<CheckRecordCubit, CheckRecordState>(
            builder: (context, state) {
              if (state.state == CheckRecordEnum.loading) {
                return CustomButton(
                  onPressed: () {},
                  label: '...',
                  isLoading: true,
                );
              }
              return CustomButton(
                onPressed: () {
                  print('object');
                  context.read<CheckRecordCubit>().checkRecord(
                    path: path,
                    locale: context.locale.languageCode,
                  );
                },
                label: context.checkVoice,
                isLoading: false,
              );
            },
            listener: (context, state) {
              if (state.state == CheckRecordEnum.loading) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Dialog(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  },
                );
              }
              if (state.state == CheckRecordEnum.success) {
                Navigator.pop(context);
                Navigator.pop(context);
                showAdaptiveDialog(
                  context: context,
                  builder: (context) {
                    return BlocProvider(
                      create: (context) => getIt<SaveWordsCubit>(),
                      child: Dialog(
                        child: ResultContainer(
                          originalWords: state.success!,
                          comparisonWords: textController.text,
                        ),
                      ),
                    );
                  },
                );
              }
              if (state.state == CheckRecordEnum.error) {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: Text(state.error ?? 'Error'),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}