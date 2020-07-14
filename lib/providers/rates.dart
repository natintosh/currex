import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

enum RatesState {
  Loading,
  Completed,
  Initial,
}

class RatesProvider extends ChangeNotifier {
  RatesState _state = RatesState.Initial;

  Tuple2<bool, List<Map<String, RateFluctuationModel>>> _rateFluctuation;

  Tuple2<bool, List<Map<String, RateFluctuationModel>>> get rateFluctuation =>
      _rateFluctuation;

  RatesState get state => _state;

  void getRateFluctuatioon() async {
    updateRateState(RatesState.Loading);

    final startDate = DateFormat('y-MM-dd').format(DateTime.now());
    final endDate = DateFormat('y-MM-dd')
        .format(DateTime.now().subtract(Duration(hours: 24)));
    final base = 'NGN';

    print('\n\n\n Start Date: $startDate \n\n\n End Date: $endDate \n\n\n');

    Tuple2<bool, List<Map<String, RateFluctuationModel>>> fluctuation =
        await ExchanegRateService.getFluctuation(
      startDate: startDate,
      endDate: endDate,
      base: base,
    );

    _rateFluctuation = fluctuation;

    updateRateState(RatesState.Completed);
  }

  void updateRateState(RatesState state) {
    _state = state;
    notifyListeners();
  }
}
