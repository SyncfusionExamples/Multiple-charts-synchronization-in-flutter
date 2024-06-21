// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(const SynchronizedSelection());

class SynchronizedSelection extends StatelessWidget {
  const SynchronizedSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Selection',
      home: Scaffold(
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

SelectionBehavior _baseSelection =
    SelectionBehavior(enable: true, toggleSelection: false);
SelectionBehavior _targetSelection =
    SelectionBehavior(enable: true, toggleSelection: false);
int _selectedIndex = -1;
List<SalesData> _data = <SalesData>[
  SalesData('Jan', 21),
  SalesData('Feb', 24),
  SalesData('Mar', 35),
  SalesData('Apr', 38),
  SalesData('May', 54),
  SalesData('Jun', 21),
];

class FirstChart extends StatelessWidget {
  FirstChart({super.key});

  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      onSelectionChanged: (selectionArgs) {
        if (_isInteractive && _selectedIndex != selectionArgs.pointIndex) {
          _selectedIndex = selectionArgs.pointIndex;
          _targetSelection.selectDataPoints(_selectedIndex);
          _isInteractive = false;
        }
      },
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 1'),
      series: <ColumnSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
          dataSource: _data,
          xValueMapper: (SalesData sales, int index) => sales.year,
          yValueMapper: (SalesData sales, int index) => sales.sales,
          selectionBehavior: _baseSelection,
          color: const Color.fromRGBO(99, 85, 199, 1),
        ),
      ],
    );
  }
}

class SecondChart extends StatelessWidget {
  SecondChart({super.key});

  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      onSelectionChanged: (selectionArgs) {
        if (_isInteractive && _selectedIndex != selectionArgs.pointIndex) {
          _selectedIndex = selectionArgs.pointIndex;
          _baseSelection.selectDataPoints(_selectedIndex);
          _isInteractive = false;
        }
      },
      primaryXAxis: const CategoryAxis(),
      title: const ChartTitle(text: 'Chart 2'),
      series: <ColumnSeries<SalesData, String>>[
        ColumnSeries<SalesData, String>(
          dataSource: _data,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          selectionBehavior: _targetSelection,
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
