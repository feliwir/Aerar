import 'package:Aerar/models/stock.dart';
import 'package:fin_quote/fin_quote.dart';

class StockViewModel {
  final Stock stock;
  bool _favorite = false;

  StockViewModel({this.stock});

  String get symbol {
    return stock.symbol.toUpperCase();
  }

  String get company {
    return stock.company;
  }

  double get price {
    return stock.price;
  }

  String get change {
    return stock.change;
  }

  String get currency {
    return stock.currency;
  }

  bool get favorite {
    return _favorite;
  }

  void toggleFavorite() {
    _favorite = !_favorite;
  }

  Future<void> fetchStock() async {
    final quotePrice = await FinanceQuote.getPrice(
        quoteProvider: QuoteProvider.yahoo, symbols: <String>[stock.symbol]);

    if (quotePrice.isEmpty) return;

    final price = double.parse(quotePrice[stock.symbol]['price']);
    final change = quotePrice[stock.symbol]['change'];
    final currency = quotePrice[stock.symbol]['currency'];
    stock.update(price, change, currency);
  }
}
