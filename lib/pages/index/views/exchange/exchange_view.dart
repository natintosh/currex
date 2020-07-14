import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/pages/index/views/exchange/views/currency_details_view.dart';
import 'package:currex/pages/index/views/exchange/widgets/exchange_list_item.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class ExchangeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ExchangeViewState();
}

class _ExchangeViewState extends State<ExchangeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Currex'),
      ),
      body: _View(this),
    );
  }

  void onTap({
    RateFluctuationModel rateModel,
    String currencyCode,
    bool isTracked,
  }) {
    showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      builder: (context) {
        return CurrencyDetailsView(
            rateModel: rateModel,
            currencyCode: currencyCode,
            isTracked: isTracked);
      },
    );
  }
}

class _View extends WidgetView<ExchangeView, _ExchangeViewState> {
  final _ExchangeViewState state;

  _View(this.state);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Tuple2<bool, List<Map<String, RateFluctuationModel>>>>(
        future: ExchanegRateService.getFluctuation(
            startDate: '2020-07-06', endDate: '2020-07-05', base: 'NGN'),
        builder: (_,
            AsyncSnapshot<Tuple2<bool, List<Map<String, RateFluctuationModel>>>>
                snapshot) {
          if (!snapshot.hasData) return Container();
          if (!snapshot.data.item1) return Container();

          return ListView.builder(
            itemCount: snapshot.data.item2.length,
            itemBuilder: (context, index) {
              return Builder(
                builder: (context) {
                  Map<String, RateFluctuationModel> data =
                      snapshot.data.item2[index];

                  String currencyCode = data.keys.toList()[0];
                  String isoCode =
                      currencyCode.substring(0, currencyCode.length - 1);
                  RateFluctuationModel values = data.values.toList()[0];

                  CurrencyModel currency =
                      context.select<AppProvider, CurrencyModel>(
                    (value) {
                      return value.currencies[currencyCode];
                    },
                  );

                  return ExchangeListItem(
                    isoCode: isoCode,
                    currencyCode: currencyCode,
                    currencyName: currency?.namePlural ?? '',
                    currencySymbol: currency?.symbol ?? '',
                    value: values.endRate,
                    change: values.change,
                    changePercentage: values.changePercentage,
                    isTracked: false,
                    onTap: () => state.onTap(
                      rateModel: values,
                      currencyCode: currencyCode,
                      isTracked: false, // TODO:
                    ),
                  );
                },
              );
            },
          );
        });
  }
}
