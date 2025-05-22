// entities/subtitles_entity.dart

import 'package:equatable/equatable.dart';
import 'package:tech_travel/src/core/interfaces/json_convertible.dart';

abstract class SubtitlesEntity extends Equatable implements JsonConvertible {
  final List<SubtitlesDatumEntity> data;
  final MetaEntity? meta;

  const SubtitlesEntity({required this.data, required this.meta});

  @override
  List<Object?> get props => [data, meta];
}

abstract class SubtitlesDatumEntity extends Equatable implements JsonConvertible {
  final int? id;
  final DatumAttributesEntity? attributes;

  const SubtitlesDatumEntity({required this.id, required this.attributes});

  @override
  List<Object?> get props => [id, attributes];
}

abstract class DatumAttributesEntity extends Equatable implements JsonConvertible {
  final String? language;
  final bool? attributesDefault;
  final dynamic urlLink;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? publishedAt;
  final FileClassEntity? file;

  const DatumAttributesEntity({
    required this.language,
    required this.attributesDefault,
    required this.urlLink,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
    required this.file,
  });

  @override
  List<Object?> get props => [
        language,
        attributesDefault,
        urlLink,
        createdAt,
        updatedAt,
        publishedAt,
        file,
      ];
}

abstract class FileClassEntity extends Equatable implements JsonConvertible {
  final DataEntity? data;

  const FileClassEntity({required this.data});

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
  final dynamic width;
  final dynamic height;
  final dynamic formats;
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
