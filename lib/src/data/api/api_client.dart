// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';
// import 'package:tech_travel/src/core/const/api_constants.dart';

// @RestApi(baseUrl: ApiConstants.baseUrl)
// abstract class ApiClient {
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

//   @GET('/movies')
//   Future<List<MovieModel>> getMovies();

//   // Auth
//   @POST('/auth/local/register')
//   Future<HttpResponse> registerUser(@Body() Map<String, dynamic> body);

//   // User
//   @PATCH('/users/updateMe')
//   Future<HttpResponse> updateMe(@Body() Map<String, dynamic> body);

//   @GET('/users/me')
//   Future<UserModel> getCurrentUser();

//   @DELETE('/users/{id}')
//   Future<HttpResponse> deleteUser(@Path('id') String userId);

//   // Movies
//   @GET('/movies?populate=poster')
//   Future<List<MovieModel>> getMovies();

//   // Likes
//   @GET('/likes?populate=*')
//   Future<List<LikeModel>> getLikes();

//   @POST('/likes')
//   Future<HttpResponse> postLike(@Body() Map<String, dynamic> body);

//   @DELETE('/likes/{id}')
//   Future<HttpResponse> deleteLike(@Path('id') String likeId);

//   // Subtitles
//   @GET('/subtitles')
//   Future<List<SubtitleModel>> getSubtitles(@Query('filters[movie_id]') int movieId);
// }
