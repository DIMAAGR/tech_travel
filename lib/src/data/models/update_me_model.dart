import 'package:equatable/equatable.dart';

class UpdateMeModel extends Equatable {
  final String? username;
  final String? finishedOnboarding;
  final String? password;

  const UpdateMeModel({this.username, this.finishedOnboarding, this.password});

  Map<String, dynamic> toJson() {
    return {
      'data': {
        if (username != null) 'username': username!,
        if (finishedOnboarding != null) 'finished_onboarding': finishedOnboarding,
        if (password != null) 'password': password!,
      },
    };
  }

  @override
  List<Object?> get props => [username, finishedOnboarding];
}
