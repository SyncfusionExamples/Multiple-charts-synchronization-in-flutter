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

  MyApp({super.key});

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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                            title: Text('Synchronized ${items[index]}'),
                          ),
                          body: Center(
                            child: index == 0
                                ? const SynchronizedTrackball()
                                : index == 1
                                    ? const SynchronizedZoomPan()
                                    : const SynchronizedSelection(),
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
