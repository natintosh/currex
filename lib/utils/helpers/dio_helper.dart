import 'dart:io';

import 'package:currex/models/response/response_model.dart';
import 'package:currex/repository/exchange_rate.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';

class DioHelper {
  static BaseOptions options = BaseOptions(
    connectTimeout: 5500,
    receiveTimeout: 3500,
  );

  static Dio get getDio {
    Dio dio = Dio(options);
    dio.interceptors
      ..addAll([
        LogInterceptor(),
        DioCacheManager(
          CacheConfig(
              baseUrl: BASE_URL,
              defaultMaxAge: Duration(
                hours: 24,
              )),
        ).interceptor
      ]);
    return dio;
  }
}

class DioResponseInterceptor implements Interceptor {
  @override
  Future<RequestOptions> onRequest(RequestOptions options) async {
    return options;
  }

  @override
  Future<Response> onResponse(Response response) async {
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> result = response.data as Map<String, dynamic>;

      ResponseModel responseModel = ResponseModel.fromJson(result);

      return response..data = responseModel;
    }

    return response;
  }

  @override
  Future<DioError> onError(DioError err) async {
    return err;
  }
}
