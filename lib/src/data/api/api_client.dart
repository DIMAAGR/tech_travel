import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tech_travel/src/data/models/likes_model.dart';
import 'package:tech_travel/src/data/models/movie_model.dart';
import 'package:tech_travel/src/data/models/subtitle_model.dart';
import 'package:tech_travel/src/data/models/user_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/auth/local/register')
  Future<HttpResponse> registerUser(@Body() Map<String, dynamic> body);

  @PATCH('/users/updateMe')
  Future<HttpResponse> updateMe(@Body() Map<String, dynamic> body);

  @GET('/users/me')
  Future<UserModel> getCurrentUser();

  @DELETE('/users/{id}')
  Future<HttpResponse> deleteUser(@Path('id') String userId);

  @GET('/movies?populate=poster')
  Future<MovieModel> getMovies();

  @GET('/likes?populate=*')
  Future<LikesModel> getLikes();

  @POST('/likes')
  Future<HttpResponse> postLike(@Body() Map<String, dynamic> body);

  @DELETE('/likes/{id}')
  Future<HttpResponse> deleteLike(@Path('id') String likeId);

  @GET('/subtitles')
  Future<SubtitlesModel> getSubtitles(@Query('filters[movie_id]') int movieId);
}
