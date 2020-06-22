import 'package:Aerar/models/stock.dart';
import 'package:finance_quote/finance_quote.dart';

class StockViewModel {
  final Stock stock;

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

  Future<void> fetchStock() async {
   final quotePrice =
      await FinanceQuote.getPrice(
          quoteProvider: QuoteProvider.yahoo, symbols: <String>[stock.symbol]);

    final price = double.parse(quotePrice[stock.symbol]['price']);
    final currency = quotePrice[stock.symbol]['currency'];
    stock.update(price, currency);
  }
}
