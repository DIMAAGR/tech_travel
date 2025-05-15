import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/domain/usecases/sign_in_use_case.dart';

class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    final SignInWithGoogleUseCase google = GetIt.I();

                    await google();
                  },
                  child: const Text('Google Sign in')),
              ElevatedButton(onPressed: () {}, child: const Text('Apple Sign in')),
            ],
          ),
        ),
      ),
    );
  }
}
