import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/auth/local/register')
  Future<HttpResponse> registerUser(@Body() Map<String, dynamic> body);

  @PATCH('/users/updateMe')
  Future<HttpResponse> updateMe(@Body() Map<String, dynamic> body);

  // @GET('/users/me')
  // Future<void> getCurrentUser();

  // @DELETE('/users/{id}')
  // Future<HttpResponse> deleteUser(@Path('id') String userId);

  // @GET('/movies?populate=poster')
  // Future<List<dynamic>> getMovies();

  // @GET('/likes?populate=*')
  // Future<List<dynamic>> getLikes();

  // @POST('/likes')
  // Future<HttpResponse> postLike(@Body() Map<String, dynamic> body);

  // @DELETE('/likes/{id}')
  // Future<HttpResponse> deleteLike(@Path('id') String likeId);

  // @GET('/subtitles')
  // Future<List<dynamic>> getSubtitles(@Query('filters[movie_id]') int movieId);
}
