import 'package:tech_travel/src/domain/entities/subtitle_entity.dart';

class SubtitlesModel extends SubtitlesEntity {
  const SubtitlesModel({
    required List<SubtitleDatumModel> data,
    required MetaModel? meta,
  }) : super(data: data, meta: meta);

  factory SubtitlesModel.fromJson(Map<String, dynamic> json) => SubtitlesModel(
        data: json['data'] == null ? [] : List<SubtitleDatumModel>.from(json['data'].map((x) => SubtitleDatumModel.fromJson(x))),
        meta: json['meta'] == null ? null : MetaModel.fromJson(json['meta']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data.map((x) => x.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}

class SubtitleDatumModel extends SubtitlesDatumEntity {
  const SubtitleDatumModel({
    required super.id,
    required DatumAttributesModel? super.attributes,
  });

  factory SubtitleDatumModel.fromJson(Map<String, dynamic> json) => SubtitleDatumModel(
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
    required super.language,
    required super.attributesDefault,
    required super.urlLink,
    required super.createdAt,
    required super.updatedAt,
    required super.publishedAt,
    required FileClassModel? super.file,
  });

  factory DatumAttributesModel.fromJson(Map<String, dynamic> json) => DatumAttributesModel(
        language: json['language'],
        attributesDefault: json['default'],
        urlLink: json['url_link'],
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
        file: json['file'] == null ? null : FileClassModel.fromJson(json['file']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'language': language,
        'default': attributesDefault,
        'url_link': urlLink,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'publishedAt': publishedAt?.toIso8601String(),
        'file': file?.toJson(),
      };
}

class FileClassModel extends FileClassEntity {
  const FileClassModel({required DataModel? data}) : super(data: data);

  factory FileClassModel.fromJson(Map<String, dynamic> json) => FileClassModel(
        data: json['data'] == null ? null : DataModel.fromJson(json['data']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
      };
}

class DataModel extends DataEntity {
  const DataModel({
    required super.id,
    required DataAttributesModel? super.attributes,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        id: json['id'],
        attributes: json['attributes'] == null ? null : DataAttributesModel.fromJson(json['attributes']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'attributes': attributes?.toJson(),
      };
}

class DataAttributesModel extends DataAttributesEntity {
  const DataAttributesModel({
    required super.name,
    required super.alternativeText,
    required super.caption,
    required super.width,
    required super.height,
    required super.formats,
    required super.hash,
    required super.ext,
    required super.mime,
    required super.size,
    required super.url,
    required super.previewUrl,
    required super.provider,
    required super.providerMetadata,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DataAttributesModel.fromJson(Map<String, dynamic> json) => DataAttributesModel(
        name: json['name'],
        alternativeText: json['alternativeText'],
        caption: json['caption'],
        width: json['width'],
        height: json['height'],
        formats: json['formats'],
        hash: json['hash'],
        ext: json['ext'],
        mime: json['mime'],
        size: json['size'],
        url: json['url'],
        previewUrl: json['previewUrl'],
        provider: json['provider'],
        providerMetadata: json['provider_metadata'],
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      );

  @override
  Map<String, dynamic> toJson() => {
        'name': name,
        'alternativeText': alternativeText,
        'caption': caption,
        'width': width,
        'height': height,
        'formats': formats,
        'hash': hash,
        'ext': ext,
        'mime': mime,
        'size': size,
        'url': url,
        'previewUrl': previewUrl,
        'provider': provider,
        'provider_metadata': providerMetadata,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
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
