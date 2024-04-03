// author:20254 on 2024/4/1 15:58
// email:junfengling88@gmail.com
// desc:
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

void main() {
  runApp(const RxDartApp());
}

class RxDartApp extends StatelessWidget {
  const RxDartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RxDartHomePage(title: 'Flutter RxDart Demo Home Page Test'),
    );
  }
}

class RxDartHomePage extends StatefulWidget {
  const RxDartHomePage({super.key, required this.title});

  final String title;

  @override
  State<RxDartHomePage> createState() => _RxDartHomePageState();
}

class _RxDartHomePageState extends State<RxDartHomePage> {
  final BehaviorSubject<int> _counterSubject = BehaviorSubject<int>.seeded(0);

  @override
  void dispose() {
    _counterSubject.close();
    super.dispose();
  }

  void _incrementCounter() {
    Timeline.startSync('fetchData');
    _counterSubject.add(_counterSubject.value + 1);
    Timeline.finishSync();
    Timeline.instantSync('customEvent',
        arguments: {'message': 'Custom event recorded'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<int>(
          stream: _counterSubject.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                'Counter: ${snapshot.data}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}