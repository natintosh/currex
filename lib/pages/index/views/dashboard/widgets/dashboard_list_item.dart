import 'package:currex/pages/index/views/dashboard/widgets/dashboard_item_graph.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class DashboardListItem extends StatelessWidget {
  final String isoCode;
  final String countryShortName;
  final String currencyName;
  final String currencySymbol;
  final double buyValue;
  final double sellValue;
  final double changes;
  final List<double> previousValues;
  final VoidCallback onTap;
  final VoidCallback onMoreOptionTap;

  DashboardListItem({
    Key key,
    @required this.isoCode,
    @required this.countryShortName,
    @required this.currencyName,
    @required this.currencySymbol,
    @required this.buyValue,
    @required this.sellValue,
    @required this.previousValues,
    @required this.changes,
    @required this.onTap,
    @required this.onMoreOptionTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
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
                'packages/country_icons/icons/flags/png/${isoCode.toLowerCase()}.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            countryShortName,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                          Text(
                            currencyName,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.widthPct(0.025),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Value'),
                          Text('$currencySymbol$buyValue'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Changes'),
                          Text(
                            '$changes',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(
                                    color: changes < 0
                                        ? CupertinoColors.destructiveRed
                                        : CupertinoColors.activeGreen),
                          )
                        ],
                      ),
                      Container(),
                    ],
                  ),
                  SizedBox(
                    height: context.widthPct(0.025),
                  ),
                  DashboardItemGraph(),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: onMoreOptionTap,
            ),
          ],
        ),
      ),
    );
  }
}
