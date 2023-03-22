// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:dio_logger/dio_logger.dart';
import '../../base/model/base_model.dart';
import '../../constants/app_constants.dart';

class NetworkManager {
  static NetworkManager? _instance;
  static NetworkManager get instance {
    _instance ??= NetworkManager._init();
    return _instance!;
  }

  NetworkManager._init() {
    final BaseOptions baseOptions = BaseOptions(
      baseUrl: ApplicationConstants.baseURL,
      headers: {
        "Charset": "utf-8",
        'Authorization': 'fYluKT8f2AX5kCRnLL2KX2kjNdQKixim70q6sQJvK1kBdnylTkVrAs4P',
      },
      validateStatus: (_) => true,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.plain,
    );

    _dio = Dio(baseOptions);
    _dio.interceptors.add(dioLoggerInterceptor);
  }

  late Dio _dio;

  Dio get dio => _dio;

  Future get<T extends IBaseModel>({
    required String path,
    required T model,
    Map<String, dynamic>? queryParameters,
    BuildContext? context,
  }) async {
    try {
      if (context != null) {
        //show loader
      }
      final response = await _dio.get(path, queryParameters: queryParameters);

      switch (response.statusCode) {
        case HttpStatus.ok:
          return _jsonBodyParser<T>(model, response.data, response);

        default:
          return _jsonBodyParser<T>(model, response.data, response);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (context != null) {
        //hide loader
      }
    }
  }
}

dynamic _jsonBodyParser<T>(IBaseModel model, String body, response) async {
  try {
    final jsonBody = jsonDecode(body);

    if (jsonBody is List) {
      return jsonBody.map((e) => model.fromJson(e)).toList().cast<T>();
    } else if (jsonBody is Map) {
      return model.fromJson(jsonBody);
    } else {
      return jsonBody;
    }
  } catch (ex) {
    return response;
  }
}
