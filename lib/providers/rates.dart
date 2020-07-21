import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:tuple/tuple.dart';

enum RatesState {
  Loading,
  Completed,
  Initial,
}

const String USER_SUBSCRIPTION_KEY = 'subscription-box';
const String SUBSCRIPTION_KEY = 'subscription';

class RatesProvider extends ChangeNotifier {
  RatesState _state = RatesState.Initial;

  Box get _subscriptionBox => Hive.box(USER_SUBSCRIPTION_KEY);

  Tuple2<bool, List<Map<String, RateFluctuationModel>>> _rateFluctuation;

  Tuple2<bool, List<Map<String, RateFluctuationModel>>> get rateFluctuation =>
      _rateFluctuation;

  RatesState get state => _state;

  void getRateFluctuatioon({String base}) async {
    updateRateState(RatesState.Loading);

    final startDate = DateFormat('y-MM-dd').format(DateTime.now());
    final endDate = DateFormat('y-MM-dd')
        .format(DateTime.now().subtract(Duration(hours: 24)));

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

  List<CurrencyModel> get subscriptions {
    List subscriptions =
        _subscriptionBox.get(SUBSCRIPTION_KEY, defaultValue: []);

    return List<CurrencyModel>.from(subscriptions);
  }

  set subscriptions(List<CurrencyModel> subscription) {
    List<CurrencyModel> _subscription = subscriptions..addAll(subscription);
    _subscriptionBox.put(SUBSCRIPTION_KEY, [
      ...{..._subscription}
    ]);
    notifyListeners();
  }

  set unSubscribe(CurrencyModel currency) {
    List<CurrencyModel> _subscription = subscriptions..remove(currency);
    _subscriptionBox.put(SUBSCRIPTION_KEY, [
      ...{..._subscription}
    ]);
    notifyListeners();
  }
}
