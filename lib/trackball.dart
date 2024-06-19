import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_synchronization/model.dart';

void main() => runApp(const SynchronizedTrackball());

class SynchronizedTrackball extends StatelessWidget {
  const SynchronizedTrackball({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Synchronized Trackball',
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

TrackballBehavior trackball1 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);
TrackballBehavior trackball2 =
    TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap);

ChartSeriesController? _controller1;
ChartSeriesController? _controller2;
DataModel dataModel = DataModel();
Offset? _position;

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
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        trackball2.hide();
      },
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _position = _controller1!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          trackball2.show(_position!.dx, _position!.dy, 'pixel');
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
      trackballBehavior: trackball1,
      series: <LineSeries<SalesData, DateTime>>[
        LineSeries<SalesData, DateTime>(
          color: const Color.fromRGBO(99, 85, 199, 1),
          dataSource: dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          onRendererCreated: (ChartSeriesController controller) {
            _controller2 = controller;
          },
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
      onChartTouchInteractionUp: (ChartTouchInteractionArgs tapArgs) {
        _isInteractive = false;
        trackball1.hide();
      },
      onTrackballPositionChanging: (TrackballArgs trackballArgs) {
        if (_isInteractive) {
          _position = _controller2!.pointToPixel(
            trackballArgs.chartPointInfo.chartPoint!,
          );
          trackball1.show(_position!.dx, _position!.dy, 'pixel');
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
      trackballBehavior: trackball2,
      series: <LineSeries<SalesData, DateTime>>[
        LineSeries<SalesData, DateTime>(
          color: const Color.fromRGBO(99, 85, 199, 1),
          dataSource: dataModel.data,
          xValueMapper: (SalesData sales, int index) => sales.dateTime,
          yValueMapper: (SalesData sales, int index) => sales.y,
          onRendererCreated: (ChartSeriesController controller) {
            _controller1 = controller;
          },
        ),
      ],
    );
  }
}
