import 'package:tech_travel/src/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required List<DatumModel> data,
    required MetaModel? meta,
  }) : super(data: data, meta: meta);

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      data: json['data'] == null ? [] : List<DatumModel>.from(json['data']!.map((x) => DatumModel.fromJson(x))),
      meta: json['meta'] == null ? null : MetaModel.fromJson(json['meta']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'data': data.map((x) => x.toJson()).toList(),
        'meta': meta?.toJson(),
      };
}

class DatumModel extends DatumEntity {
  const DatumModel({
    required super.id,
    required DatumAttributesModel? attributes,
  }) : super(attributes: attributes);

  factory DatumModel.fromJson(Map<String, dynamic> json) => DatumModel(
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
    required super.name,
    required super.synopsis,
    required super.currentlyPlaying,
    required super.streamLink,
    required super.genre,
    required super.endDate,
    required super.createdAt,
    required super.updatedAt,
    required super.publishedAt,
    required PosterModel? super.poster,
  });

  factory DatumAttributesModel.fromJson(Map<String, dynamic> json) => DatumAttributesModel(
        name: json['name'],
        synopsis: json['synopsis'],
        currentlyPlaying: json['currently_playing'],
        streamLink: json['stream_link'],
        genre: json['genre'],
        endDate: DateTime.tryParse(json['end_date'] ?? ''),
        createdAt: DateTime.tryParse(json['createdAt'] ?? ''),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
        poster: json['poster'] == null ? null : PosterModel.fromJson(json['poster']),
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
        'poster': poster?.toJson(),
      };
}

class PosterModel extends PosterEntity {
  const PosterModel({
    required DataModel? data,
  }) : super(data: data);

  factory PosterModel.fromJson(Map<String, dynamic> json) => PosterModel(
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
    required FormatsModel? super.formats,
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
        formats: json['formats'] == null ? null : FormatsModel.fromJson(json['formats']),
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
        'formats': formats?.toJson(),
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

class FormatsModel extends FormatsEntity {
  const FormatsModel({
    required LargeModel? large,
    required LargeModel? small,
    required LargeModel? medium,
    required LargeModel? thumbnail,
  }) : super(
          large: large,
          small: small,
          medium: medium,
          thumbnail: thumbnail,
        );

  factory FormatsModel.fromJson(Map<String, dynamic> json) => FormatsModel(
        large: json['large'] == null ? null : LargeModel.fromJson(json['large']),
        small: json['small'] == null ? null : LargeModel.fromJson(json['small']),
        medium: json['medium'] == null ? null : LargeModel.fromJson(json['medium']),
        thumbnail: json['thumbnail'] == null ? null : LargeModel.fromJson(json['thumbnail']),
      );

  @override
  Map<String, dynamic> toJson() => {
        'large': large?.toJson(),
        'small': small?.toJson(),
        'medium': medium?.toJson(),
        'thumbnail': thumbnail?.toJson(),
      };
}

class LargeModel extends LargeEntity {
  const LargeModel({
    required super.ext,
    required super.url,
    required super.hash,
    required super.mime,
    required super.name,
    required super.path,
    required super.size,
    required super.width,
    required super.height,
  });

  factory LargeModel.fromJson(Map<String, dynamic> json) => LargeModel(
        ext: json['ext'],
        url: json['url'],
        hash: json['hash'],
        mime: json['mime'],
        name: json['name'],
        path: json['path'],
        size: json['size'],
        width: json['width'],
        height: json['height'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'ext': ext,
        'url': url,
        'hash': hash,
        'mime': mime,
        'name': name,
        'path': path,
        'size': size,
        'width': width,
        'height': height,
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
