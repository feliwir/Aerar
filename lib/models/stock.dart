class Stock {
  final String symbol;
  final String company;
  double price = 0.0;
  String change = "N/A";

  Stock({this.symbol, this.company, this.price, this.change});

  factory Stock.fromJson(Map<String, dynamic> json) {
    return Stock(company: json["company"], symbol: json["symbol"]);
  }

  void update(double price, String change) {
    this.price = price;
    this.change = change;
  }
}