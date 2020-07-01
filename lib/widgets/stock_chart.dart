import 'package:flutter/widgets.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class StockChart extends StatelessWidget {
  final String currency;
  const StockChart(this.sampleList, this.currency);

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory StockChart.withSampleData() {
    return StockChart(_createSampleData(), "USD");
  }

  final List<charts.Series<StockSample, DateTime>> sampleList;

  @override
  Widget build(BuildContext context) {
    final simpleCurrencyFormatter =
        new charts.BasicNumericTickFormatterSpec.fromNumberFormat(
            new NumberFormat.simpleCurrency(name: currency));

    return charts.TimeSeriesChart(
      sampleList,
      animate: true,
      // Sets up a currency formatter for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickFormatterSpec: simpleCurrencyFormatter),
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      domainAxis: charts.DateTimeAxisSpec(
        renderSpec: charts.GridlineRendererSpec(),
        tickFormatterSpec: charts.AutoDateTimeTickFormatterSpec(
          day: charts.TimeFormatterSpec(
            format: 'EEE',
            transitionFormat: 'EEE',
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<StockSample, DateTime>> _createSampleData() {
    final List<StockSample> data = <StockSample>[
      StockSample(DateTime(2019, 1, 7), 5),
      StockSample(DateTime(2019, 1, 8), 25),
      StockSample(DateTime(2019, 1, 9), 100),
      StockSample(DateTime(2019, 1, 10), 75),
    ];

    return <charts.Series<StockSample, DateTime>>[
      charts.Series<StockSample, DateTime>(
        id: 'Samples',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (StockSample samples, _) => samples.time,
        measureFn: (StockSample samples, _) => samples.close,
        data: data,
      )
    ];
  }
}

class StockSample {
  StockSample(this.time, this.close);

  final DateTime time;
  final double close;
}
