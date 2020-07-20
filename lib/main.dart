import 'package:currex/app.dart';
import 'package:currex/models/app_theme/app_theme_model.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/providers/rates.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/currency/currency_model.dart';

void main() async {
  await openBoxes();
  runApp(App());
}

Future<void> openBoxes() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CurrencyModelAdapter());
  Hive.registerAdapter(AppThemeAdapter());
  await Hive.openBox(APP_PREFERENCE_KEY);
  await Hive.openBox(USER_SUBSCRIPTION_KEY);
}
