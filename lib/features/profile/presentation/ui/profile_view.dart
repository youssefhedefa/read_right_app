import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_state.dart';
import 'package:read_right/core/components/widgets/clickable_container.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/features/profile/presentation/ui/widgets/profile_card.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: BlocConsumer<ProfileCubit, ProfileDataState>(
            builder: (context, state) {
          if (state.status == ProfileDataStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == ProfileDataStatus.error) {
            return Center(
              child: Text(state.error!),
            );
          }
          if (state.status == ProfileDataStatus.success) {
            return Column(
              children: [
                ProfileCard(
                  name: state.profileData!.name,
                  email: state.profileData!.email,
                  photo: state.profileData!.photo,
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                WordStatus(
                  totalWords: state.profileData!.totalWords,
                  wrongWords: state.profileData!.wrongWords,
                  correctWords: state.profileData!.correctWords,
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                ClickableContainer(
                  text: context.languageLabel,
                  icon: Icons.language,
                  onTap: () {
                    showLanguageButtomSheet(context);
                  },
                ),
                const SizedBox(height: 16),
                ClickableContainer(
                  text: context.logoutLabel,
                  icon: Icons.logout,
                  onTap: () {
                    context.read<ProfileCubit>().logOut();
                  },
                ),
              ],
            );
          }
          return const SizedBox();
        }, listener: (context, state) {
          if (state.status == ProfileDataStatus.logOut) {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutingConstances.logIn, (route) => false);
          }
        }),
      ),
    );
  }

  showLanguageButtomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BlocProvider(
          create: (context) => AppManagerCubit(),
          child: Builder(builder: (context) {
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
          }),
        );
      },
    ).then((_) {
      context.read<AppManagerCubit>().changeBottomNavBarIndex(3);
    });
  }
}

class WordStatus extends StatelessWidget {
  const WordStatus(
      {super.key,
      required this.totalWords,
      required this.wrongWords,
      required this.correctWords});

  final int totalWords;
  final int wrongWords;
  final int correctWords;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          WordStatusItem(
            label: context.totalWords,
            count: totalWords,
          ),
          WordStatusItem(
            label: context.wrongWords,
            count: wrongWords,
          ),
          WordStatusItem(
            label: context.correctWords,
            count: correctWords,
          ),
        ],
      ),
    );
  }
}

class WordStatusItem extends StatelessWidget {
  const WordStatusItem({super.key, required this.label, required this.count});

  final String label;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(count.toString()),
        Text(label),
      ],
    );
  }
}
