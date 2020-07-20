import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExchangeListItem extends StatelessWidget {
  final String isoCode;
  final String currencyCode;
  final String currencyName;
  final String currencySymbol;
  final num value;
  final num change;
  final num changePercentage;
  final bool isTracked;
  final VoidCallback onTap;

  ExchangeListItem({
    Key key,
    @required this.isoCode,
    @required this.currencyCode,
    @required this.currencyName,
    @required this.currencySymbol,
    @required this.value,
    @required this.change,
    @required this.changePercentage,
    @required this.isTracked,
    @required this.onTap,
  }) : super(key: key);

  final numberCurrency = NumberFormat.currency(name: 'NGN', symbol: '\u20A6');

  String _getValue(num value) {
    return numberCurrency.format((1 / value));
  }

  String _getChanges(num changes) {
    return '${changes < 0 ? '\u2193' : '\u2191'} ' +
        changes.toStringAsPrecision(2);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Row(
            children: <Widget>[
              Container(
                clipBehavior: Clip.antiAlias,
                width: 48.0,
                height: 48.0,
                decoration: ShapeDecoration(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                ),
                child: Image.asset(
                  'assets/flags/${isoCode.toLowerCase()}.png',
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/flags/united_nation.png',
                      fit: BoxFit.cover,
                    );
                  },
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 18.0),
              Expanded(
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
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
                                  .caption
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              _getValue(value),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 6.0,
                            ),
                            Text(
                              '${_getChanges(change)}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                      color: change < 0
                                          ? CupertinoColors.destructiveRed
                                          : CupertinoColors.activeGreen,
                                      fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
