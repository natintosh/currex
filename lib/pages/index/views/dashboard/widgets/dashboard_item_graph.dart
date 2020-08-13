import 'dart:math' as Math;

import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/models/rate_fluctuation/rate_fluctuation_model.dart';
import 'package:currex/services/exchange_rate.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sized_context/sized_context.dart';
import 'package:tuple/tuple.dart';

class DashboardItemGraph extends StatefulWidget {
  final CurrencyModel defaultCurrency;
  final CurrencyModel currencyModel;
  final RateFluctuationModel rateModel;
  final String currencyCode;

  const DashboardItemGraph(
      {Key key,
      @required this.defaultCurrency,
      @required this.currencyModel,
      @required this.rateModel,
      @required this.currencyCode})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _DashboardItemGraphState();
}

class _DashboardItemGraphState extends State<DashboardItemGraph> {
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

  List<num> timeSeriesData = List.filled(7, 0.0);

  @override
  void initState() {
    loadTimeSeries();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void loadTimeSeries() async {
    String startDate = dateFormat.format(days[days.length - days.length]);
    String endDate = dateFormat.format(days[days.length - 1]);

    Tuple2<bool, List<num>> data = await ExchanegRateService.getTimeSeries(
      base: widget.defaultCurrency.code,
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
          showTitles: false,
          reservedSize: 0,
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
      maxY: maxY(timeSeriesData.reduce(Math.max)),
      minY: minY(timeSeriesData.reduce(Math.min)),
      lineBarsData: linesBarData1(),
    );
  }

  double maxY(double max) {
    if (max == 0) return 0.0;

    double value = 1 / max;

    return value;
  }

  double minY(double min) {
    if (min == 0) return 0.0;

    double value = 1 / min;

    return value;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: LineChart(lineChartData),
    );
  }
}
