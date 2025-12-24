import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:read_right/core/di/di.dart';
import 'package:read_right/core/helpers/bloc_observer.dart';
import 'package:read_right/read_right_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://jpynukrpuogqmbypivcq.supabase.co',
    anonKey: 'sb_publishable_8Yv2FLVmI4Zu7efQ18-NXQ_qnK8XcPS',
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await setupDependencyInjection();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      path:
          'assets/translations',
      child: const ReadRightApp(),
    ),
  );
}
