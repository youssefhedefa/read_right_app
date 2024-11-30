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
    url: 'https://fpkruuuyuzcuuxntdcyy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwa3J1dXV5dXpjdXV4bnRkY3l5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5MDQ4NzIsImV4cCI6MjA0ODQ4MDg3Mn0.8zAzAO6LcyIFLu5gso9_ewww2vRS2TOYCnQiV5DuQhE',
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
          'assets/translations', // <-- change the path of the translation files
      child: const ReadRightApp(),
    ),
  );
}
