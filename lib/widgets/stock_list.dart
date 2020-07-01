import 'package:Aerar/pages/routes.dart';
import 'package:Aerar/pages/stock_page.dart';
import 'package:Aerar/view_models/stock_view_model.dart';
import 'package:flutter/material.dart';

import 'stock_info.dart';

class StockList extends StatefulWidget {
  final List<StockViewModel> stocks;

  StockList({this.stocks});

  @override
  State<StatefulWidget> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: widget.stocks.length,
      itemBuilder: (context, index) {
        final stock = widget.stocks[index];

        return ListTile(
          contentPadding: EdgeInsets.all(10),
          leading: IconButton(
            icon: stock.favorite ? Icon(Icons.star) : Icon(Icons.star_border),
            onPressed: () => setState(() => stock.toggleFavorite()),
          ),
          title: Text(stock.company, style: TextStyle(fontSize: 24)),
          subtitle: Text(stock.symbol),
          trailing: StockInfo(stock),
          onTap: () => Navigator.pushNamed(context, Routes.stockPage,
              arguments: StockPageArguments(stock)),
        );
      },
    );
  }
}
