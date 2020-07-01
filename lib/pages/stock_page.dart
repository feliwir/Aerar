import 'package:Aerar/view_models/stock_view_model.dart';
import 'package:Aerar/widgets/stock_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StockPageArguments {
  final StockViewModel stock;
  StockPageArguments(this.stock);
}

class StockPage extends StatefulWidget {
  static const String routeName = "/stock";

  @override
  _StockPageState createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  StockViewModel _stock;
  bool _fetching = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final StockPageArguments args = ModalRoute.of(context).settings.arguments;
    _stock = args.stock;
    _fetching = true;
    _stock.fetchStockHistory().then((value) => setState(() {
          _fetching = false;
        }));
  }

  Widget _buildContent(BuildContext context) {
    if (_fetching)
      return CircularProgressIndicator();
    else {
      List<StockSample> data =
          List<StockSample>.generate(_stock.timestamps.length, (index) {
        return StockSample(
            _stock.timestamps[index], _stock.pricesClosed[index] as double);
      });

      List<charts.Series<StockSample, DateTime>> series =
          <charts.Series<StockSample, DateTime>>[
        charts.Series<StockSample, DateTime>(
          id: _stock.symbol,
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (StockSample samples, _) => samples.time,
          measureFn: (StockSample samples, _) => samples.close,
          data: data,
        )
      ];

      return Container(
          padding: EdgeInsets.all(10),
          child: StockChart(series, _stock.currency));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_stock.company),
        ),
        body: _buildContent(context));
  }
}
