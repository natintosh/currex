import 'dart:convert';

import 'package:currex/models/currency/currency_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() : super();

  Map<String, CurrencyModel> _currencies = Map();

  Map<String, CurrencyModel> get currencies => _currencies;

  void loadCurrencies(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/json/currencies.json');

    Map<String, dynamic> parsedData = json.decode(data);

    _currencies = parsedData.map(
      (key, value) => MapEntry(
        key,
        CurrencyModel.fromJson(parsedData[key]),
      ),
    );

    notifyListeners();
  }

  void initialise(BuildContext context) {
    this.loadCurrencies(context);
  }
}
