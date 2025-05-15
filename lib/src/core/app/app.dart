import 'package:flutter/material.dart';
import 'package:tech_travel/src/presentation/example_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Untold',
      home: ExamplePage(),
    );
  }
}
