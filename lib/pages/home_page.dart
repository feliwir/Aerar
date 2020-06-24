import 'package:Aerar/view_models/stock_list_view_model.dart';
import 'package:Aerar/widgets/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StockListViewModel _vm;

  @override
  void initState() {
    super.initState();
    _vm = Provider.of<StockListViewModel>(context, listen: false);
    _vm.fetchStocks();
  }

  void _filterStocks(String searchTerm) {
    _vm.search(searchTerm);
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<StockListViewModel>(context);
    final locale = Localizations.localeOf(context);
    final formatter = new DateFormat.yMMMMd(locale.toLanguageTag());
    final today = formatter.format(DateTime.now());

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Stocks",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
                  Text(today,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: _filterStocks,
                          decoration: InputDecoration(
                              hintText: "Search",
                              prefix: Icon(Icons.search),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)))),
                        )),
                  ),
                  Expanded(
                      //height: MediaQuery.of(context).size.height - 200,
                      child: StockList(stocks: vm.stocks))
                ]),
          ))
    ]));
  }
}
