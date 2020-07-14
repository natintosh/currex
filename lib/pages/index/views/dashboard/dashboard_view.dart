import 'package:currex/pages/index/views/dashboard/widgets/dashboard_list_item.dart';
import 'package:currex/pages/index/views/dashboard/widgets/dashboard_list_item_add.dart';
import 'package:currex/pages/index/views/dashboard/widgets/no_data_widget.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class DashboardView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  double get illustrationWidth => context.widthPct(0.6);
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currex'),
      ),
      body: _View(this),
    );
  }

  void addToDashboard() {}
}

class _View extends WidgetView<DashboardView, _DashboardViewState> {
  final _DashboardViewState state;

  _View(this.state);

  @override
  Widget build(BuildContext context) {
    return state.isEmpty
        ? NoDataWidget(
            width: state.illustrationWidth,
            onTap: state.addToDashboard,
          )
        : ListView(
            children: <Widget>[
              DashboardListItem(
                isoCode: 'US',
                countryShortName: 'USA',
                currencyName: 'Dollar',
                currencySymbol: '\$',
                buyValue: 450.00,
                sellValue: 420.00,
                previousValues: null,
                changes: -0.45,
                onTap: null,
                onMoreOptionTap: null,
              ),
              DashboardListItem(
                isoCode: 'CN',
                countryShortName: 'CHN',
                currencyName: 'Yuan',
                currencySymbol: 'Y',
                buyValue: 450.00,
                sellValue: 420.00,
                previousValues: null,
                changes: -0.45,
                onTap: null,
                onMoreOptionTap: null,
              ),
              DashboardListItem(
                isoCode: 'CN',
                countryShortName: 'CHN',
                currencyName: 'Yuan',
                currencySymbol: 'Y',
                buyValue: 450.00,
                sellValue: 420.00,
                previousValues: null,
                changes: -0.45,
                onTap: null,
                onMoreOptionTap: null,
              ),
              DashboardListItemAdd(),
            ],
          );
  }
}
