import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:read_right/core/helpers/color_helper.dart';
import 'package:read_right/core/routing/routing_constances.dart';
import 'package:read_right/core/routing/routing_manager.dart';


class ReadRightApp extends StatelessWidget {
  const ReadRightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Read Right',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColorHelper.white,
          ).copyWith(
            textTheme: ThemeData().textTheme.apply(
                  fontFamily: 'Rubik',
                ),
          ),
          onGenerateRoute: AppRoutingManager().onGenerateRoute,
          initialRoute: checkStartingPoint(),
          // home: const NeedToTest(),
        );
      },
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
