import 'package:equatable/equatable.dart';

class UpdateMeModel extends Equatable {
  final String? username;
  final String? finishedOnboarding;

  const UpdateMeModel({this.username, this.finishedOnboarding});

  Map<String, dynamic> toJson() {
    return {
      'data': {
        if (username != null) 'username': username!,
        if (finishedOnboarding != null) 'finished_onboarding': finishedOnboarding,
      },
    };
  }

  @override
  List<Object?> get props => [username, finishedOnboarding];
}
