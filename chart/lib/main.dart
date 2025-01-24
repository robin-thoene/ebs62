import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

/// Represents a single category to be displayed in the chart.
///
/// The [label] is used as label on the X-Axis, the [value] is
/// the actual value displayed on the Y-Axis.
class Category {
  Category(this.label, this.value);
  String label;
  int value;
}

/// Helper to create random int values
final _random = Random();
int _randomValue(int min, int max) => min + _random.nextInt(max - min);

void main() {
  runApp(const MyApp());
}

class CategoriesBarChart extends StatelessWidget {
  final List<charts.Series> seriesList = _createChartData();

  CategoriesBarChart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.BarChart(
      seriesList,
      animate: false,
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.blue
                .shadeDefault, // Set grid lines color to blue
            thickness: 1, // Optional: Adjust thickness of grid lines
          ),
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.blue
                .shadeDefault, // Set grid lines color to blue
            thickness: 1, // Optional: Adjust thickness of grid lines
          ),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<Category, String>> _createChartData() {
    final data = [
      Category("A", _randomValue(0, 100)),
      Category("B", _randomValue(0, 100)),
      Category("C", _randomValue(0, 100)),
      Category("D", _randomValue(0, 100)),
      Category("E", _randomValue(0, 100)),
      Category("F", _randomValue(0, 100)),
      Category("G", _randomValue(0, 100)),
      Category("H", _randomValue(0, 100)),
    ];

    return [
      charts.Series<Category, String>(
        id: 'Categories',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (Category category, _) => category.label,
        measureFn: (Category category, _) => category.value,
        data: data,
      )
    ];
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Säulendiagramm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Säulendiagramm'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Gesamtverkäufe',
              style: TextStyle(fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Material(
                  elevation: 8.0,
                  child: SizedBox(height: 250, child: CategoriesBarChart())),
            ),
          ],
        ),
      ),
    );
  }
}
