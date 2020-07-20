import 'package:currex/models/app_theme/app_theme_model.dart';
import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/pages/settings/views/default_currency.dart';
import 'package:currex/pages/settings/widgets/settings_category.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const SettingsPageRouteName = '/settings';

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _SettingsView(this),
    );
  }

  String get currencyLabel {
    CurrencyModel value = context.read<AppProvider>().defaultCurrency;
    return '${value.code} - ${value.namePlural}';
  }

  String get themeLabel {
    AppTheme theme = Provider.of<AppProvider>(context).appTheme;
    return theme == AppTheme.Light
        ? 'Light'
        : theme == AppTheme.Dark ? 'Dark' : 'System';
  }

  void onCurrencyTilesPressed() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DefaultCurrency();
      },
    ));
  }

  void onThemeTilePressed() {
    showThemeDialog();
  }

  void close() {
    Navigator.pop(context);
  }

  void updateTheme(AppTheme theme) {
    context.read<AppProvider>().appTheme = theme;
    Navigator.pop(context);
  }

  void showThemeDialog() {
    showDialog<AppTheme>(
      context: context,
      builder: (BuildContext context) {
        AppTheme theme =
            context.select<AppProvider, AppTheme>((value) => value.appTheme);

        return SimpleDialog(
          title: Text('Theme'),
          children: <Widget>[
            RadioListTile<AppTheme>(
              title: Text('Light'),
              value: AppTheme.Light,
              groupValue: theme,
              onChanged: updateTheme,
            ),
            RadioListTile<AppTheme>(
              title: Text('Dark'),
              value: AppTheme.Dark,
              groupValue: theme,
              onChanged: updateTheme,
            ),
            RadioListTile<AppTheme>(
              title: Text('System'),
              value: AppTheme.System,
              groupValue: theme,
              onChanged: updateTheme,
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(onPressed: close, child: Text('CLOSE'))
              ],
            )
          ],
        );
      },
    );
  }
}

class _SettingsView extends WidgetView<SettingsPage, _SettingsPageState> {
  final _SettingsPageState state;

  _SettingsView(this.state) : super(state: state);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SettingsCategory(
            title: 'Preferences',
            tiles: <Widget>[
              ListTile(
                leading: Icon(Icons.local_atm),
                title: Text('Default currency'),
                subtitle: Text(state.currencyLabel),
                onTap: state.onCurrencyTilesPressed,
              ),
              ListTile(
                leading: Icon(Icons.style),
                title: Text('Theme'),
                subtitle: Text(state.themeLabel),
                onTap: state.onThemeTilePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
