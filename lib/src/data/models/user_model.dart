import 'package:tech_travel/src/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.username,
    super.email,
    super.provider,
    super.confirmed,
    super.firebaseUid,
    super.finishedOnboarding,
    super.planRenewDate,
    super.planStatus,
    super.profilePicture,
  });

  @override
  UserModel copyWith({
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
    return UserModel(
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      provider: json["provider"],
      confirmed: json["confirmed"],
      firebaseUid: json["firebase_UID"],
      finishedOnboarding: json["finished_onboarding"],
      planRenewDate: json["plan_renew_date"],
      planStatus: json["plan_status"],
      profilePicture: json["profile_picture"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "provider": provider,
        "confirmed": confirmed,
        "firebase_UID": firebaseUid,
        "finished_onboarding": finishedOnboarding,
        "plan_renew_date": planRenewDate,
        "plan_status": planStatus,
        "profile_picture": profilePicture,
      };

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
