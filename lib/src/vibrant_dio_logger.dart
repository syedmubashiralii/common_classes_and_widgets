import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class VibrantDioLogger extends Interceptor {
  final bool enabled;
  final bool request;
  final bool requestHeader;
  final bool requestBody;
  final bool responseHeader;
  final bool responseBody;
  final bool error;
  final int maxWidth;

  const VibrantDioLogger({
    this.enabled = true,
    this.request = true,
    this.requestHeader = true,
    this.requestBody = true,
    this.responseHeader = false,
    this.responseBody = true,
    this.error = true,
    this.maxWidth = 45,
  });

  void _logWithBorder(String apiName, List<String> lines) {
    final border = '=' * maxWidth;
    // log('\n${border} [$apiName] ${border}');
    for (var line in lines) {
      log(line);
    }
    // log('$border\n');
  }

  String _formatJson(dynamic data) {
    try {
      final encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(data);
    } catch (_) {
      return data.toString();
    }
  }

  // @override
  // void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
  //   if (!enabled || !request) {
  //     super.onRequest(options, handler);
  //     return;
  //   }

  //   final apiName = options.path;

  //   final logs = <String>[
  //     '╔╣ Request ║ ${options.method}',
  //     '║ ${options.uri}',
  //     '╚' + ('═' * maxWidth),
  //   ];

  //   if (requestHeader) {
  //     logs.add('╔ Headers');
  //     options.headers.forEach((key, value) {
  //       logs.add('╟ $key: $value');
  //     });
  //     logs.add('╚' + ('═' * maxWidth));
  //   }

  //   if (requestBody && options.data != null) {
  //     logs.add('╔ Body');
  //     logs.addAll(_formatJson(options.data).split('\n').map((line) => '║ $line'));
  //     logs.add('╚' + ('═' * maxWidth));
  //   }

  //   _logWithBorder(apiName, logs);

  //   super.onRequest(options, handler);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!enabled || !responseBody) {
      super.onResponse(response, handler);
      return;
    }

    final apiName = response.requestOptions.path;
    final logs = <String>[
      '╔╣ Response ║ ${response.requestOptions.method} ║ Status: ${response.statusCode}',
      '║ ${response.requestOptions.uri}',
      '╚' + ('═' * maxWidth),
      '╔ Body',
      ..._formatJson(response.data).split('\n').map((line) => '║ $line'),
      '╚' + ('═' * maxWidth),
    ];

    _logWithBorder(apiName, logs);

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!enabled || !error) {
      super.onError(err, handler);
      return;
    }

    final apiName = err.requestOptions.path;
    final logs = <String>[
      '╔╣ Error ║ ${err.type.toString()}',
      '║ ${err.message ?? "Unknown error"}',
      '╚' + ('═' * maxWidth),
    ];

    if (err.response?.data != null) {
      logs.add('╔ Error Body');
      logs.addAll(_formatJson(err.response!.data).split('\n').map((line) => '║ $line'));
      logs.add('╚' + ('═' * maxWidth));
    }

    _logWithBorder(apiName, logs);

    super.onError(err, handler);
  }
}
