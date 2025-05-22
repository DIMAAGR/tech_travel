import 'package:dio/dio.dart';
import 'package:tech_travel/src/data/api/interceptors/auth_interceptor.dart';

Dio createDio() {
  final dio = Dio();
  dio.interceptors.add(AuthInterceptor());
  return dio;
}
