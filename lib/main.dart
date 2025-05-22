import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tech_travel/src/core/app/app.dart';
import 'package:tech_travel/src/core/di/injector.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  setupInjector();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en')],
      path: 'assets/langs',
      fallbackLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}
