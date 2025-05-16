import 'package:flutter/material.dart';
import 'package:tech_travel/src/core/app/app_router.dart';
import 'package:tech_travel/src/core/theme/app_theme.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Untold',
      debugShowCheckedModeBanner: false,
      routes: AppRouter()(),
      theme: AppTheme.darkTheme(),
    );
  }
}
