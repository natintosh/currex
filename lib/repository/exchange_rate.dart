import 'package:currex/models/response/response_model.dart';
import 'package:currex/utils/helpers/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';

const String BASE_URL = 'https://api.exchangerate.host/';
const String latestEndPoint = 'latest';
const String fluctuationEndPoint = 'fluctuation';
const String timeSeriesEndPoint = 'timeseries';

class ExchangeRateRepository {
  static const int _kDecimalPlaces = 15;

  static Future<ResponseModel> getLatestRates() async {
    final dio = DioHelper.getDio;
    dio.interceptors..add(DioResponseInterceptor());

    final path = '';

    final url = BASE_URL + latestEndPoint;

    try {
      Response response = await dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 24),
          primaryKey: url,
          subKey: path,
          forceRefresh: true,
        ),
      );

      return response.data;
    } on DioError {
      return null;
    }
  }

  static Future<ResponseModel> getFluctuation({
    @required String startDate,
    @required String endDate,
    @required String base,
    String symbols = '',
  }) async {
    final dio = DioHelper.getDio;
    dio.interceptors..add(DioResponseInterceptor());

    final path =
        '?start_date=$startDate&end_date=$endDate&base=$base&places=$_kDecimalPlaces&symbols=$symbols';

    final url = BASE_URL + fluctuationEndPoint + path;

    try {
      Response response = await dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 24),
          primaryKey: url,
          subKey: path,
          forceRefresh: true,
        ),
      );

      return response.data;
    } on DioError {
      return null;
    }
  }

  static Future<ResponseModel> getTimeSeries({
    @required String base,
    @required String startDate,
    @required String endDate,
    String symbols = '',
  }) async {
    final dio = DioHelper.getDio;
    dio.interceptors..add(DioResponseInterceptor());

    final path =
        '?base=$base&start_date=$startDate&end_date=$endDate&symbols=$symbols';

    final url = BASE_URL + timeSeriesEndPoint + path;

    try {
      Response response = await dio.get(
        url,
        options: buildCacheOptions(
          Duration(hours: 24),
          primaryKey: url,
          subKey: path,
          forceRefresh: true,
        ),
      );

      return response.data;
    } on DioError {
      return null;
    }
  }
}
