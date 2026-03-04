import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'token_storage.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage storage;
  final Dio dio;
  final VoidCallback onLogout;

  AuthInterceptor({required this.storage, required this.dio, required this.onLogout});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await storage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.getRefreshToken();
      if (refreshToken != null) {
        try {
          // Thực hiện call refresh token
          final response = await dio.post('/auth/refresh', data: {'refresh': refreshToken});
          final newAccess = response.data['access'];
          final newRefresh = response.data['refresh'];

          await storage.saveTokens(newAccess, newRefresh);

          // Gửi lại request cũ với token mới
          err.requestOptions.headers['Authorization'] = 'Bearer $newAccess';
          final cloneReq = await dio.fetch(err.requestOptions);
          return handler.resolve(cloneReq);
        } catch (e) {
          onLogout(); // Refresh thất bại -> Logout
        }
      } else {
        onLogout(); // Không có refresh token -> Logout
      }
    }
    return handler.next(err);
  }
}