import 'package:Aerar/view_models/stock_view_model.dart';
import 'package:flutter/material.dart';

import 'stock_info.dart';

class StockList extends StatelessWidget {
  final List<StockViewModel> stocks;

  StockList({this.stocks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider(color: Colors.grey[400]);
      },
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        final stock = stocks[index];

        return ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text(stock.company, style: TextStyle(fontSize: 24)),
            subtitle: Text(stock.symbol),
            trailing: StockInfo(stock));
      },
    );
  }
}
