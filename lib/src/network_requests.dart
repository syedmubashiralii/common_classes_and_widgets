import 'package:commons_classes_functions/src/vibrant_dio_logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dio/src/response.dart' as DioResponse;
import 'package:flutter/foundation.dart';

class Requests {
  static final Map<String, CancelToken> _activeRequests = {};

  static Dio getDio({
    Map<String, String>? headers,
    bool hasBearerToken = true,
    bool containHeaders = false,
    bool showLoadingDialog = true,
    bool printResponse = false,
    String loadingText = "Please wait",
    String serverUrl = 'https://httpbin.org/',
    String? requestId,
    CancelToken? cancelToken, // You can pass this externally
  }) {
    if (containHeaders) {
      headers ??= {
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      if (hasBearerToken) {
        headers.addAll({"Authorization": "Bearer --token"});
      }
    }

    final token = cancelToken ?? CancelToken();
    if (requestId != null) {
      _activeRequests[requestId] = token;
    }

    BaseOptions options = BaseOptions(
      baseUrl: serverUrl,
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 25000),
      validateStatus: (status) {
        if (status! == 401 || status == 403) {
          // Handle unauthorized user
        }
        if (status == 502) {
          // Please try again
        }
        return status <= 500;
      },
      headers: headers,
    );

    Dio d = Dio(options);
    var adapter = IOHttpClientAdapter();
    d.interceptors.add(VibrantDioLogger(
      enabled: kDebugMode,
      request: true,
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    d.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        if (showLoadingDialog) {
          // Show loading dialog
        }
        options.cancelToken = token;
        return handler.next(options);
      },
      onResponse: (DioResponse.Response response,
          ResponseInterceptorHandler handler) async {
        if (showLoadingDialog) {
          // Dismiss loading
        }

        if (requestId != null) {
          _activeRequests.remove(requestId);
        }

        return handler.next(response);
      },
      onError: (DioException e, ErrorInterceptorHandler handler) async {
        if (showLoadingDialog) {
          // Dismiss loading
        }
        if (requestId != null) {
          _activeRequests.remove(requestId);
        }
        return handler.next(e);
      },
    ));

    return d;
  }

  static void cancelRequest(String requestId) {
    if (_activeRequests.containsKey(requestId)) {
      _activeRequests[requestId]?.cancel("Request [$requestId] cancelled");
      _activeRequests.remove(requestId);
    }
  }

  static void cancelAllRequests() {
    for (var token in _activeRequests.values) {
      token.cancel("Cancelled by user");
    }
    _activeRequests.clear();
  }
}


///Exmaple usage:
///
// String requestId = "loginRequest";

// try {
//   final response = await Requests.getDio(requestId: requestId).post('/login', data: {"email": "test", "pass": "123"});
//   print(response.data);
// } catch (e) {
//   print("Request failed or was cancelled");
// }

// // Cancel if needed
// Requests.cancelRequest("loginRequest");