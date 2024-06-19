import 'package:charts_synchronization/selection.dart';
import 'package:charts_synchronization/trackball.dart';
import 'package:charts_synchronization/zoompan.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<String> items = [
    'Trackball',
    'ZoomPan',
    'Selection',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Charts Synchronization'),
          ),
          body: Center(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  onTap: () {
                    String title = 'Synchronized ${items[index]}';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('$title'),
                          ),
                          body: Center(
                            child: index == 0
                                ? SynchronizedTrackball()
                                : index == 1
                                    ? SynchronizedZoomPan()
                                    : SynchronizedSelection(),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )),
    );
  }
}
