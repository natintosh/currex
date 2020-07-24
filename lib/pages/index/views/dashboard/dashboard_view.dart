import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/pages/index/views/dashboard/widgets/dashboard_list_item.dart';
import 'package:currex/pages/index/views/dashboard/widgets/no_data_widget.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/providers/rates.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    return _View(this);
  }

  void addToDashboard() {}
}

class _View extends WidgetView<DashboardView, _DashboardViewState> {
  final _DashboardViewState state;

  _View(this.state);

  @override
  Widget build(BuildContext context) {
    List<CurrencyModel> subscriptions =
        context.select<RatesProvider, List<CurrencyModel>>(
            (value) => value.subscriptions);
    return subscriptions.isEmpty
        ? NoDataWidget(
            width: state.illustrationWidth,
            onTap: state.addToDashboard,
          )
        : ListView.builder(
            itemCount: subscriptions.length,
            itemBuilder: (context, index) {
              final currency = subscriptions[index];

              return Builder(
                builder: (context) {
                  CurrencyModel defaultCurrency =
                      context.select<AppProvider, CurrencyModel>((value) {
                    return value.defaultCurrency;
                  });

                  return DashboardListItem(
                    key: ObjectKey(currency),
                    defaultCurrency: defaultCurrency,
                    currencyModel: currency,
                    onTap: null,
                    onMoreOptionTap: null,
                  );
                },
              );
            },
          );
  }
}
