import 'package:tech_travel/src/domain/entities/like_entity.dart';

class LikesModel extends LikesEntity {
  const LikesModel({
    required List<LikeDatumModel> data,
    required MetaModel? meta,
  }) : super(data: data, meta: meta);

  factory LikesModel.fromJson(Map<String, dynamic> json) => LikesModel(
        data: json['data'] == null ? [] : List<LikeDatumModel>.from(json['data'].map((x) => LikeDatumModel.fromJson(x))),
        meta: json['meta'] == null ? null : MetaModel.fromJson(json['meta']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data.map((x) => x.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}

class LikeDatumModel extends LikeDatumEntity {
  const LikeDatumModel({
    required super.id,
    required DatumAttributesModel? super.attributes,
  });

  factory LikeDatumModel.fromJson(Map<String, dynamic> json) => LikeDatumModel(
        id: json['id'],
        attributes: json['attributes'] == null ? null : DatumAttributesModel.fromJson(json['attributes']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes?.toJson(),
      };
}

class DatumAttributesModel extends DatumAttributesEntity {
  const DatumAttributesModel({
    required super.createdAt,
    required super.updatedAt,
    required super.publishedAt,
    required UserIdModel? super.userId,
    required MovieIdModel? super.movieId,
  });

  factory DatumAttributesModel.fromJson(Map<String, dynamic> json) => DatumAttributesModel(
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
        userId: json['user_id'] == null ? null : UserIdModel.fromJson(json['user_id']),
        movieId: json['movie_id'] == null ? null : MovieIdModel.fromJson(json['movie_id']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
        'user_id': userId?.toJson(),
        'movie_id': movieId?.toJson(),
      };
}

class UserIdModel extends UserIdEntity {
  const UserIdModel({required UserIdDataModel? data}) : super(data: data);

  factory UserIdModel.fromJson(Map<String, dynamic> json) => UserIdModel(
        data: json['data'] == null ? null : UserIdDataModel.fromJson(json['data']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class UserIdDataModel extends UserIdDataEntity {
  const UserIdDataModel({
    required super.id,
    required FluffyAttributesModel? super.attributes,
  });

  factory UserIdDataModel.fromJson(Map<String, dynamic> json) => UserIdDataModel(
        id: json['id'],
        attributes: json['attributes'] == null ? null : FluffyAttributesModel.fromJson(json['attributes']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes?.toJson(),
      };
}

class FluffyAttributesModel extends FluffyAttributesEntity {
  const FluffyAttributesModel({
    required super.username,
    required super.email,
    required super.provider,
    required super.confirmed,
    required super.blocked,
    required super.firebaseUid,
    required super.finishedOnboarding,
    required super.createdAt,
    required super.updatedAt,
    required super.planRenewDate,
    required super.planStatus,
  });

  factory FluffyAttributesModel.fromJson(Map<String, dynamic> json) => FluffyAttributesModel(
        username: json['username'],
        email: json['email'],
        provider: json['provider'],
        confirmed: json['confirmed'],
        blocked: json['blocked'],
        firebaseUid: json['firebase_UID'],
        finishedOnboarding: json['finished_onboarding'],
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        planRenewDate: json['plan_renew_date'],
        planStatus: json['plan_status'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'provider': provider,
        'confirmed': confirmed,
        'blocked': blocked,
        'firebase_UID': firebaseUid,
        'finished_onboarding': finishedOnboarding,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'plan_renew_date': planRenewDate,
        'plan_status': planStatus,
      };
}

class MovieIdModel extends MovieIdEntity {
  const MovieIdModel({required MovieIdDataModel? data}) : super(data: data);

  factory MovieIdModel.fromJson(Map<String, dynamic> json) => MovieIdModel(
        data: json['data'] == null ? null : MovieIdDataModel.fromJson(json['data']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class MovieIdDataModel extends MovieIdDataEntity {
  const MovieIdDataModel({
    required super.id,
    required PurpleAttributesModel? super.attributes,
  });

  factory MovieIdDataModel.fromJson(Map<String, dynamic> json) => MovieIdDataModel(
        id: json['id'],
        attributes: json['attributes'] == null ? null : PurpleAttributesModel.fromJson(json['attributes']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes?.toJson(),
      };
}

class PurpleAttributesModel extends PurpleAttributesEntity {
  const PurpleAttributesModel({
    required super.name,
    required super.synopsis,
    required super.currentlyPlaying,
    required super.streamLink,
    required super.genre,
    required super.endDate,
    required super.createdAt,
    required super.updatedAt,
    required super.publishedAt,
  });

  factory PurpleAttributesModel.fromJson(Map<String, dynamic> json) => PurpleAttributesModel(
        name: json['name'],
        synopsis: json['synopsis'],
        currentlyPlaying: json['currently_playing'],
        streamLink: json['stream_link'],
        genre: json['genre'],
        endDate: DateTime.tryParse(json['end_date'] ?? ''),
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
      );

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'synopsis': synopsis,
        'currently_playing': currentlyPlaying,
        'stream_link': streamLink,
        'genre': genre,
        'end_date': endDate?.toIso8601String(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
      };
}

class MetaModel extends MetaEntity {
  const MetaModel({required PaginationModel? pagination}) : super(pagination: pagination);

  factory MetaModel.fromJson(Map<String, dynamic> json) => MetaModel(
        pagination: json['pagination'] == null ? null : PaginationModel.fromJson(json['pagination']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'pagination': pagination?.toJson(),
      };
}

class PaginationModel extends PaginationEntity {
  const PaginationModel({
    required super.page,
    required super.pageSize,
    required super.pageCount,
    required super.total,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) => PaginationModel(
        page: json['page'],
        pageSize: json['pageSize'],
        pageCount: json['pageCount'],
        total: json['total'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'page': page,
        'pageSize': pageSize,
        'pageCount': pageCount,
        'total': total,
      };
}
