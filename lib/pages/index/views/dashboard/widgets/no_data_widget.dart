import 'package:flutter/material.dart';
import 'package:sized_context/sized_context.dart';
import 'package:websafe_svg/websafe_svg.dart';

class NoDataWidget extends StatelessWidget {
  final double width;
  final VoidCallback onTap;

  const NoDataWidget({
    Key key,
    @required this.width,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displacement = context.widthPct(0.05);
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            WebsafeSvg.asset(
              'assets/illustrations/ill_no_data.svg',
              width: width,
            ),
            SizedBox(height: displacement),
            Text(
              'You currently have no exchange tracked',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: displacement),
            FlatButton(
              onPressed: onTap,
              child: Text('Add Exchange'),
            )
          ],
        ),
      ),
    );
  }
}
