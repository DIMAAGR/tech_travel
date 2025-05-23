// entities/likes_entity.dart

import 'package:equatable/equatable.dart';
import 'package:tech_travel/src/core/interfaces/json_convertible.dart';

abstract class LikesEntity extends Equatable implements JsonConvertible {
  final List<LikeDatumEntity> data;
  final MetaEntity? meta;

  const LikesEntity({required this.data, required this.meta});

  @override
  List<Object?> get props => [data, meta];
}

abstract class LikeDatumEntity extends Equatable implements JsonConvertible {
  final int? id;
  final DatumAttributesEntity? attributes;

  const LikeDatumEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class DatumAttributesEntity extends Equatable implements JsonConvertible {
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final UserIdEntity? userId;
  final MovieIdEntity? movieId;

  const DatumAttributesEntity({
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.userId,
    required this.movieId,
  });

  @override
  List<Object?> get props => [createdAt, updatedAt, publishedAt, userId, movieId];
}

abstract class UserIdEntity extends Equatable implements JsonConvertible {
  final UserIdDataEntity? data;

  const UserIdEntity({required this.data});

  @override
  List<Object?> get props => [data];
}

abstract class UserIdDataEntity extends Equatable implements JsonConvertible {
  final int? id;
  final FluffyAttributesEntity? attributes;

  const UserIdDataEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class FluffyAttributesEntity extends Equatable implements JsonConvertible {
  final String? username;
  final String? email;
  final String? provider;
  final bool? confirmed;
  final bool? blocked;
  final String? firebaseUid;
  final bool? finishedOnboarding;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic planRenewDate;
  final dynamic planStatus;

  const FluffyAttributesEntity({
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.firebaseUid,
    required this.finishedOnboarding,
    required this.createdAt,
    required this.updatedAt,
    required this.planRenewDate,
    required this.planStatus,
  });

  @override
  List<Object?> get props => [username, email, provider, confirmed, blocked, firebaseUid, finishedOnboarding, createdAt, updatedAt, planRenewDate, planStatus];
}

abstract class MovieIdEntity extends Equatable implements JsonConvertible {
  final MovieIdDataEntity? data;

  const MovieIdEntity({required this.data});

  @override
  List<Object?> get props => [data];
}

abstract class MovieIdDataEntity extends Equatable implements JsonConvertible {
  final int? id;
  final PurpleAttributesEntity? attributes;

  const MovieIdDataEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class PurpleAttributesEntity extends Equatable implements JsonConvertible {
  final String? name;
  final String? synopsis;
  final bool? currentlyPlaying;
  final String? streamLink;
  final String? genre;
  final DateTime? endDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;

  const PurpleAttributesEntity({
    required this.name,
    required this.synopsis,
    required this.currentlyPlaying,
    required this.streamLink,
    required this.genre,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [name, synopsis, currentlyPlaying, streamLink, genre, endDate, createdAt, updatedAt, publishedAt];
}

abstract class MetaEntity extends Equatable implements JsonConvertible {
  final PaginationEntity? pagination;

  const MetaEntity({required this.pagination});

  @override
  List<Object?> get props => [pagination];
}

abstract class PaginationEntity extends Equatable implements JsonConvertible {
  final int? page;
  final int? pageSize;
  final int? pageCount;
  final int? total;

  const PaginationEntity({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  @override
  List<Object?> get props => [page, pageSize, pageCount, total];
}
