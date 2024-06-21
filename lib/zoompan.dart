// ignore_for_file: must_be_immutable

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model.dart';

void main() => runApp(const SynchronizedZoomPan());

class SynchronizedZoomPan extends StatelessWidget {
  const SynchronizedZoomPan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized ZoomPan',
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

DateTimeAxisController? _firstAxisController;
DateTimeAxisController? _secondAxisController;
DataModel _dataModel = DataModel();

class FirstChart extends StatelessWidget {
  FirstChart({super.key});

  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      zoomPanBehavior: _zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == 'primaryXAxis') {
          _secondAxisController!.zoomFactor = args.currentZoomFactor;
          _secondAxisController!.zoomPosition = args.currentZoomPosition;
        }
      },
      primaryXAxis: DateTimeAxis(
        minimum: DateTime(2023, 02, 18),
        maximum: DateTime(2023, 08, 18),
        dateFormat: DateFormat.MMMd(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),
        onRendererCreated: (DateTimeAxisController controller) {
          _firstAxisController = controller;
        },
        initialZoomFactor: 1,
        initialZoomPosition: 0,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
      ),
      title: const ChartTitle(text: 'Chart 1'),
      series: <SplineSeries<SalesData, DateTime>>[
        SplineSeries<SalesData, DateTime>(
          dataSource: _dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          color: const Color.fromRGBO(99, 85, 199, 1),
        )
      ],
    );
  }
}

class SecondChart extends StatelessWidget {
  SecondChart({super.key});

  final ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
      enablePanning: true,
      enablePinching: true,
      enableDoubleTapZooming: true,
      zoomMode: ZoomMode.x);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      zoomPanBehavior: _zoomPanBehavior,
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == 'primaryXAxis') {
          _firstAxisController!.zoomFactor = args.currentZoomFactor;
          _firstAxisController!.zoomPosition = args.currentZoomPosition;
        }
      },
      primaryXAxis: DateTimeAxis(
        minimum: DateTime(2023, 02, 18),
        maximum: DateTime(2023, 08, 18),
        dateFormat: DateFormat.MMMd(),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        majorGridLines: const MajorGridLines(width: 0),
        onRendererCreated: (DateTimeAxisController controller) {
          _secondAxisController = controller;
        },
        initialZoomFactor: 1,
        initialZoomPosition: 0,
      ),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
      ),
      title: const ChartTitle(text: 'Chart 2'),
      series: <SplineSeries<SalesData, DateTime>>[
        SplineSeries<SalesData, DateTime>(
          dataSource: _dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          color: const Color.fromRGBO(99, 85, 199, 1),
        )
      ],
    );
  }
}
