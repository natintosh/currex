import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/models/response/response_model.dart';
import 'package:currex/repository/exchange_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class ExchanegRateService {
  static Future<Tuple2<bool, List<Map<String, RateFluctuationModel>>>>
      getFluctuation({
    @required String startDate,
    @required String endDate,
    @required String base,
    List<String> symbols = const [],
  }) async {
    ResponseModel response = await ExchangeRateRepository.getFluctuation(
      base: base,
      endDate: endDate,
      startDate: startDate,
      symbols: symbols.join(','),
    );

    if (response == null) {
      return Tuple2(false, null);
    }

    List<Map<String, RateFluctuationModel>> data =
        response.rates.keys.map((String key) {
      return {
        key: RateFluctuationModel.fromJson(
            response.rates[key] as Map<String, dynamic>)
      } as Map<String, RateFluctuationModel>;
    }).toList();

    return Tuple2(response.success, data);
  }

  static Future<Tuple2<bool, List<num>>> getTimeSeries({
    @required String base,
    @required String startDate,
    @required String endDate,
    List<String> symbols = const [],
  }) async {
    ResponseModel response = await ExchangeRateRepository.getTimeSeries(
      base: base,
      startDate: startDate,
      endDate: endDate,
      symbols: symbols.join(','),
    );

    if (response == null) {
      return Tuple2(false, null);
    }

    List<num> data = response.rates.values.map((e) {
      return (e as Map).values.first as num;
    }).toList();

    return Tuple2(response.success, data);
  }
}
