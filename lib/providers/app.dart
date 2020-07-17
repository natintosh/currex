import 'dart:convert';

import 'package:currex/models/currency/currency_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

const String APP_PREFERENCE = 'preference';

const String DEFAULT_CURRENCY = 'default-currency';
const String DEFAULT_CURRENCY_CODE = 'NGN';

class AppProvider extends ChangeNotifier {
  AppProvider() : super();

  Box get preferenceBox => Hive.box(APP_PREFERENCE);

  Map<String, CurrencyModel> _currencies = Map();

  Map<String, CurrencyModel> get currencies => _currencies;

  void openBoxes() async {
    await Hive.initFlutter();
    Hive.registerAdapter(CurrencyModelAdapter());
    await Hive.openBox(APP_PREFERENCE);
  }

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
    this.openBoxes();
  }

  CurrencyModel get defaultCurrency {
    CurrencyModel currency = preferenceBox.get(DEFAULT_CURRENCY,
        defaultValue: _currencies[DEFAULT_CURRENCY_CODE]);
    return currency;
  }

  set defaultCurrency(CurrencyModel currency) {
    preferenceBox.put(DEFAULT_CURRENCY, currency);
    notifyListeners();
  }
}
