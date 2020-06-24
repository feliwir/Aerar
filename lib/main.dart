import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'view_models/stock_list_view_model.dart';

void main() {
  runApp(Aerar());
}

class Aerar extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Aerar",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.red,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: ChangeNotifierProvider(
            create: (_) => StockListViewModel(), child: HomePage()));
  }
}
