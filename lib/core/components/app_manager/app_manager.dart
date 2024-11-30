import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/app_manager_states.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_cubit.dart';
import 'package:read_right/core/components/app_manager/manager/get_profile_data_cubit/get_profile_data_state.dart';
import 'package:read_right/core/components/app_manager/widgets/bottom_nav_bar.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/helpers/context_tr_extension.dart';
import 'package:read_right/core/helpers/image_helper.dart';
import 'package:read_right/core/helpers/text_style_helper.dart';

class AppManagerView extends StatelessWidget {
  const AppManagerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppManagerCubit(),
      child: BlocBuilder<AppManagerCubit, AppManagerState>(
          builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColorHelper.lightPrimary,
            foregroundColor: AppColorHelper.lightPrimary,
            surfaceTintColor: AppColorHelper.lightPrimary,
            title: BlocBuilder<ProfileCubit, ProfileDataState>(
                bloc: getIt<ProfileCubit>()..getProfileData(),
                builder: (context, state) {
                  if (state.status == ProfileDataStatus.loading) {
                    return Text(
                      context.hi,
                      style: AppTextStyleHelper.font18SemiBoldWhite,
                    );
                  }
                  if (state.status == ProfileDataStatus.error) {
                    return Text(
                      state.error!,
                      style: AppTextStyleHelper.font18SemiBoldWhite,
                    );
                  }
                  if (state.status == ProfileDataStatus.success) {
                    return Text(
                      '${context.hi}, ${state.profileData!.name}',
                      style: AppTextStyleHelper.font18SemiBoldWhite,
                    );
                  }
                  return Text(
                    context.hi,
                    style: AppTextStyleHelper.font18SemiBoldWhite,
                  );
                }
                ),
            actions: [
              Image.asset(
                AppImageHelper.appBarImage,
              )
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(),
          body: context.read<AppManagerCubit>().views[state.viewIndex],
        );
      }),
    );
  }
}
