import 'package:flutter/material.dart';
import '../webservice.dart';
import 'stock_view_model.dart';

class StockListViewModel extends ChangeNotifier {
  List<StockViewModel> _stocks = List<StockViewModel>();
  List<StockViewModel> allStocks = List<StockViewModel>();
  bool _onlyFavorites = false;

  Future<void> fetchStocks() async {
    final result = await Webservice().getStocks();
    _stocks = result.map((stock) => StockViewModel(stock: stock)).toList();
    allStocks = _stocks;
    notifyListeners();
  }

  get stocks {
    return _stocks
        .where((stock) => !_onlyFavorites || (_onlyFavorites && stock.favorite))
        .toList();
  }

  set onlyFavorites(bool onlyFavorites) {
    _onlyFavorites = onlyFavorites;
    notifyListeners();
  }

  void search(String searchTerm) {
    if (searchTerm.isEmpty) {
      _stocks = allStocks;
    } else {
      _stocks = allStocks
          .where((stock) =>
              stock.company.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }

    notifyListeners();
  }
}
