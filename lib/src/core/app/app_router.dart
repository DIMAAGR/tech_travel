import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tech_travel/src/core/app/app_routes.dart';
import 'package:tech_travel/src/presentation/signup/sign_up_view.dart';

class AppRouter {
  Map<String, Widget Function(BuildContext)> call() {
    return {
      AppRoutes.mainRoute: (context) => SignUpView(viewModel: GetIt.I.get()),
    };
  }
}
