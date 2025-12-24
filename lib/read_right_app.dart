import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/core/routing/routing_manager.dart';
import 'package:read_right/core/theme/theme_cubit.dart';
import 'package:read_right/core/theme/theme_state.dart';

class ReadRightApp extends StatelessWidget {
  const ReadRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit()..loadTheme(),
      child: ScreenUtilInit(
        designSize: const Size(375, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.paddingOf(context).bottom,
            ),
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, themeState) {
                return MaterialApp(
                  title: 'Read Right',
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  theme: themeState.themeData,
                  onGenerateRoute: AppRoutingManager().onGenerateRoute,
                  initialRoute: checkStartingPoint(),
                  // home: const NeedToTest(),
                );
              },
            ),
          );
        },
      ),
    );
  }

  String checkStartingPoint() {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return AppRoutingConstances.appManager;
    }
    return AppRoutingConstances.signUp;
  }
}
