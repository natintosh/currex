import 'dart:math' as Math;

import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/providers/rates.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';
import 'package:tuple/tuple.dart';

class CurrencyDetailsView extends StatefulWidget {
  final CurrencyModel currencyModel;
  final RateFluctuationModel rateModel;
  final String currencyCode;
  final ValueChanged<CurrencyModel> onSubscribe;
  final ValueChanged<CurrencyModel> onUnsubscribe;

  const CurrencyDetailsView({
    Key key,
    @required this.currencyModel,
    @required this.rateModel,
    @required this.currencyCode,
    @required this.onSubscribe,
    @required this.onUnsubscribe,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CurrencyDetailsView();
}

class _CurrencyDetailsView extends State<CurrencyDetailsView> {
  final numberCurrency = NumberFormat.currency(name: 'NGN', symbol: '\u20A6');
  final dateFormat = DateFormat('y-MM-dd');

  static final today = DateTime.now();

  List<DateTime> days = [
    today.subtract(Duration(hours: 24 * 6)),
    today.subtract(Duration(hours: 24 * 5)),
    today.subtract(Duration(hours: 24 * 4)),
    today.subtract(Duration(hours: 24 * 3)),
    today.subtract(Duration(hours: 24 * 2)),
    today.subtract(Duration(hours: 24 * 1)),
    today.subtract(Duration(hours: 24 * 0)),
  ];

  List<num> timeSeriesData = List.filled(7, 5.0);

  @override
  void initState() {
    loadTimeSeries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _View(this);
  }

  void onCancelButtonPressed() {
    Navigator.pop(context);
  }

  void loadTimeSeries() async {
    String startDate = dateFormat.format(days[days.length - days.length]);
    String endDate = dateFormat.format(days[days.length - 1]);

    Tuple2<bool, List<num>> data = await ExchanegRateService.getTimeSeries(
      base: 'NGN',
      startDate: startDate,
      endDate: endDate,
      symbols: [widget.currencyCode],
    );

    if (data.item1) {
      setState(() {
        timeSeriesData = data.item2;
      });
    }
  }

  bool get isNegative => widget.rateModel.change < 0;

  String get value {
    return numberCurrency.format((1 / widget.rateModel.endRate));
  }

  String get start {
    return numberCurrency.format((1 / widget.rateModel.startRate));
  }

  String get change {
    return '${widget.rateModel.change < 0 ? '\u2193' : '\u2191'} ' +
        widget.rateModel.change.toStringAsPrecision(2);
  }

  String get changePercentage {
    return '(${widget.rateModel.changePercentage.toStringAsPrecision(2)}%)';
  }

  LineChartData get lineChartData {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
        ),
        touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: Theme.of(context).textTheme.caption,
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return DateFormat('EE').format(days[0]);
                break;
              case 2:
                return DateFormat('EE').format(days[1]);
                break;
              case 3:
                return DateFormat('EE').format(days[2]);
                break;
              case 4:
                return DateFormat('EE').format(days[3]);
                break;
              case 5:
                return DateFormat('EE').format(days[4]);
                break;
              case 6:
                return DateFormat('EE').format(days[5]);
                break;
              case 7:
                return DateFormat('EE').format(days[6]);
                break;
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: const TextStyle(
            color: Color(0xff75729e),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            return '';
          },
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          left: BorderSide(
            color: Color(0xff4e4965),
            width: 2,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 0,
      maxX: 8,
      maxY: 1 / timeSeriesData.reduce(Math.max),
      minY: 1 / timeSeriesData.reduce(Math.min),
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        ...timeSeriesData
            .asMap()
            .map((key, value) => MapEntry(
                key,
                FlSpot(
                  key + 1.0,
                  1 / value,
                )))
            .values
            .toList()
      ],
      colors: [
        isNegative
            ? CupertinoColors.destructiveRed
            : CupertinoColors.activeGreen
      ],
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(show: true, colors: [
        isNegative
            ? CupertinoColors.destructiveRed.withOpacity(0.2)
            : CupertinoColors.activeGreen.withOpacity(0.2)
      ]),
    );

    return [
      lineChartBarData1,
    ];
  }
}

class _View extends WidgetView<CurrencyDetailsView, _CurrencyDetailsView> {
  final _CurrencyDetailsView state;

  _View(this.state) : super(state: state);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Icon(Icons.remove)],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.show_chart),
                onPressed: null,
              ),
              Container(
                child: Text(
                  '${widget.currencyCode}',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                color: CupertinoColors.systemGrey.withBlue(187),
                onPressed: state.onCancelButtonPressed,
              ),
            ],
          ),
          SizedBox(
            height: context.heightPct(0.01),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(state.value, style: Theme.of(context).textTheme.headline6),
              Text(
                '${state.change} ${state.changePercentage}',
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: state.isNegative
                          ? CupertinoColors.destructiveRed
                          : CupertinoColors.activeGreen,
                    ),
              ),
            ],
          ),
          SizedBox(
            height: context.heightPct(0.08),
          ),
          LineChart(state.lineChartData),
          SizedBox(
            height: context.heightPct(0.04),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Start',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    state.start,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'End',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    state.value,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.heightPct(0.04),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: context.select<RatesProvider, bool>((value) =>
                    value.subscriptions.contains(widget.currencyModel))
                ? FlatButton.icon(
                    onPressed: () => widget.onUnsubscribe(widget.currencyModel),
                    icon: Icon(Icons.notifications_none),
                    label: Text('UNSUBSCRIBE'),
                  )
                : RaisedButton.icon(
                    onPressed: () => widget.onSubscribe(widget.currencyModel),
                    icon: Icon(Icons.notifications),
                    label: Text('SUBSCRIBE'),
                  ),
          ),
          SizedBox(
            height: context.heightPct(0.02),
          ),
        ],
      ),
    );
  }
}
