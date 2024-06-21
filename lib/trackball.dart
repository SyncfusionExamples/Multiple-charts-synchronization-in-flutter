// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_synchronization/model.dart';

void main() => runApp(const SynchronizedTrackball());

class SynchronizedTrackball extends StatelessWidget {
  const SynchronizedTrackball({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Trackball',
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

TrackballBehavior _baseTrackball =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
TrackballBehavior _targetTrackball =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
ChartSeriesController? _baseSeriesController;
ChartSeriesController? _targetSeriesController;
DataModel _dataModel = DataModel();
Offset? _position;

class FirstChart extends StatelessWidget {
  FirstChart({super.key});

  bool _isInteractive = false;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onChartTouchInteractionDown: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = true;
      },
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        _targetTrackball.hide();
      },
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _position = _baseSeriesController!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          _targetTrackball.show(_position!.dx, _position!.dy, 'pixel');
        }
      },
      primaryXAxis: DateTimeAxis(
        minimum: DateTime(2023, 02, 18),
        maximum: DateTime(2023, 08, 18),
        dateFormat: DateFormat.MMMd(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
      ),
      title: const ChartTitle(text: 'Chart 1'),
      trackballBehavior: _baseTrackball,
      series: <LineSeries<SalesData, DateTime>>[
        LineSeries<SalesData, DateTime>(
          color: const Color.fromRGBO(99, 85, 199, 1),
          dataSource: _dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          onRendererCreated: (ChartSeriesController controller) {
            _targetSeriesController = controller;
          },
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
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        _baseTrackball.hide();
      },
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _position = _targetSeriesController!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          _baseTrackball.show(_position!.dx, _position!.dy, 'pixel');
        }
      },
      primaryXAxis: DateTimeAxis(
        minimum: DateTime(2023, 02, 18),
        maximum: DateTime(2023, 08, 18),
        dateFormat: DateFormat.MMMd(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
      ),
      title: const ChartTitle(text: 'Chart 2'),
      trackballBehavior: _targetTrackball,
      series: <LineSeries<SalesData, DateTime>>[
        LineSeries<SalesData, DateTime>(
          color: const Color.fromRGBO(99, 85, 199, 1),
          dataSource: _dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          onRendererCreated: (ChartSeriesController controller) {
            _baseSeriesController = controller;
          },
        ),
      ],
    );
  }
}
