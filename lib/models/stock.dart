class Stock {
  final String symbol;
  final String company;
  double price = 0.0;
  String change = "N/A";
  String currency = "";

  Stock({this.symbol, this.company, this.price, this.change});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(company: json["company"], symbol: json["symbol"]);
  }

  void update(double price, String change, String currency) {
    this.price = price;
    this.change = change;
    this.currency = currency;
  }
}
