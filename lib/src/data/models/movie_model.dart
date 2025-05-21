import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.genre,
    required super.description,
    required super.releaseDate,
    required super.lastComment,
    required super.lastCommentUserImage,
    required super.commentsCount,
    required super.shareLink,
    required super.trailerUrl,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      genre: json['genre'] ?? '',
      description: json['description'] ?? '',
      releaseDate: DateTime.tryParse(json['release_date'] ?? '') ?? DateTime.now(),
      lastComment: json['last_comment'] ?? '',
      lastCommentUserImage: json['last_comment_user_image'] ?? '',
      commentsCount: json['comments_count'] ?? 0,
      shareLink: json['share_link'] ?? '',
      trailerUrl: json['trailer_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'description': description,
      'release_date': releaseDate.toIso8601String(),
      'last_comment': lastComment,
      'last_comment_user_image': lastCommentUserImage,
      'comments_count': commentsCount,
      'share_link': shareLink,
      'trailer_url': trailerUrl,
    };
  }
}
