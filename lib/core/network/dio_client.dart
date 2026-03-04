import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:riverpod_demo/app/settings/auth_status_provider.dart';
import 'package:riverpod_demo/core/network/auth_interceptor.dart';
import 'package:riverpod_demo/core/network/token_storage.dart';
part 'dio_client.g.dart';

@riverpod
Dio dioClient(DioClientRef ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.your-domain.com',
    connectTimeout: const Duration(seconds: 15),
  ));

  final storage = ref.watch(tokenStorageProvider);

  dio.interceptors.addAll([
    AuthInterceptor(
      storage: storage,
      dio: dio,
      onLogout: () {
        storage.clear();
        ref.read(authStatusProvider.notifier).updateStatus(false);
      },
    ),
    if (kDebugMode) CurlLoggerDioInterceptor(printOnSuccess: true),
  ]);

  return dio;
}