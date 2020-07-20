import 'dart:convert';

import 'package:currex/models/app_theme/app_theme_model.dart';
import 'package:currex/models/currency/currency_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';

const String APP_PREFERENCE_KEY = 'preference';

const String DEFAULT_CURRENCY_KEY = 'default-currency';
const String DEFAULT_CURRENCY_CODE = 'NGN';

const String APP_THEME_KEY = 'app-theme';

class AppProvider extends ChangeNotifier {
  AppProvider() : super();

  Box get preferenceBox => Hive.box(APP_PREFERENCE_KEY);

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
    // this.openBoxes();
  }

  CurrencyModel get defaultCurrency {
    CurrencyModel currency = preferenceBox.get(DEFAULT_CURRENCY_KEY,
        defaultValue: _currencies[DEFAULT_CURRENCY_CODE]);
    return currency;
  }

  set defaultCurrency(CurrencyModel currency) {
    preferenceBox.put(DEFAULT_CURRENCY_KEY, currency);
    notifyListeners();
  }

  AppTheme get appTheme {
    AppTheme appTheme =
        preferenceBox.get(APP_THEME_KEY, defaultValue: AppTheme.Light);
    return appTheme;
  }

  set appTheme(AppTheme theme) {
    preferenceBox.put(APP_THEME_KEY, theme);
    notifyListeners();
  }
}
