import 'package:Aerar/view_models/stock_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StockInfo extends StatefulWidget {
  final StockViewModel _stock;
  StockInfo(this._stock);

  @override
  State<StockInfo> createState() => new _StockInfoState(_stock);
}

class _StockInfoState extends State<StockInfo> {
  StockViewModel _stock;
  bool _fetching = true;

  _StockInfoState(this._stock) {
    _stock.fetchStockInfo().then((value) => setState(() {
          _fetching = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return CircularProgressIndicator();
    } else {
      var change = NumberFormat.simpleCurrency(name: _stock.currency)
          .format(_stock.price);
      var changeColor =
          (double.parse(_stock.change) > 0.0) ? Colors.green : Colors.red;
      return Column(children: <Widget>[
        Text(change,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
        Container(
            width: 75,
            height: 24,
            child: Text("${_stock.change}%",
                style: TextStyle(color: Colors.white)),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: changeColor,
            ))
      ]);
    }
  }
}
