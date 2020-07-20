import 'package:currex/models/currency/currency_model.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DefaultCurrency extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DefaultCurrencyState();
}

class _DefaultCurrencyState extends State<DefaultCurrency> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  List<CurrencyModel> get _currencies =>
      context.read<AppProvider>().currencies.values.toList();

  List<CurrencyModel> currencies = [];

  @override
  void initState() {
    currencies = filterList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Default currency'),
        ),
        body: _DefaultCurrencyView(this));
  }

  List<CurrencyModel> filterList() {
    final value = controller.text.trim().toLowerCase();

    if (value.isEmpty) _currencies;

    return _currencies
        .where((e) =>
            e.code.trim().toLowerCase().contains(value) ||
            e.namePlural.trim().toLowerCase().contains(value))
        .toList();
  }

  void searchFieldComplete() {
    FocusScope.of(context).unfocus();
  }

  void searchFieldChanged(String value) {
    setState(() {
      currencies = filterList();
    });
  }

  void updateDefaultCurrency(CurrencyModel currency) {
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    provider.defaultCurrency = currency;
  }
}

class _DefaultCurrencyView
    extends WidgetView<DefaultCurrency, _DefaultCurrencyState> {
  final _DefaultCurrencyState state;

  _DefaultCurrencyView(this.state) : super(state: state);

  @override
  Widget build(BuildContext context) {
    CurrencyModel defaultCurrency =
        context.watch<AppProvider>().defaultCurrency;
    return Container(
      child: Scrollbar(
        controller: state.scrollController,
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: state.scrollController,
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child:
                  Text('Search', style: Theme.of(context).textTheme.bodyText1),
            ),
            Container(
              color: Theme.of(context).cardColor,
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: TextField(
                controller: state.controller,
                focusNode: state.focusNode,
                onEditingComplete: state.searchFieldComplete,
                onChanged: state.searchFieldChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
              child: Text(
                'Selected',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Ink(
              color: Theme.of(context).cardColor,
              child: ListTile(
                title: Text(defaultCurrency.code),
                subtitle: Text(defaultCurrency.namePlural),
                trailing: Icon(Icons.check),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            ),
            ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Builder(
                  builder: (context) {
                    final currency = state.currencies[index];

                    return Ink(
                      color: Theme.of(context).cardColor,
                      child: Container(
                        child: ListTile(
                          onTap: () => state.updateDefaultCurrency(currency),
                          title: Text(currency.code),
                          subtitle: Text(currency.namePlural),
                          trailing: defaultCurrency.code == currency.code
                              ? Icon(Icons.check)
                              : null,
                        ),
                      ),
                    );
                  },
                );
              },
              itemCount: state.currencies.length,
            ),
          ],
        ),
      ),
    );
  }
}
