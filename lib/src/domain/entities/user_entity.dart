import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.firebaseUid,
    required this.finishedOnboarding,
    required this.planRenewDate,
    required this.planStatus,
    required this.profilePicture,
  });

  final int? id;
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final String? firebaseUid;
  final bool? finishedOnboarding;
  final dynamic planRenewDate;
  final dynamic planStatus;
  final dynamic profilePicture;

  UserEntity copyWith({
    int? id,
    String? username,
    String? email,
    String? provider,
    bool? confirmed,
    String? firebaseUid,
    bool? finishedOnboarding,
    dynamic planRenewDate,
    dynamic planStatus,
    dynamic profilePicture,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      provider: provider ?? this.provider,
      confirmed: confirmed ?? this.confirmed,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      finishedOnboarding: finishedOnboarding ?? this.finishedOnboarding,
      planRenewDate: planRenewDate ?? this.planRenewDate,
      planStatus: planStatus ?? this.planStatus,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        provider,
        confirmed,
        firebaseUid,
        finishedOnboarding,
        planRenewDate,
        planStatus,
        profilePicture,
      ];
}
