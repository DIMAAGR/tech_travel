/*
{
   "data":{
      "movie_id":1,
      "user_id":19
   }
 */
class AddLikeModel {
  final int movieId;
  final int userId;

  const AddLikeModel({
    required this.movieId,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'movie_id': movieId,
        'user_id': userId,
      },
    };
  }

  @override
  String toString() {
    return 'AddLikeModel(movieId: $movieId, userId: $userId)';
  }
}
