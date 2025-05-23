import 'package:tech_travel/src/domain/entities/comments_entity.dart';

class CommentsModel extends CommentsEntity {
  const CommentsModel({
    super.id,
    super.comment,
    super.date,
    super.user,
    super.movie,
  });

  CommentsModel copyWith({
    String? id,
    String? comment,
    DateTime? date,
    UserModel? user,
    String? movie,
  }) {
    return CommentsModel(
      id: id ?? this.id,
      comment: comment ?? this.comment,
      date: date ?? this.date,
      user: user ?? this.user,
      movie: movie ?? this.movie,
    );
  }

  factory CommentsModel.fromJson(Map<String, dynamic> json) {
    return CommentsModel(
      id: json["id"] ?? '',
      comment: json["comment"],
      date: DateTime.tryParse(json["date"] ?? ""),
      user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
      movie: json["movie"]?.toString() ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "date": date?.toIso8601String(),
        "user": user?.toJson(),
        "movie": movie,
      };
}

class UserModel extends ComentsUserEntity {
  const UserModel({
    super.id,
    super.name,
    super.email,
    super.photoUrl,
    super.firebaseUid,
  });

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? provider,
    bool? confirmed,
    String? firebaseUid,
    bool? finishedOnboarding,
    dynamic planRenewDate,
    dynamic planStatus,
    dynamic photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      firebaseUid: firebaseUid ?? this.firebaseUid,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      firebaseUid: json["firebaseUID"],
      photoUrl: json["photoUrl"],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "firebaseUID": firebaseUid,
        "photoUrl": photoUrl,
      };
}
