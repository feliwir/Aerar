import 'package:Aerar/pages/stock_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';

import 'pages/home_page.dart';
import 'pages/routes.dart';
import 'view_models/stock_list_view_model.dart';

void main() {
  runApp(Aerar());
}

class Aerar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        locale: Locale('de', ''),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        title: "Aerar",
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        routes: {
          Routes.homePage: (BuildContext context) => ChangeNotifierProvider(
              create: (_) => StockListViewModel(), child: HomePage()),
          Routes.stockPage: (BuildContext context) => StockPage()
        });
  }
}
