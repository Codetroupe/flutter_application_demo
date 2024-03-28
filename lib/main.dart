import 'package:flutter/material.dart';
import 'package:flutter_application_demo/routes/router.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

void main() {
  runApp(const NestedTabNavigationExampleApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
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

/// An example demonstrating how to use nested navigators
class NestedTabNavigationExampleApp extends StatelessWidget {
  /// Creates a NestedTabNavigationExampleApp
  const NestedTabNavigationExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
