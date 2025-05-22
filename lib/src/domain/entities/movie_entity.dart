// entities/movie_entity.dart

import 'package:equatable/equatable.dart';
import 'package:tech_travel/src/core/interfaces/json_convertible.dart';

abstract class MovieEntity extends Equatable implements JsonConvertible {
  final List<DatumEntity> data;
  final MetaEntity? meta;

  const MovieEntity({required this.data, required this.meta});

  String? getThumb(int index) => data[index].attributes?.poster?.data?.attributes?.formats?.large?.url;

  @override
  List<Object?> get props => [data, meta];
}

abstract class DatumEntity extends Equatable implements JsonConvertible {
  final int? id;
  final DatumAttributesEntity? attributes;

  const DatumEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class DatumAttributesEntity extends Equatable implements JsonConvertible {
  final String? name;
  final String? synopsis;
  final bool? currentlyPlaying;
  final String? streamLink;
  final String? genre;
  final DateTime? endDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final PosterEntity? poster;

  const DatumAttributesEntity({
    required this.name,
    required this.synopsis,
    required this.currentlyPlaying,
    required this.streamLink,
    required this.genre,
    required this.endDate,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.poster,
  });

  @override
  List<Object?> get props => [name, synopsis, currentlyPlaying, streamLink, genre, endDate, createdAt, updatedAt, publishedAt, poster];
}

abstract class PosterEntity extends Equatable implements JsonConvertible {
  final DataEntity? data;

  const PosterEntity({required this.data});

  @override
  List<Object?> get props => [data];
}

abstract class DataEntity extends Equatable implements JsonConvertible {
  final int? id;
  final DataAttributesEntity? attributes;

  const DataEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class DataAttributesEntity extends Equatable implements JsonConvertible {
  final String? name;
  final dynamic alternativeText;
  final dynamic caption;
  final int? width;
  final int? height;
  final FormatsEntity? formats;
  final String? hash;
  final String? ext;
  final String? mime;
  final double? size;
  final String? url;
  final dynamic previewUrl;
  final String? provider;
  final dynamic providerMetadata;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const DataAttributesEntity({
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        name,
        alternativeText,
        caption,
        width,
        height,
        formats,
        hash,
        ext,
        mime,
        size,
        url,
        previewUrl,
        provider,
        providerMetadata,
        createdAt,
        updatedAt,
      ];
}

abstract class FormatsEntity extends Equatable implements JsonConvertible {
  final LargeEntity? large;
  final LargeEntity? small;
  final LargeEntity? medium;
  final LargeEntity? thumbnail;

  const FormatsEntity({
    required this.large,
    required this.small,
    required this.medium,
    required this.thumbnail,
  });

  @override
  List<Object?> get props => [large, small, medium, thumbnail];
}

abstract class LargeEntity extends Equatable implements JsonConvertible {
  final String? ext;
  final String? url;
  final String? hash;
  final String? mime;
  final String? name;
  final dynamic path;
  final double? size;
  final int? width;
  final int? height;

  const LargeEntity({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
  });

  @override
  List<Object?> get props => [
        ext,
        url,
        hash,
        mime,
        name,
        path,
        size,
        width,
        height,
      ];
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
