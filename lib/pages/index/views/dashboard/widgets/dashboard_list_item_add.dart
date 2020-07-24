import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';

class DashboardListItemAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.add_circle_outline,
              color: Theme.of(context).primaryColor,
              size: Theme.of(context).textTheme.headline2.fontSize,
            ),
            SizedBox(
              height: context.heightPct(0.01),
            ),
            Text('Track a new currency'),
          ],
        ),
      ),
    );
  }
}
