import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app.dart';
import 'package:tech_travel/src/core/di/injector.dart';
import 'package:tech_travel/src/core/services/firebase/firebase_options.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupInjector();
  runApp(const MainApp());
}
