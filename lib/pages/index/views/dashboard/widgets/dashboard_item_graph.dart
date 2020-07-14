import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class DashboardItemGraph extends StatelessWidget {
  DashboardItemGraph({Key key, this.previousValues}) : super(key: key);

  final List<double> previousValues;

  final today = DateTime.now();
  final date1 = DateTime.now().subtract(Duration(days: 1));
  final date2 = DateTime.now().subtract(Duration(days: 2));
  final date3 = DateTime.now().subtract(Duration(days: 3));
  final date4 = DateTime.now().subtract(Duration(days: 4));
  final date5 = DateTime.now().subtract(Duration(days: 5));
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LayoutBuilder(
        builder: (_, BoxConstraints box) {
          return Container(
            width: box.maxWidth,
            height: context.widthPct(0.35),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: BezierChart(
              bezierChartScale: BezierChartScale.WEEKLY,
              fromDate: date5,
              toDate: today,
              selectedDate: today,
              config: BezierChartConfig(
                showDataPoints: false,
                snap: false,
                verticalIndicatorFixedPosition: false,
                footerHeight: 40.0,
                updatePositionOnTap: true,
                showVerticalIndicator: false,
                backgroundGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.blue.shade200,
                    Colors.blue,
                  ],
                ),
              ),
              series: <BezierLine>[
                BezierLine(
                  onMissingValue: (DateTime date) {
                    return 0;
                  },
                  label: "Rates",
                  data: [
                    DataPoint<DateTime>(value: 360, xAxis: today),
                    DataPoint<DateTime>(value: 430, xAxis: date1),
                    DataPoint<DateTime>(value: 400, xAxis: date2),
                    DataPoint<DateTime>(value: 356, xAxis: date3),
                    DataPoint<DateTime>(value: 370, xAxis: date4),
                    DataPoint<DateTime>(value: 375, xAxis: date5),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
