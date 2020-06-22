import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import 'models/stock.dart';

class Webservice {
  Future<List<Stock>> getStocks() async {
    String jsonString = await rootBundle.loadString("assets/markets/dax.json");
    final json = jsonDecode(jsonString);
    var stockList = json["stocks"] as List;
    return stockList.map((stock) => Stock.fromJson(stock)).toList();
  }
}
