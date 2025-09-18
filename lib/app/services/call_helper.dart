import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:protask1/app/utils/app_globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallHelper {
  static final CallHelper _instance = CallHelper._internal();
  factory CallHelper() => _instance;

  late Dio _dio;

  bool _isRefreshing = false;

  CallHelper._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: AppGlobals.instance.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    );

    _dio = Dio(options);

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _getToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        debugPrint("❌ Dio Error: ${e.message}");

        // If token expired and not retrying already
        if (e.response?.statusCode == 401 && !_isRefreshing) {
          final refreshed = await _refreshToken();
          if (refreshed) {
            // Retry the failed request with new token
            final newToken = AppGlobals.instance.accessToken;
            final options = e.requestOptions;
            options.headers['Authorization'] = 'Bearer $newToken';

            try {
              final cloneReq = await _dio.fetch(options);
              return handler.resolve(cloneReq);
            } catch (error) {
              return handler.reject(error as DioException);
            }
          } else {
            await AppGlobals.instance.logout();
            return;
          }
        }

        return handler.next(e);
      },
    ));
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<bool> _refreshToken() async {
    if (_isRefreshing) return false;
    _isRefreshing = true;

    try {
      final accessToken = AppGlobals.instance.accessToken;
      final refreshToken = AppGlobals.instance.refreshToken;

      if (refreshToken == null ||
          refreshToken.isEmpty ||
          accessToken == null ||
          accessToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        '${AppGlobals.instance.baseUrl}/auth/refresh-token',
        data: {
          'refreshToken': refreshToken,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['accessToken'] != null) {
        AppGlobals.instance.accessToken = response.data['accessToken'];
        await AppGlobals.instance.saveToStorage();
        return true;
      }
    } catch (e) {
      debugPrint("❌ Failed to refresh token: $e");
    } finally {
      _isRefreshing = false;
    }

    return false;
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<dynamic> delete(String path, {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.delete(path, data: data);
      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<dynamic> uploadFile({
    required String path,
    required String fileField,
    required String filePath,
    Map<String, dynamic>? otherFields,
    String method = 'POST',
  }) async {
    try {
      final formData = FormData.fromMap({
        if (filePath.isNotEmpty)
          fileField: await MultipartFile.fromFile(
            filePath,
            filename: filePath.split('/').last,
          ),
        if (otherFields != null) ...otherFields,
      });

      late Response response;
      switch (method.toUpperCase()) {
        case 'PUT':
          response = await _dio.put(path, data: formData);
          break;
        case 'PATCH':
          response = await _dio.patch(path, data: formData);
          break;
        default:
          response = await _dio.post(path, data: formData);
      }

      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  dynamic _handleDioError(DioException error) {
    String errorMessage = "Something went wrong";

    if (error.type == DioExceptionType.connectionTimeout) {
      errorMessage = "Connection timeout";
    } else if (error.type == DioExceptionType.sendTimeout) {
      errorMessage = "Request timeout";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      errorMessage = "Response timeout";
    } else if (error.type == DioExceptionType.badResponse) {
      errorMessage = "Server error: ${error.response?.statusCode}";
      return {
        "success": false,
        "statusCode": error.response?.statusCode,
        "message": error.response?.data["message"] ?? errorMessage,
        "data": error.response?.data,
      };
    } else if (error.type == DioExceptionType.cancel) {
      errorMessage = "Request cancelled";
    } else {
      errorMessage = error.message ?? "Something went wrong";
    }

    return {
      "success": false,
      "message": errorMessage,
    };
  }
}

extension DioPatchExtension on CallHelper {
  Future<dynamic> patch(String path, {dynamic data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return response.data;
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }
}

extension ServerPing on CallHelper {
  Future<void> pingServer() async {
    try {
      await _dio.get('/health');
      debugPrint("✅ Server is awake now!");
    } catch (e) {
      debugPrint("⚠️ Server wakeup failed: $e");
    }
  }
}
