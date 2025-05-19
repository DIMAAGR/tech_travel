class MovieEntity {
  final String id;
  final String title;
  final String genre;
  final String description;
  final DateTime releaseDate;
  final String lastComment;
  final String lastCommentUserImage;
  final int commentsCount;
  final String trailerUrl;
  final String shareLink;

  const MovieEntity({
    required this.trailerUrl,
    required this.id,
    required this.title,
    required this.genre,
    required this.description,
    required this.releaseDate,
    required this.lastComment,
    required this.lastCommentUserImage,
    required this.commentsCount,
    required this.shareLink,
  });
}
