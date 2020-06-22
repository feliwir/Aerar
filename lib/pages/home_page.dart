import 'package:Aerar/view_models/stock_list_view_model.dart';
import 'package:Aerar/widgets/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Stocks",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold)),
                  Text("January 5",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: _filterStocks,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              hintText: "Search",
                              prefix: Icon(Icons.search),
                              fillColor: Colors.grey[800],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0, style: BorderStyle.none),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16)))),
                        )),
                  ),
                  SizedBox(
                      height: MediaQuery.of(context).size.height - 200,
                      child: StockList(stocks: vm.stocks))
                ]),
          ))
    ]));
  }
}
