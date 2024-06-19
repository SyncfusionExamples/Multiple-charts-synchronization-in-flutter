import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(const SynchronizedSelection());

class SynchronizedSelection extends StatelessWidget {
  const SynchronizedSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Selection',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: <Widget>[
            Expanded(child: FirstChart()),
            Expanded(child: SecondChart()),
          ],
        ),
      ),
    );
  }
}

SelectionBehavior selectionBehavior1 =
    SelectionBehavior(enable: true, toggleSelection: false);
SelectionBehavior selectionBehavior2 =
    SelectionBehavior(enable: true, toggleSelection: false);
int selectedIndex = -1;
List<SalesData> data = <SalesData>[
  SalesData('Jan', 21),
  SalesData('Feb', 24),
  SalesData('Mar', 35),
  SalesData('Apr', 38),
  SalesData('May', 54),
  SalesData('Jun', 21),
];

class FirstChart extends StatefulWidget {
  const FirstChart({super.key});

  @override
  State<StatefulWidget> createState() {
    return FirstChartState();
  }
}

class FirstChartState extends State<FirstChart> {
  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      onSelectionChanged: (selectionArgs) {
        if (_isInteractive && selectedIndex != selectionArgs.pointIndex) {
          selectedIndex = selectionArgs.pointIndex;
          selectionBehavior2.selectDataPoints(selectedIndex);
          _isInteractive = false;
        }
      },
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 1'),
      series: <ColumnSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
          dataSource: data,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          selectionBehavior: selectionBehavior1,
          color: const Color.fromRGBO(99, 85, 199, 1),
        ),
      ],
    );
  }
}

class SecondChart extends StatefulWidget {
  const SecondChart({super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondChartState();
  }
}

class SecondChartState extends State<SecondChart> {
  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      onSelectionChanged: (selectionArgs) {
        if (_isInteractive && selectedIndex != selectionArgs.pointIndex) {
          selectedIndex = selectionArgs.pointIndex;
          selectionBehavior1.selectDataPoints(selectedIndex);
          _isInteractive = false;
        }
      },
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 2'),
      series: <ColumnSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
          dataSource: data,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          selectionBehavior: selectionBehavior2,
          color: const Color.fromRGBO(99, 85, 199, 1),
        ),
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
