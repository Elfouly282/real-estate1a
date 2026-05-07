import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../di/di.dart';
import '../funcations/app_functions.dart';
import '../security/security_helper.dart';

@lazySingleton
class ApiManager {
  final Dio dio;

  ApiManager(this.dio);

  final token = getIt<AuthStorage>().token ?? '';
  final userId = getIt<AuthStorage>().userId ?? '';

  Future<void> _setHeaders() async {
    final lang = AppFunctions.getLanguageCode();

    dio.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'locale': lang,
      'Authorization': 'Bearer $token',
      'userId': userId,
    };
  }

  // 🔥 GET
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    return dio.get(
      url,
      queryParameters: query,
    );
  }

  // 🔥 POST
  Future<Response> post({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    return dio.post(
      url,
      data: data,
      queryParameters: query,
    );
  }

  // 🔥 PUT
  Future<Response> put({
    required String url,
    dynamic data,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    return dio.put(
      url,
      data: data,
      queryParameters: query,
    );
  }

  // 🔥 DELETE
  Future<Response> delete({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    await _setHeaders();

    return dio.delete(
      url,
      queryParameters: query,
    );
  }
}