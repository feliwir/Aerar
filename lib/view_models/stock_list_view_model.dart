import 'package:flutter/material.dart';
import '../webservice.dart';
import 'stock_view_model.dart';

class StockListViewModel extends ChangeNotifier {
  List<StockViewModel> stocks = List<StockViewModel>();
  List<StockViewModel> allStocks = List<StockViewModel>();

  Future<void> fetchStocks() async {
    final result = await Webservice().getStocks();
    stocks = result.map((stock) => StockViewModel(stock: stock)).toList();
    allStocks = stocks;
    notifyListeners();
  }

  void search(String searchTerm) {
    if (searchTerm.isEmpty) {
      stocks = allStocks;
    } else {
      stocks = allStocks
          .where((stock) =>
              stock.company.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}
