import 'package:currex/pages/index/index_page.dart';
import 'package:currex/providers/app.dart';
import 'package:currex/utils/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  static final GlobalKey<ScaffoldState> globalScaffoldKey =
      GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: IndexPage.IndexPageRouteName,
      onGenerateRoute: onGenerateInitialRoute,
      theme: AppThemeData.lightTheme,
      darkTheme: AppThemeData.darkTheme,
      themeMode: ThemeMode.system,
      builder: (context, child) {
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        );

        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) {
                return AppProvider()..initialise(context);
              },
              lazy: false,
            )
          ],
          child: Scaffold(
            key: globalScaffoldKey,
            body: child,
          ),
        );
      },
    );
  }

  Route onGenerateInitialRoute(RouteSettings settings) {
    Widget builder = Container();
    bool fullscreenDialog = false;

    switch (settings.name) {
      case IndexPage.IndexPageRouteName:
        builder = IndexPage();
        break;
    }

    return MaterialPageRoute(
      builder: (_) => builder,
      settings: settings,
      fullscreenDialog: fullscreenDialog,
    );
  }
}
