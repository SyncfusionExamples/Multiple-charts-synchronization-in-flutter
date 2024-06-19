import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'model.dart';

void main() => runApp(const SynchronizedZoomPan());

class SynchronizedZoomPan extends StatelessWidget {
  const SynchronizedZoomPan({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized ZoomPan',
      home: MyHomePage(),
    );
  }
}

double zoomPosition = 0;
double zoomFactor = 1;
DateTimeAxisController? axisController1;
DateTimeAxisController? axisController2;
DataModel dataModel = DataModel();

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

class FirstChart extends StatefulWidget {
  const FirstChart({super.key});
  @override
  State<StatefulWidget> createState() {
    return FirstChartState();
  }
}

class FirstChartState extends State<FirstChart> {
  FirstChartState({Key? key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.x),
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == 'primaryXAxis') {
          zoomPosition = args.currentZoomPosition;
          zoomFactor = args.currentZoomFactor;
          axisController2!.zoomFactor = zoomFactor;
          axisController2!.zoomPosition = zoomPosition;
        }
      },
      primaryXAxis: DateTimeAxis(
          minimum: DateTime(2023, 02, 18),
          maximum: DateTime(2023, 08, 18),
          dateFormat: DateFormat.MMMd(),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0),
          onRendererCreated: (DateTimeAxisController controller) {
            axisController1 = controller;
          },
          initialZoomFactor: zoomFactor,
          initialZoomPosition: zoomPosition,
          name: 'primaryXAxis'),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
        name: 'primaryYAxis',
      ),
      title: const ChartTitle(text: 'Chart 1'),
      series: <SplineSeries<SalesData, DateTime>>[
        SplineSeries<SalesData, DateTime>(
          dataSource: dataModel.data,
          xValueMapper: (SalesData sales, _) => sales.dateTime,
          yValueMapper: (SalesData sales, _) => sales.y,
          color: const Color.fromRGBO(99, 85, 199, 1),
        )
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
  SecondChartState({Key? key});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: true,
          enableDoubleTapZooming: true,
          zoomMode: ZoomMode.x),
      onZooming: (ZoomPanArgs args) {
        if (args.axis!.name == 'primaryXAxis') {
          zoomPosition = args.currentZoomPosition;
          zoomFactor = args.currentZoomFactor;
          axisController1!.zoomFactor = zoomFactor;
          axisController1!.zoomPosition = zoomPosition;
        }
      },
      primaryXAxis: DateTimeAxis(
          minimum: DateTime(2023, 02, 18),
          maximum: DateTime(2023, 08, 18),
          dateFormat: DateFormat.MMMd(),
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          majorGridLines: const MajorGridLines(width: 0),
          onRendererCreated: (DateTimeAxisController controller) {
            axisController2 = controller;
          },
          initialZoomFactor: zoomFactor,
          initialZoomPosition: zoomPosition,
          name: 'primaryXAxis'),
      primaryYAxis: const NumericAxis(
        minimum: 0.85,
        maximum: 1,
        interval: 0.025,
      ),
      title: const ChartTitle(text: 'Chart 2'),
      series: <SplineSeries<SalesData, DateTime>>[
        SplineSeries<SalesData, DateTime>(
          dataSource: dataModel.data,
          xValueMapper: (SalesData sales, _) => sales.dateTime,
          yValueMapper: (SalesData sales, _) => sales.y,
          color: const Color.fromRGBO(99, 85, 199, 1),
        )
      ],
    );
  }
}
