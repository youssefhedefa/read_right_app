import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:read_right/core/components/widgets/clickable_container.dart';
import 'package:read_right/core/components/widgets/custom_button.dart';
import 'package:read_right/core/components/widgets/custom_input_field.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/app_auth/presentation/manager/pre_setting_cubit/pre_setting_cubit.dart';
import 'package:read_right/features/app_auth/presentation/manager/pre_setting_cubit/pre_setting_state.dart';

class PreSettingView extends StatelessWidget {
  const PreSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorHelper.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 18),
        child: Column(
          children: [
            ClickableContainer(
              text: context.languageLabel,
              icon: Icons.language,
              onTap: () {
                showLanguageButtomSheet(context);
              },
            ),
            const SizedBox(height: 16),
            CustomAppInputField(
              hintText: context.nameHint,
              icon: Icons.person,
              isPassword: false,
              controller: context.read<PreSettingCubit>().nameController,
            ),
            const SizedBox(height: 16),
            BlocBuilder<PreSettingCubit, PreSettingState>(
                builder: (context, state) {
              if (state.imageUrl != null) {
                return ClickableContainer(
                  text: context.profileImageUploadSuccess,
                  icon: Icons.image,
                  onTap: () {
                    //showImageSourceButtomSheet(context);
                  },
                );
              }
              return ClickableContainer(
                text: context.profileImageUpload,
                icon: Icons.image,
                onTap: () {
                  showImageSourceButtomSheet(context);
                },
              );
            }),
            const SizedBox(height: 16),
            BlocBuilder<PreSettingCubit,PreSettingState>(
              builder: (context,state) {
                if (state.audioUrl != null) {
                  return ClickableContainer(
                    text: context.audioUploadSuccess,
                    icon: Icons.mic,
                    onTap: () {
                      //showCustomRecordBottomSheet(context: context);
                    },
                  );
                }
                return ClickableContainer(
                  text: context.sayHello,
                  icon: Icons.mic,
                  onTap: () {
                    showCustomRecordBottomSheet(context: context);
                  },
                );
              }
            ),
            const Spacer(),
            BlocConsumer<PreSettingCubit, PreSettingState>(
              builder: (context, state) {
                if (state.preSettingEnum == PreSettingEnum.loading) {
                  return CustomButton(
                    onPressed: () {
                      //advanceButton(context: context);
                    },
                    label: context.advance,
                    isLoading: true,
                  );
                }
                return CustomButton(
                  onPressed: () {
                    advanceButton(context: context);
                  },
                  label: context.advance,
                  isLoading: false,
                );
              },
              listener: (context, state) {
                if (state.preSettingEnum == PreSettingEnum.success) {
                  Navigator.of(context)
                      .pushNamed(AppRoutingConstances.appManager);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  showLanguageButtomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                context.setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('عربي'),
              onTap: () {
                context.setLocale(const Locale('ar'));
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  showImageSourceButtomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<PreSettingCubit>(),
          child: BlocConsumer<PreSettingCubit, PreSettingState>(
            builder: (context, state) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Text(
                      context.gallery,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    trailing: const Icon(Icons.camera_alt_outlined),
                    onTap: () {
                      context
                          .read<PreSettingCubit>()
                          .pickImage(source: ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    trailing: const Icon(Icons.camera),
                    leading: Text(
                      context.camera,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    onTap: () {
                      context
                          .read<PreSettingCubit>()
                          .pickImage(source: ImageSource.camera);
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
            listener: (context, state) {
              if (state.imagePreSettingEnum == ImagePreSettingEnum.success) {
                Navigator.of(context).pop(state.imageUrl);
                Navigator.of(context).pop(state.imageUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Image uploaded successfully'),
                  ),
                );
              }
              if (state.imagePreSettingEnum == ImagePreSettingEnum.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Error uploading image'),
                  ),
                );
              }
              if (state.imagePreSettingEnum == ImagePreSettingEnum.loading) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Dialog(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    ).then((value) {
      print(value);
      context.read<PreSettingCubit>().state.imageUrl = value;
    });
  }

  showCustomRecordBottomSheet({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => getIt<PreSettingCubit>(),
          child: PreSettingRecordBottomSheet(),
        );
      },
    ).then((value) {
      context.read<PreSettingCubit>().state.audioUrl = value;
    });
  }

  advanceButton({required BuildContext context}) {
    if (context.read<PreSettingCubit>().nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name'),
        ),
      );
      return;
    }
    if (context.read<PreSettingCubit>().state.imageUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your image'),
        ),
      );
      return;
    }
    if (context.read<PreSettingCubit>().state.audioUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload your audio'),
        ),
      );
      return;
    }
    context.read<PreSettingCubit>().createUser(
          name: context.read<PreSettingCubit>().nameController.text,
          imageUrl: context.read<PreSettingCubit>().state.imageUrl!,
          audioUrl: context.read<PreSettingCubit>().state.audioUrl!,
        );
  }
}

class PreSettingRecordBottomSheet extends StatefulWidget {
  const PreSettingRecordBottomSheet({super.key});

  @override
  State<PreSettingRecordBottomSheet> createState() =>
      _PreSettingRecordBottomSheetState();
}

class _PreSettingRecordBottomSheetState
    extends State<PreSettingRecordBottomSheet> {
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
      DeviceFileSource(File(path).path),
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
                  !isRecording ? 'Record' : 'Stop',
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<PreSettingCubit, PreSettingState>(
            builder: (context, state) {
              return CustomButton(
                onPressed: () {
                  context.read<PreSettingCubit>().uploadAudio(
                        path: path,
                      );
                },
                label: 'Upload Audio',
                isLoading: false,
              );
            },
            listener: (context, state) {
              if (state.audioPreSettingEnum == AudioPreSettingEnum.success) {
                Navigator.of(context).pop(state.audioUrl);
                Navigator.of(context).pop(state.audioUrl);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Audio uploaded successfully'),
                  ),
                );
              }
              if (state.audioPreSettingEnum == AudioPreSettingEnum.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text(state.errorMessage ?? 'Error uploading audio'),
                  ),
                );
              }
              if (state.audioPreSettingEnum == AudioPreSettingEnum.loading) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Dialog(
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
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
