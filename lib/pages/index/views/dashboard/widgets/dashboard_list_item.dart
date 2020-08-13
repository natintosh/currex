import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/pages/index/views/dashboard/widgets/dashboard_item_graph.dart';
import 'package:currex/pages/index/views/dashboard/widgets/item_placeholder.dart';
import 'package:currex/providers/rates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';

class DashboardListItem extends StatelessWidget {
  final CurrencyModel defaultCurrency;
  final CurrencyModel currencyModel;
  final VoidCallback onTap;
  final VoidCallback onMoreOptionTap;

  DashboardListItem({
    Key key,
    @required this.defaultCurrency,
    @required this.currencyModel,
    @required this.onTap,
    @required this.onMoreOptionTap,
  }) : super(key: key);

  NumberFormat get numberCurrency => NumberFormat.currency(
      name: defaultCurrency.code, symbol: defaultCurrency.symbolNative);

  final dateFormat = DateFormat('y-MM-dd');

  final startDate = DateTime.now().subtract(Duration(hours: 24 * 0));
  final endDate = DateTime.now().subtract(Duration(hours: 24 * 1));

  String get currencyCode => currencyModel.code;

  String get currencyName => currencyModel.namePlural;

  String get isoCode => currencyCode.substring(0, currencyCode.length - 1);

  String value(double value) {
    return numberCurrency.format(1 / value);
  }

  String changes(num changes) {
    return '${changes < 0 ? '\u2193' : '\u2191'} ' +
        changes.toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      margin: EdgeInsets.only(top: 8.0, bottom: 4.0, left: 8.0, right: 8.0),
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              clipBehavior: Clip.antiAlias,
              width: 52.0,
              height: 52.0,
              decoration: ShapeDecoration(
                color: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
              ),
              child: Image.asset(
                'assets/flags/${isoCode.toLowerCase()}.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        currencyCode,
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            .copyWith(fontWeight: FontWeight.w300),
                      ),
                      Text(
                        currencyName,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            .copyWith(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  SizedBox(
                    height: context.widthPct(0.025),
                  ),
                  Builder(
                    builder: (context) {
                      RateFluctuationModel rateModel =
                          context.select<RatesProvider, RateFluctuationModel>(
                        (value) {
                          if (value.rateFluctuation == null) return null;

                          if (!value.rateFluctuation.item1) return null;

                          var item = value.rateFluctuation.item2.firstWhere(
                              (element) => element.containsKey(currencyCode));

                          return item.values.first;
                        },
                      );

                      if (rateModel == null) return ItemPlaceHolder();

                      return Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${value(rateModel.endRate)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '${changes(rateModel.change)}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(
                                              color:
                                                  rateModel.changePercentage < 0
                                                      ? CupertinoColors
                                                          .destructiveRed
                                                      : CupertinoColors
                                                          .activeGreen),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: context.widthPct(0.025),
                            ),
                            DashboardItemGraph(
                              currencyCode: currencyCode,
                              currencyModel: currencyModel,
                              rateModel: rateModel,
                              defaultCurrency: defaultCurrency,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
