import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/pages/index/views/dashboard/widgets/dashboard_item_graph.dart';
import 'package:currex/pages/index/views/dashboard/widgets/item_placeholder_graph.dart';
import 'package:currex/providers/app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sized_context/sized_context.dart';

class ItemPlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CurrencyModel currencyModel = context.select<AppProvider, CurrencyModel>(
      (value) => value.defaultCurrency,
    );
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
                    '${currencyModel.symbolNative}---.--',
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    '  -.--',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: context.widthPct(0.025),
          ),
          ItemPlaceHolderGraph(),
        ],
      ),
    );
  }
}
