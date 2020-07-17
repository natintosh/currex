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

  void onCurrencyTilesPressed() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DefaultCurrency();
      },
    ));
  }

  void onThemeTilePressed() {}
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
                subtitle: Text(
                  context.select<AppProvider, String>(
                    (value) =>
                        '${value.defaultCurrency.code} - ${value.defaultCurrency.namePlural}',
                  ),
                ),
                onTap: state.onCurrencyTilesPressed,
              ),
              ListTile(
                leading: Icon(Icons.style),
                title: Text('Theme'),
                subtitle: Text('Light'),
                onTap: state.onThemeTilePressed,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
