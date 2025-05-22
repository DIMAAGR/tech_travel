import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user?.getIdTokenResult();

    if (idToken != null) {
      options.headers['Authorization'] = 'Bearer ${idToken.token}';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      print('Error: ${err.message}');
      print('Response: ${err.response}');
      print('Request: ${err.requestOptions}');
      print('Status Code: ${err.response?.statusCode}');
      print('Headers: ${err.requestOptions.headers}');
      print('Data: ${err.response?.data}');
      print('Error Type: ${err.type}');
      print('Error Message: ${err.message}');
      print('Error Stack Trace: ${err.stackTrace}');
      print('Error Response: ${err.response?.data}');
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('Response: ${response.data}');
      print('Status Code: ${response.statusCode}');
      print('Headers: ${response.headers}');
      print('Request: ${response.requestOptions}');
      print('Response Headers: ${response.headers}');
      print('Response Status Message: ${response.statusMessage}');
      print('Response Extra: ${response.extra}');
    }
    super.onResponse(response, handler);
  }
}
