import 'package:animations/animations.dart';
import 'package:currex/pages/index/views/dashboard/dashboard_view.dart';
import 'package:currex/pages/index/views/exchange/exchange_view.dart';
import 'package:currex/utils/widget_view/widget_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  static const IndexPageRouteName = '/';

  static final GlobalKey<ScaffoldState> indexScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavBarTitles = [
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      title: Text('Dashboard'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.swap_horiz),
      title: Text('Exchange'),
    ),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return _IndexView(this);
  }

  void onBottomNavBarTap(int value) {
    setState(() {
      currentIndex = value;
    });
  }
}

class _IndexView extends WidgetView<IndexPage, _IndexPageState> {
  final _IndexPageState state;

  _IndexView(this.state) : super(state: state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: IndexPage.indexScaffoldKey,
      resizeToAvoidBottomPadding: false,
      extendBody: true,
      // appBar: AppBar(
      //   title: Text('Currexp'),
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CupertinoColors.systemGrey4.withOpacity(0.9),
        elevation: 0.0,
        currentIndex: state.currentIndex,
        items: state.bottomNavBarTitles,
        onTap: state.onBottomNavBarTap,
      ),
      body: _IndexCurrentView(state),
    );
  }
}

class _IndexCurrentView extends WidgetView<IndexPage, _IndexPageState> {
  _IndexCurrentView(this.state);

  final _IndexPageState state;

  final List<Widget> views = [
    DashboardView(),
    ExchangeView(),
  ];

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
        transitionBuilder: (Widget child, Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation) {
          return FadeThroughTransition(
            fillColor: Colors.transparent,
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: views[state.currentIndex]);
  }
}
